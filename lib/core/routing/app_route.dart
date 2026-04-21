import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:flutter/material.dart';

import '../../feature/chat/ui/chat_screen.dart';
import '../../feature/onBoarding_screen/on_boarding_screen.dart';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case Routes.chat:
        return MaterialPageRoute(
          builder: (_) => ChatScreen());
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
