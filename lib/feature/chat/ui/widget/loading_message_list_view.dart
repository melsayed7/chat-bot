import 'package:flutter/material.dart';

import '../../data/models/chat_message_model.dart';
import 'build_chat_bubble.dart';
import 'chat_loading_bubble.dart';

class LoadingMessagesListView extends StatelessWidget {
  const LoadingMessagesListView({Key? key, required this.history})
      : super(key: key);

  final List<ChatMessageModel> history;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: history.length + 1,
      itemBuilder: (context, index) {
        var newIndex = history.length - (index + 0);

        if (index == 0) {
          return ChatLoadingBubble();
        }

        final message = history[newIndex];
        final content = message.contents!.first;
        final text = content.parts!.first.text ?? '';

        return BuildChatBubble(text: text, isUser: content.isUser);
      },
    );
  }
}