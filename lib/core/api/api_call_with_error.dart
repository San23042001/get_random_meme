import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_random_memes/domain/entities/app_error.dart';

class ApiCallWithError {
  const ApiCallWithError._();

  static Future<Either<AppError, T>> call<T>(Future<T> Function() f) async {
    try {
      final res = await f();
      return Right(res);
    } on SocketException {
      return Left(
        AppError(
          type: AppErrorType.network,
        ),
      );
    } on TimeoutException {
      return Left(
        AppError(
          type: AppErrorType.timeout,
        ),
      );
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return Left(
            AppError(
              type: AppErrorType.timeout,
            ),
          );
        case DioExceptionType.badResponse:
          {
            final data = e.response?.data;
            if (data is Map) {
              return Left(
                AppError(
                  type: AppErrorType.api,
                  errorCode: e.response?.statusCode,
                  errorMessage: data['errorMessage'],
                  cta1: data['cta1'],
                  cta2: data['cta2'],
                  errorDescription: data['errorDescription'],
                ),
              );
            }
            return Left(
              AppError(
                type: AppErrorType.api,
                errorCode: e.response?.statusCode,
                errorMessage: e.response?.statusMessage,
              ),
            );
          }
        case DioExceptionType.unknown:
          {
            if (e.error is SocketException) {
              return Left(
                AppError(
                  type: AppErrorType.network,
                ),
              );
            }
            return Left(
              AppError(
                type: AppErrorType.unknown,
              ),
            );
          }
        default:
          return Left(
            AppError(
              type: AppErrorType.api,
            ),
          );
      }
    } on Exception {
      return Left(
        AppError(
          type: AppErrorType.api,
        ),
      );
    }
  }
}
