
import 'package:chat_bot_app/core/network/api_client.dart';
import 'package:chat_bot_app/feature/chat/data/repos/gemenai_chat_repo_impl.dart';
import 'package:chat_bot_app/feature/chat/data/services/gemenai_chat_services.dart';
import 'package:chat_bot_app/feature/chat/domain/chat_repo.dart';
import 'package:chat_bot_app/feature/chat/ui/cubit/send_message_cubit.dart';
import 'package:get_it/get_it.dart';

var getit = GetIt.instance;

void setupGetIt(){

  getit.registerSingleton<ApiClient>(ApiClient());
  getit.registerSingleton<GemenaiChatServices>(GemenaiChatServices(apiClient: getit<ApiClient>()));
  getit.registerSingleton<ChatRepo>(GemenaiChatRepoImpl(gemenaiChatServices: getit<GemenaiChatServices>()));

  getit.registerFactory<SendMessageCubit>(() => SendMessageCubit(chatRepo: getit<ChatRepo>()),);
}