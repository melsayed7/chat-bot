import 'package:chat_bot_app/core/network/api_client.dart';
import 'package:chat_bot_app/feature/chat/data/models/chat_message_model.dart';

class GemenaiChatServices {
  final ApiClient _apiClient = ApiClient();

  Future<ChatMessageModel> sendMessage({
    required List<ChatMessageModel> messages,
  }) async {
    final response = await _apiClient.post(
      '/gemini-3-flash-preview:generateContent',
      data: {"contents": messages.map((message) => message.toJson()).toList()},
    );
    return ChatMessageModel.fromJson(response);
  }
}
