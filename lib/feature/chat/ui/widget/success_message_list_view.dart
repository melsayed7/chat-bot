import 'package:chat_bot_app/feature/chat/ui/cubit/send_message_cubit.dart';
import 'package:chat_bot_app/feature/chat/ui/widget/chat_failure_bubble.dart';
import 'package:chat_bot_app/feature/chat/ui/widget/chat_loading_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/chat_message_model.dart';
import 'build_chat_bubble.dart';

class SuccessMessagesListView extends StatelessWidget {
  SuccessMessagesListView({Key? key, required this.history}) : super(key: key);

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
