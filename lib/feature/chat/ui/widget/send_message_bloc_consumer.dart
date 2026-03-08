import 'package:chat_bot_app/feature/chat/ui/cubit/send_message_cubit.dart';
import 'package:chat_bot_app/feature/chat/ui/cubit/send_message_cubit.dart';
import 'package:chat_bot_app/feature/chat/ui/widget/success_message_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/chat_message_model.dart';
import 'failure_message_list_view.dart';
import 'loading_message_list_view.dart';

class SendMessageBlocConsumer extends StatelessWidget {
  SendMessageBlocConsumer({Key? key, required this.history}) : super(key: key);

  List<ChatMessageModel> history;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendMessageCubit, SendMessageState>(
      listener: (context, state) {
        if (state is SendMessageSuccess) {
          history.add(state.chatMessageModel);
        }
      },
      builder: (context, state) {
        if (state is SendMessageSuccess) {
          return SuccessMessagesListView(history: history);
        } else if (state is SendMessageLoading) {
          return LoadingMessagesListView(history: history);
        } else if (state is SendMessageError) {
          return FailureMessageListView(history: history);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
