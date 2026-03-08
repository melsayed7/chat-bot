import 'package:bloc/bloc.dart';
import 'package:chat_bot_app/feature/chat/data/models/chat_message_model.dart';
import 'package:chat_bot_app/feature/chat/domain/chat_repo.dart';
import 'package:meta/meta.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendMessageCubit({required this.chatRepo}) : super(SendMessageInitial());
  final ChatRepo chatRepo;

  Future<void> sendMessage({required List<ChatMessageModel> messages}) async {
    emit(SendMessageLoading());
    try {
      final chatMessage = await chatRepo.sendMessage(messages: messages);
      emit(SendMessageSuccess(chatMessageModel:  chatMessage));
    } catch (e) {
      emit(SendMessageError(error: e.toString()));
    }
  }
}


