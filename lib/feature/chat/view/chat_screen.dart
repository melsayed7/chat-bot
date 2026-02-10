import 'package:chat_bot_app/core/theme/app_color.dart';
import 'package:chat_bot_app/core/theme/app_images.dart';
import 'package:chat_bot_app/feature/chat/cubit/chat_cubit.dart';
import 'package:chat_bot_app/feature/chat/cubit/chat_state.dart';
import 'package:chat_bot_app/feature/chat/widget/build_appBar.dart';
import 'package:chat_bot_app/feature/chat/widget/build_chat_bubble.dart';
import 'package:chat_bot_app/feature/chat/widget/build_input_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.lightWhiteColor,
        title: BuildAppBar(),
        actions: [
          SvgPicture.asset(AppSvg.volumeHigh),
          Padding(
            padding: const EdgeInsets.only(right: 29, left: 19),
            child: SvgPicture.asset(AppSvg.export),
          ),
        ],
      ),
      body: BlocListener<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is ChatSuccess && state.showError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.showError!),
                backgroundColor: Colors.red,
              ),
            );

            context.read<ChatCubit>().emit(state.copyWith(showError: null));
          }
        },
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  if (state is ChatInitial) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Start chatting 👋',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text('Send a message to get started '),
                      ],
                    );
                  }
                  // if (state is ChatError) {
                  //   return Center(child: Text(state.error));
                  // }
                  final messages = state is ChatSuccess
                      ? state.messages
                      : (state as ChatLoading).messages;

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    itemCount: messages.length,
                    itemBuilder: (context, index) => BuildChatBubble(
                      text: messages[index].text,
                      isUser: messages[index].isUser,
                      isTyping: messages[index].isTyping,
                      isError: messages[index].isError,
                    ),
                  );
                },
              ),
            ),
            BuildInputBar(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
