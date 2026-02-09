import 'package:chat_bot_app/core/theme/app_color.dart';
import 'package:chat_bot_app/core/theme/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../cubit/chat_cubit.dart';
import '../model/chat_message_model.dart';

class BuildChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  final bool isTyping;
  final bool isError;

  const BuildChatBubble({
    super.key,
    required this.text,
    required this.isUser,
    this.isTyping = false,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: isUser ? _userBubble(context) : _robotBubble(context),
      ),
    );
  }

  /// User
  List<Widget> _userBubble(BuildContext context) {
    return [_bubble(context), const SizedBox(width: 8), _avatar(AppImage.user)];
  }

  ///  Robot
  List<Widget> _robotBubble(BuildContext context) {
    return [_avatar(AppImage.robot), const SizedBox(width: 8), _bubble(context)];
  }

  /// Chat bubble
  Widget _bubble(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      constraints: const BoxConstraints(maxWidth: 280),
      decoration: BoxDecoration(
        color: isUser ? AppColor.blueColor : AppColor.lightGrayColor,
        borderRadius: isUser
            ? const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              )
            : const BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
      ),
      child: isTyping
          ? SizedBox(
              height: 20,
              width: 40,
              child: LoadingIndicator(
                indicatorType: Indicator.ballPulse,
                colors: [AppColor.blackColor],
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: isUser ? AppColor.whiteColor : AppColor.blackColor,
                    ),
                  ),
                ),

                if (isUser && isError) ...[
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      context.read<ChatCubit>().retryMessage(
                        ChatMessageModel(text: text, isUser: true),
                      );
                    },
                    child: const Icon(
                      Icons.refresh,
                      color: Colors.red,
                      size: 18,
                    ),
                  ),
                ],
              ],
            ),
    );
  }

  /// Avatar widget
  Widget _avatar(String asset) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: AppColor.lightGrayColor,
      child: Image.asset(asset, width: 28, height: 28, fit: BoxFit.contain),
    );
  }
}
