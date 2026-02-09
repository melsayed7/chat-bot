import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/feature/home/cubit/chat_cubit.dart';
import 'package:chat_bot_app/feature/home/repo/gemini_service.dart';
import 'package:chat_bot_app/feature/home/view/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../feature/onBoarding_screen/onBoarding_screen.dart';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case Routes.chat:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(
                create: (context) => ChatCubit(GeminiService()),
                child: ChatScreen(),
              ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
          const Scaffold(
            body: Center(child: Text('No route defined for this path')),
          ),
        );
    }
  }
}
