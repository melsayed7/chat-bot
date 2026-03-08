import 'package:chat_bot_app/core/network/api_client.dart';
import 'package:chat_bot_app/feature/chat/data/models/chat_message_model.dart';

import '../../../../core/helper/should_retry.dart';

class GemenaiChatServices {
  final ApiClient _apiClient;

  GemenaiChatServices({required ApiClient apiClient}) : _apiClient = apiClient;

  static const int _maxRetries = 3;

  Future<ChatMessageModel> sendMessage({
    required List<ChatMessageModel> messages,
  }) async {
    int attempt = 0;

    while (true) {
      try {
        attempt++;

        /// Build request body
        final body = {
          'contents': messages
              .where((m) => m.contents?.first.role == 'user')
              .map((m) => m.contents!.first.toJson())
              .toList(),
        };

        final response = await _apiClient.post(
          '/gemini-2.5-flash-lite:generateContent',
          queryParameters: {"key": "AIzaSyAzJJiqOiGiTtX9iOjobUiRMa87n66iKKo"},
          data: body,
        );

        /// Map Gemini response
        final candidates = response.data['candidates'] as List<dynamic>;
        final modelContent = candidates.first['content'];

        return ChatMessageModel(contents: [Contents.fromJson(modelContent)]);
      } catch (error) {
        ///  retry
        if (attempt >= _maxRetries || !shouldRetry(error)) {
          rethrow;
        }

        ///  delay
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }
  }
}

///
// class GemenaiChatServices {
//   final ApiClient _apiClient;
//
//   GemenaiChatServices({required ApiClient apiClient}) : _apiClient = apiClient;
//
//   Future<ChatMessageModel> sendMessage({
//     required List<ChatMessageModel> messages,
//   }) async {
//     /// Build request body
//
//     final body = {
//       'contents': messages
//           .where((m) => m.contents?.first.role == 'user')
//           .map((m) => m.contents!.first.toJson())
//           .toList(),
//     };
//
//     final response = await _apiClient.post(
//       '/gemini-2.5-flash-lite:generateContent',
//       queryParameters: {"key": "AIzaSyAzJJiqOiGiTtX9iOjobUiRMa87n66iKKo"},
//       data: body,
//     );
//
//     /// Map Gemini response
//     final candidates = response.data['candidates'] as List<dynamic>;
//     final modelContent = candidates.first['content'];
//
//     return ChatMessageModel(contents: [Contents.fromJson(modelContent)]);
//   }
// }

// gemini-2.5-flash-lite:generateContent
//gemini-3-flash-preview:generateContent
///
