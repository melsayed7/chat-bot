import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../core/theme/app_color.dart';

class ChatLoadingBubble extends StatelessWidget {
  const ChatLoadingBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft, // model side
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
            bottomLeft: Radius.circular(4),
          ),
        ),
        child: SizedBox(
          height: 24,
          width: 40,
          child: LoadingIndicator(
            indicatorType: Indicator.ballPulse,
            colors: [AppColor.blackColor],
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}
