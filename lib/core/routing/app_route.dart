import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/feature/chat/data/repos/gemenai_chat_repo_impl.dart';
import 'package:chat_bot_app/feature/chat/data/services/gemenai_chat_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../feature/chat/ui/chat_screen.dart';
import '../../feature/chat/ui/cubit/send_message_cubit.dart';
import '../../feature/onBoarding_screen/onBoarding_screen.dart';

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
