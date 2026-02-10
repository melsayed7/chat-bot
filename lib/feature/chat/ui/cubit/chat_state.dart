part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final ChatMessageModel chatMessageModel;

  ChatSuccess({required this.chatMessageModel});
}

class ChatError extends ChatState {
  final String error;

  ChatError({required this.error});
}
