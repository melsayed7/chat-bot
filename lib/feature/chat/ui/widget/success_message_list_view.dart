import 'package:flutter/material.dart';

import '../../data/models/chat_message_model.dart';
import 'build_chat_bubble.dart';

class SuccessMessagesListView extends StatelessWidget {
  const SuccessMessagesListView({super.key, required this.history});

  final List<ChatMessageModel> history;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: history.length,
      itemBuilder: (context, index) {
        var reversedMessage = history.reversed.toList();
        final message = reversedMessage[index];
        final content = message.contents!.first;
        final text = content.parts!.first.text ?? '';

        return BuildChatBubble(text: text, isUser: content.isUser);
      },
    );
  }
}
