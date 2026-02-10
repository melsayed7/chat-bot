import 'package:bloc/bloc.dart';
import 'package:chat_bot_app/feature/chat/data/models/chat_message_model.dart';
import 'package:chat_bot_app/feature/chat/domain/chat_repo.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required this.chatRepo}) : super(ChatInitial());
  final ChatRepo chatRepo;

  Future<void> sendMessage({required List<ChatMessageModel> messages}) async {
    emit(ChatLoading());
    try {
      final chatMessage = await chatRepo.sendMessage(messages: messages);
      emit(ChatSuccess(chatMessageModel:  chatMessage));
    } catch (e) {
      emit(ChatError(error: e.toString()));
    }
  }
}
