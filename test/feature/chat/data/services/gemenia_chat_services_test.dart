import 'package:chat_bot_app/core/network/api_client.dart';
import 'package:chat_bot_app/feature/chat/data/models/chat_message_model.dart';
import 'package:chat_bot_app/feature/chat/data/services/gemenai_chat_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late MockApiClient apiClient;
  late GemenaiChatServices service;

  setUp(() {
    apiClient = MockApiClient();
    service = GemenaiChatServices(apiClient: apiClient);
  });
  final fakeMessages = [
    ChatMessageModel(contents: [Contents.fromUserMessage('Hello Gemini')]),
  ];
  final successMessage = {
    'candidates': [
      {
        'content': {
          'parts': [
            {'text': 'hello'},
          ],
          'role': 'model',
        },
      },
    ],
  };

  final successResponse = Response(
    requestOptions: RequestOptions(path: ''),
    data: successMessage,
    statusCode: 200,
  );

  test('should retry 3 times on failure', () async {
    when(
      () => apiClient.post(
        any(),
        queryParameters: any(named: 'queryParameters'),
        data: any(named: 'data'),
      ),
    ).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.connectionError,
      ),
    );

    await expectLater(
      () => service.sendMessage(messages: fakeMessages),
      throwsA(isA<DioException>()),
    );

    verify(
      () => apiClient.post(
        any(),
        queryParameters: any(named: 'queryParameters'),
        data: any(named: 'data'),
      ),
    ).called(3);
  });

  test('success on third attempt', () async {
    var count = 0;
    when(
      () => apiClient.post(
        any(),
        queryParameters: any(named: 'queryParameters'),
        data: any(named: 'data'),
      ),
    ).thenAnswer((_) async {
      count++;
      if (count == 3) {
        return successResponse;
      }
      throw DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.connectionError,
      );
    });

    final result = await service.sendMessage(messages: fakeMessages);
    expect(result, isA<ChatMessageModel>());

    verify(
      () => apiClient.post(
        any(),
        queryParameters: any(named: 'queryParameters'),
        data: any(named: 'data'),
      ),
    ).called(3);
  });

  test('success on second attempt', () async {
    var count = 0;
    when(
          () => apiClient.post(
        any(),
        queryParameters: any(named: 'queryParameters'),
        data: any(named: 'data'),
      ),
    ).thenAnswer((_) async {
      count++;
      if (count == 2) {
        return successResponse;
      }
      throw DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.connectionError,
      );
    });

    final result = await service.sendMessage(messages: fakeMessages);
    expect(result, isA<ChatMessageModel>());

    verify(
          () => apiClient.post(
        any(),
        queryParameters: any(named: 'queryParameters'),
        data: any(named: 'data'),
      ),
    ).called(2);
  });

  test('retries 3 times on timeout then throws', () async {
    when(
      () => apiClient.post(
        any(),
        queryParameters: any(named: 'queryParameters'),
        data: any(named: 'data'),
      ),
    ).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.connectionTimeout,
      ),
    );

    /// expect
    await expectLater(
      () => service.sendMessage(messages: fakeMessages),
      throwsA(isA<DioException>()),
    );

    /// verify retries count
    verify(
      () => apiClient.post(
        any(),
        queryParameters: any(named: 'queryParameters'),
        data: any(named: 'data'),
      ),
    ).called(3);
  });

  test('does not retry on 400 error', () async {
    when(
      () => apiClient.post(
        any(),
        queryParameters: any(named: 'queryParameters'),
        data: any(named: 'data'),
      ),
    ).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 400,
        ),
      ),
    );

    await expectLater(
      () => service.sendMessage(messages: fakeMessages),
      throwsA(isA<DioException>()),
    );

    verify(
      () => apiClient.post(
        any(),
        queryParameters: any(named: 'queryParameters'),
        data: any(named: 'data'),
      ),
    ).called(1);
  });
}
