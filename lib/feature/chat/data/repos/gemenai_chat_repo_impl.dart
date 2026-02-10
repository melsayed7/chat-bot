import 'package:chat_bot_app/feature/chat/data/models/chat_message_model.dart';
import 'package:chat_bot_app/feature/chat/data/services/gemenai_chat_services.dart';
import 'package:chat_bot_app/feature/chat/domain/chat_repo.dart';

class GemenaiChatRepoImpl extends ChatRepo {
  GemenaiChatServices _gemenaiChatServices;

  GemenaiChatRepoImpl({required GemenaiChatServices gemenaiChatServices})
    : _gemenaiChatServices = gemenaiChatServices;

  @override
  Future<ChatMessageModel> sendMessage({
    required List<ChatMessageModel> messages,
  }) async {
    return _gemenaiChatServices.sendMessage(messages: messages);
  }
}
