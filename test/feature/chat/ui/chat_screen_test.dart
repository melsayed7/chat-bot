import 'package:chat_bot_app/core/helper/setup_get_it.dart';
import 'package:chat_bot_app/feature/chat/data/models/chat_message_model.dart';
import 'package:chat_bot_app/feature/chat/domain/chat_repo.dart';
import 'package:chat_bot_app/feature/chat/ui/widget/build_chat_bubble.dart';
import 'package:chat_bot_app/feature/chat/ui/widget/chat_failure_bubble.dart';
import 'package:chat_bot_app/feature/chat/ui/widget/chat_loading_bubble.dart';
import 'package:chat_bot_app/feature/chat/ui/widget/failure_message_list_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'chat_robot.dart';

class ChatMockRepo extends Mock implements ChatRepo {}

void main() {
  late ChatMockRepo chatMockRepo;

  setUp(() async {
    await getit.reset();
    setupGetIt();
    await getit.unregister<ChatRepo>();
    chatMockRepo = ChatMockRepo();
    getit.registerLazySingleton<ChatRepo>(() => chatMockRepo);
  });

  group("test sending chat flow", () {
    // testWidgets('send message and show loading bubble widget', (tester) async  {
    //   ChatRobot chatRobot = ChatRobot(tester: tester);
    //   when(
    //     () => chatMockRepo.sendMessage(messages: any(named: 'messages')),
    //   ).thenAnswer((_) async {
    //     return Future.delayed(Duration(seconds: 2), () {
    //       return ChatMessageModel(
    //         contents: [
    //           Contents(
    //             parts: [Parts(text: 'response')],
    //             role: 'model',
    //           ),
    //         ],
    //       );
    //     });
    //   });
    //
    //   await chatRobot.runApp();
    //   await chatRobot.entreText(text: 'hello');
    //   await chatRobot.sendButton();
    //   await tester.pump();
    //   expect(find.byType(BuildChatBubble), findsOneWidget);
    //   expect(find.byType(ChatLoadingBubble), findsOneWidget);
    // });
    testWidgets('send message and receive response message', (tester) async {
      ChatRobot chatRobot = ChatRobot(tester: tester);
      when(
        () => chatMockRepo.sendMessage(messages: any(named: 'messages')),
      ).thenAnswer((_) {
        return Future.delayed(Duration(seconds: 2), () {
          return ChatMessageModel(
            contents: [
              Contents(
                parts: [Parts(text: 'response')],
                role: 'model',
              ),
            ],
          );
        });
      });

      await chatRobot.runApp();
      await chatRobot.entreText(text: 'hello');
      await chatRobot.sendButton();
      await tester.pumpAndSettle();
      expect(
        find.descendant(
          of: find.byType(BuildChatBubble),
          matching: find.text('hello'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(BuildChatBubble),
          matching: find.text('response'),
        ),
        findsOneWidget,
      );
    });
    testWidgets('send message and receive failure message', (tester) async {
      ChatRobot chatRobot = ChatRobot(tester: tester);
      when(
        () => chatMockRepo.sendMessage(messages: any(named: 'messages')),
      ).thenAnswer((_) async {
        await Future.delayed(Duration(seconds: 2), () {});
        throw Exception();
      });

      await chatRobot.runApp();
      await chatRobot.entreText(text: 'hello');
      await chatRobot.sendButton();
      await tester.pumpAndSettle();
      expect(
        find.descendant(
          of: find.byType(FailureMessageListView),
          matching: find.text('hello'),
        ),
        findsOneWidget,
      );
    });
    testWidgets('retry sending message and succeed ', (tester) async {
      ChatRobot chatRobot = ChatRobot(tester: tester);
      var count = 0;
      when(
        () => chatMockRepo.sendMessage(messages: any(named: 'messages')),
      ).thenAnswer((_) async {
        await Future.delayed(Duration(seconds: 2), () {});
        if (count == 1) {
          return ChatMessageModel(
            contents: [
              Contents(
                parts: [Parts(text: 'response')],
                role: 'model',
              ),
            ],
          );
        }
        count++;
        throw Exception();
      });

      await chatRobot.runApp();
      await chatRobot.entreText(text: 'hello');
      await chatRobot.sendButton();
      await tester.pumpAndSettle();
      await chatRobot.resendButton();
      expect(
        find.descendant(
          of: find.byType(BuildChatBubble),
          matching: find.text('hello'),
        ),
        findsOneWidget,
      );

      expect(
        find.descendant(
          of: find.byType(BuildChatBubble),
          matching: find.text('response'),
        ),
        findsOneWidget,
      );
    });
    testWidgets('sending message and fails on 5th attempt', (tester) async {
      ChatRobot chatRobot = ChatRobot(tester: tester);
      var count = 0;
      when(
            () => chatMockRepo.sendMessage(messages: any(named: 'messages')),
      ).thenAnswer((_) async {
        await Future.delayed(Duration(seconds: 2), () {});
        if (count == 4) {
          throw Exception();
        }
        count++;
        return ChatMessageModel(
          contents: [
            Contents(
              parts: [Parts(text: 'response')],
              role: 'model',
            ),
          ],
        );
      });

      await chatRobot.runApp();

      await chatRobot.entreText(text: 'hello');
      await chatRobot.sendButton();
      await tester.pumpAndSettle();

      await chatRobot.entreText(text: 'hello');
      await chatRobot.sendButton();
      await tester.pumpAndSettle();

      await chatRobot.entreText(text: 'hello');
      await chatRobot.sendButton();
      await tester.pumpAndSettle();

      await chatRobot.entreText(text: 'hello');
      await chatRobot.sendButton();
      await tester.pumpAndSettle();

      await chatRobot.entreText(text: 'hello');
      await chatRobot.sendButton();
      await tester.pumpAndSettle();

      await chatRobot.resendButton();

      expect(
        find.descendant(
          of: find.byType(BuildChatBubble),
          matching: find.text('hello'),
        ),
        findsExactly(3),
      );

      expect(
        find.descendant(
          of: find.byType(ChatFailureBubble),
          matching: find.text('hello'),
        ),
        findsOneWidget,
      );
    });
  });
}
