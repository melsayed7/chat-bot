import '../../feature/chat/data/models/chat_message_model.dart';

mixin ChatServiceValidatorMixin {

  void validateInput({required List<ChatMessageModel> messages}) {
    if (messages.isEmpty) {
      throw ArgumentError('Messages list cannot be empty');
    }

    final lastMessage = messages.last;

    if (lastMessage.contents == null || lastMessage.contents!.isEmpty) {
      throw ArgumentError('Message contents cannot be empty');
    }

    final lastContent = lastMessage.contents!.last;

    if (!lastContent.isUser) {
      throw ArgumentError('Last message must be from user');
    }

    final inputText = lastContent.parts
        ?.map((p) => p.text)
        .join()
        .trim() ??
        '';

    if (inputText.isEmpty) {
      throw ArgumentError('Message text cannot be empty');
    }
  }

  void validateOutput({required ChatMessageModel response}) {
    if (response.contents == null || response.contents!.isEmpty) {
      throw FormatException('Response contents cannot be empty');
    }

    if(response.contents!.first.parts!.isEmpty){
      throw FormatException('Response contents cannot be empty');
    }

    final content = response.contents!.first;

    if (content.role != 'model') {
      throw FormatException('Response must be from model');
    }

    final outputText = content.parts
        ?.map((p) => p.text)
        .join()
        .trim() ??
        '';

    if (outputText.isEmpty) {
      throw FormatException('Response text cannot be empty');
    }
  }
}