import 'package:chat_bot_app/core/theme/app_color.dart';
import 'package:chat_bot_app/core/theme/app_images.dart';
import 'package:flutter/material.dart';

class BuildAppBar extends StatelessWidget {
  const BuildAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(AppImage.robot),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ChatGPT',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColor.blueColor,
              ),
            ),
            SizedBox(height: 2),
            Text('● Online',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColor.greenColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
