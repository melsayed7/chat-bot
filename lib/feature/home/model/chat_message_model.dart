class ChatMessageModel {
  final String text;
  final bool isUser;
  final bool isTyping;
  final bool isError;

  ChatMessageModel({
    required this.text,
    required this.isUser,
    this.isTyping = false,
    this.isError = false,
  });

  ChatMessageModel copyWith({bool? isTyping, bool? isError}) {
    return ChatMessageModel(
      text: text,
      isUser: isUser,
      isTyping: isTyping ?? this.isTyping,
      isError: isError ?? this.isError,
    );
  }
}
