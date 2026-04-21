
import 'package:chat_bot_app/feature/chat/data/models/chat_message_model.dart';
import 'package:chat_bot_app/feature/chat/domain/chat_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendMessageCubit({required this.chatRepo}) : super(SendMessageInitial());
  final ChatRepo chatRepo;

  Future<void> sendMessage({required List<ChatMessageModel> messages}) async {
    if (isClosed) return;
    emit(SendMessageLoading());
    try {
      final chatMessage = await chatRepo.sendMessage(messages: messages);
      if (isClosed) return;
      emit(SendMessageSuccess(chatMessageModel: chatMessage));
    } catch (e) {
      if (isClosed) return;
      emit(SendMessageError(error: e.toString()));
    }
  }

}
