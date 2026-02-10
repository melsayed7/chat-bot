import 'package:chat_bot_app/feature/chat/model/chat_message_model.dart';
import 'package:equatable/equatable.dart';


abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {
  final List<ChatMessageModel> messages;

  const ChatLoading(this.messages);

  @override
  List<Object?> get props => [messages];
}

class ChatSuccess extends ChatState {
  final List<ChatMessageModel> messages;
  final String? showError;

  const ChatSuccess({required this.messages, this.showError});

  ChatSuccess copyWith({List<ChatMessageModel>? messages , String? showError }){
    return ChatSuccess(
      messages: messages ?? this.messages,
      showError: showError,
    );
  }

  @override
  List<Object?> get props => [messages,showError];
}

class ChatError extends ChatState {
  final String error;

  const ChatError(this.error);

  @override
  List<Object?> get props => [error];
}
