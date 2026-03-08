import 'package:flutter/material.dart';

class ChatFailureBubble extends StatelessWidget {
  final String errorMessage;
  final String lastMessage;
  final VoidCallback onResend;

  const ChatFailureBubble({
    Key? key,
    required this.errorMessage,
    required this.lastMessage,
    required this.onResend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight, // user side
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(4),
            bottomLeft: Radius.circular(20),
          ),
          border: Border.all(color: Colors.red.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Error header
            Row(
              children: const [
                Icon(Icons.error_outline,
                    color: Colors.red, size: 16),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Failed to send message',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// Last message text
            Text(
              lastMessage,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 12),

            /// Resend button
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: onResend,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.refresh, size: 16, color: Colors.red),
                      SizedBox(width: 6),
                      Text(
                        "Resend",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

