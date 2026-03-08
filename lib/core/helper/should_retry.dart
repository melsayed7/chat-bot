import 'package:dio/dio.dart';

bool shouldRetry(Object error) {
  if (error is DioException) {
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.connectionError;
  }

  return false;
}