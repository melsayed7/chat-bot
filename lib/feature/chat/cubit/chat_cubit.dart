import 'package:chat_bot_app/feature/chat/model/chat_message_model.dart';
import 'package:chat_bot_app/feature/chat/repo/gemini_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final GeminiService geminiService;

  ChatCubit(this.geminiService) : super(ChatInitial());

  final List<ChatMessageModel> _messages = [];
  final List<Map<String, dynamic>> _history = [];

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // User message
    _messages.add(ChatMessageModel(text: text, isUser: true));
    _history.add({
      "role": "user",
      "parts": [
        {"text": text},
      ],
    });

    // Typing indicator
    _messages.add(
      ChatMessageModel(
        text: 'Gemini is typing...',
        isUser: false,
        isTyping: true,
      ),
    );

    emit(ChatLoading(List.from(_messages)));

    try {
      final reply = await geminiService.sendMessage(_history);

      // remove typing indicator
      _messages.removeWhere((m) => m.isTyping);

      // AI message
      _messages.add(ChatMessageModel(text: reply, isUser: false));
      _history.add({
        "role": "model",
        "parts": [
          {"text": reply},
        ],
      });

      emit(ChatSuccess(messages: List.from(_messages)));
    } catch (e) {
      // Remove typing indicator on error
      _messages.removeWhere((m) => m.isTyping);

      // Mark last user message as failed
      final index = _messages.lastIndexWhere((m) => m.isUser && m.text == text);

      if (index != -1) {
        _messages[index] = _messages[index].copyWith(isError: true);
      }
      emit(
        ChatSuccess(
          messages: List.from(_messages),
          showError: 'Failed to send message. SomeThing Wrong',
        ),
      );
      //emit(ChatError(e.toString()));
    }
  }

  void retryMessage(ChatMessageModel message) {
    // Remove failed message
    _messages.remove(message);

    // Remove last user history entry
    _history.removeLast();

    sendMessage(message.text);
  }
}
