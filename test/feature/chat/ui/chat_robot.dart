import 'package:chat_bot_app/feature/chat/ui/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class ChatRobot {
  final WidgetTester tester;

  ChatRobot({required this.tester});

  Future<void> runApp() async {
    await tester.pumpWidget(MaterialApp(home: ChatScreen()));
    await tester.pumpAndSettle();
  }

  Future<void> entreText({required String text}) async {
    var inputType = find.byType(TextFormField);
    await tester.enterText(inputType, text);
    await tester.pumpAndSettle();
  }

  Future<void> sendButton() async {
    var buttonType = find.byIcon(Icons.send);
    await tester.tap(buttonType);
  }

  Future<void> resendButton() async {
    var buttonType = find.byIcon(Icons.refresh);
    await tester.tap(buttonType);
    await tester.pumpAndSettle();
  }

}
