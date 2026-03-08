import 'package:chat_bot_app/core/helper/setup_get_it.dart';
import 'package:chat_bot_app/core/theme/app_color.dart';
import 'package:chat_bot_app/core/theme/app_images.dart';
import 'package:chat_bot_app/feature/chat/data/models/chat_message_model.dart';
import 'package:chat_bot_app/feature/chat/ui/cubit/send_message_cubit.dart';
import 'package:chat_bot_app/feature/chat/ui/widget/build_appBar.dart';
import 'package:chat_bot_app/feature/chat/ui/widget/build_input_bar.dart';
import 'package:chat_bot_app/feature/chat/ui/widget/send_message_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);

  final List<ChatMessageModel> history = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getit<SendMessageCubit>(),
      child: Scaffold(
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
        body: Column(
          children: [
            Expanded(child: SendMessageBlocConsumer(history: history)),
            BuildInputBar(history: history),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
