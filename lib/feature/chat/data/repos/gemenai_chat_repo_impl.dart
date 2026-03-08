import 'package:chat_bot_app/core/mixin/chat_service_validator_mixin.dart';
import 'package:chat_bot_app/feature/chat/data/models/chat_message_model.dart';
import 'package:chat_bot_app/feature/chat/data/services/gemenai_chat_services.dart';
import 'package:chat_bot_app/feature/chat/domain/chat_repo.dart';

class GemenaiChatRepoImpl extends ChatRepo with ChatServiceValidatorMixin {
  final GemenaiChatServices _gemenaiChatServices;

  GemenaiChatRepoImpl({required GemenaiChatServices gemenaiChatServices})
    : _gemenaiChatServices = gemenaiChatServices;

  @override
  Future<ChatMessageModel> sendMessage({
    required List<ChatMessageModel> messages,
  }) async {
    validateInput(messages: messages);

    final response = await _gemenaiChatServices.sendMessage(messages: messages);

    validateOutput(response: response);

    return response;
  }
}
