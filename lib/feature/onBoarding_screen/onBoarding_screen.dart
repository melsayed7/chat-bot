import 'package:chat_bot_app/core/helper/extensions.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/core/theme/app_color.dart';
import 'package:chat_bot_app/core/theme/app_images.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:72,bottom: 14),
                child: Center(
                  child: Text(
                    'You AI Assistant',
                    style: TextStyle(
                      color: AppColor.blueColor,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 250,
                child: Text(
                  'Using this software,you can ask you questions and receive articles using artificial intelligence assistant',
                  style: TextStyle(
                    color: AppColor.grayColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 84),
              Image.asset(AppImage.onBoarding),
              Spacer(),
              GestureDetector(
                onTap: () => context.pushNamed(Routes.chat),
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColor.blueColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 90),
                      Text(
                        'Continue',
                        style: TextStyle(
                          color: AppColor.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(width: 90),
                      Icon(Icons.arrow_forward, color: AppColor.whiteColor,)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 34),
            ],
          ),
        ),
      ),
    );
  }
}
