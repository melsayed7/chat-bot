part of 'send_message_cubit.dart';

@immutable
abstract class SendMessageState {}

class SendMessageInitial extends SendMessageState {}

class SendMessageLoading extends SendMessageState {}

class SendMessageSuccess extends SendMessageState {
  final ChatMessageModel chatMessageModel;

  SendMessageSuccess({required this.chatMessageModel});
}

class SendMessageError extends SendMessageState {
  final String error;

  SendMessageError({required this.error});
}
