import 'package:chat_bot_app/core/theme/app_color.dart';
import 'package:chat_bot_app/core/theme/app_images.dart';
import 'package:flutter/material.dart';

class BuildChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const BuildChatBubble({super.key, required this.text, required this.isUser});

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
    return [
      _avatar(AppImage.robot),
      const SizedBox(width: 8),
      _bubble(context),
    ];
  }

  /// Chat bubble
  Widget _bubble(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
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
      child: Text(
        text,
        style: TextStyle(
          color: isUser ? AppColor.whiteColor : AppColor.blackColor,
        ),
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
