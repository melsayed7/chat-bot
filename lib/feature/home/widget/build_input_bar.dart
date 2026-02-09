import 'package:chat_bot_app/core/theme/app_color.dart';
import 'package:chat_bot_app/feature/home/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildInputBar extends StatelessWidget {
  BuildInputBar({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 56,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColor.lightWhiteColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Write your message",
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.mic , size: 20,)
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 28,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white,),
              onPressed: () {
                context.read<ChatCubit>().sendMessage(controller.text);
                controller.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
