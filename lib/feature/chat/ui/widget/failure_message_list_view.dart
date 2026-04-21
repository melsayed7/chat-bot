import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/chat_message_model.dart';
import '../cubit/send_message_cubit.dart';
import 'build_chat_bubble.dart';
import 'chat_failure_bubble.dart';

class FailureMessageListView extends StatelessWidget {
  const FailureMessageListView({super.key, required this.history});
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
          return ChatFailureBubble(
            errorMessage: "error message",
            lastMessage: history.last.contents![0].parts?[0].text ?? '',
            onResend: () =>
                context.read<SendMessageCubit>().sendMessage(messages: history),
          );
        }

        final message = history[newIndex];
        final content = message.contents!.first;
        final text = content.parts!.first.text ?? '';

        return Visibility(
          visible: !(index == 1),
          child: BuildChatBubble(text: text, isUser: content.isUser),
        );
      },
    );
  }
}