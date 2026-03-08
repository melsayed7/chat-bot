import 'package:chat_bot_app/core/mixin/chat_service_validator_mixin.dart';
import 'package:chat_bot_app/feature/chat/data/models/chat_message_model.dart';
import 'package:flutter_test/flutter_test.dart';

class ChatServiceValidatorMixinMock with ChatServiceValidatorMixin {}

void main() {
  late ChatServiceValidatorMixinMock chatServiceValidatorMixinMock;
  setUp(() {
    chatServiceValidatorMixinMock = ChatServiceValidatorMixinMock();
  });
  group('Gemenai Chat Rep Impl test ', () {
    group('Input validation', () {
      test('throws when messages list is empty', () async {
        final messages = <ChatMessageModel>[];

        expect(
          () => chatServiceValidatorMixinMock.validateInput(messages: messages),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('throws when last message contents is empty', () async {
        final messages = [ChatMessageModel(contents: [])];

        expect(
          () => chatServiceValidatorMixinMock.validateInput(messages: messages),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('throws when last message is not from user', () async {
        final messages = [
          ChatMessageModel(
            contents: [
              Contents(
                role: 'model',
                parts: [Parts(text: 'Hello')],
              ),
            ],
          ),
        ];

        expect(
          () => chatServiceValidatorMixinMock.validateInput(messages: messages),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('throws when message text is empty', () async {
        final messages = [
          ChatMessageModel(contents: [Contents.fromUserMessage('   ')]),
        ];

        expect(
          () => chatServiceValidatorMixinMock.validateInput(messages: messages),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('Output validation', () {
      test('throws when response contents is empty', () async {
        final invalidResponse = ChatMessageModel(contents: []);

        expect(
          () => chatServiceValidatorMixinMock.validateOutput(
            response: invalidResponse,
          ),
          throwsA(isA<FormatException>()),
        );
      });

      test('throws when response role is not model', () async {
        final invalidResponse = ChatMessageModel(
          contents: [
            Contents(
              role: 'user',
              parts: [Parts(text: 'Hi')],
            ),
          ],
        );

        expect(
          () => chatServiceValidatorMixinMock.validateOutput(
            response: invalidResponse,
          ),
          throwsA(isA<FormatException>()),
        );
      });

      test('throws when response text is empty', () async {
        final invalidResponse = ChatMessageModel(
          contents: [
            Contents(
              role: 'model',
              parts: [Parts(text: '   ')],
            ),
          ],
        );

        expect(
          () => chatServiceValidatorMixinMock.validateOutput(
            response: invalidResponse,
          ),
          throwsA(isA<FormatException>()),
        );
      });
    });
  });
}
