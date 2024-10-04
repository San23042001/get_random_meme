import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_random_memes/core/expection/exception_handlers.dart';
import 'package:get_random_memes/core/token_service.dart';
import 'package:get_random_memes/domain/entities/custom_expection.dart';
import 'package:get_random_memes/logger.dart';
import 'package:injectable/injectable.dart';

const String _h = 'api_client';

@lazySingleton
class ApiClient {
  final Dio _dio;
  final TokenService _tokenService;

  ApiClient(this._dio, this._tokenService);

  dynamic get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresToken = true,
  }) async {
    logInfo(_h, 'GET : PATH:$path  QUERY PARAMS:$queryParameters');

    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Authorization':
                requiresToken ? 'Bearer ${await _tokenService.getToken()}' : '',
          },
        ),
      );
      final prettyResponse = _beautifyJson(response.data);
      logInfo(_h, 'Status Code : ${response.statusCode}');
      logInfo(_h, 'Response $prettyResponse');
      //debugPrint("\n\n\n${response.data}", wrapWidth: 2000);
      return _processResponse(response);
    } on DioException catch (e) {
      logError(_h, 'Dio Error: ${e.response?.data}');
      logErrorObject(_h, e, e.message ?? "");
      // debugPrint('Status Code : ${e.response?.statusCode}');
      // debugPrint('Status Message ${e.response?.statusMessage}');
      // debugPrint('Response ${e.response?.data}');
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw TimeoutException(e.message);
      }
      if (e.type == DioExceptionType.unknown) {
        if (e.error!.toString().contains('SocketException')) {
          throw const SocketException('');
        }
      }
      if (e.type == DioExceptionType.badResponse) {
        if (e.response?.statusCode == 102) {
          throw CustomException(errorCode: e.response?.statusCode);
        }
        if (e.response?.statusCode == 502) {
          throw CustomException(errorCode: e.response?.statusCode);
        }
        if (e.response?.statusCode == 401) {
          //navigationKey.currentState!.pushReplacementNamed(Routes.logout);
          throw CustomException(errorCode: e.response?.statusCode);
        }
        if (e.response?.statusCode == 400) {
          throw CustomException(
              errorCode: e.response?.statusCode,
              errorMessage: e.response?.data['message'] ??
                  e.response?.data['error'] ??
                  e.response?.statusMessage);
        }
        // if (e.response?.statusCode == 404) {
        //   throw CustomException(errorCode: e.response?.statusCode,
        //       errorMessage: e.response?.data['message']??
        //           e.response?.data['error'] ?? e.response?.statusMessage);
        // }
      }
      if (e.response?.data is Map<String, dynamic>) {
        throw CustomException(
            errorCode: e.response?.statusCode,
            errorMessage: e.response?.data['message'] ??
                e.response?.data['error'] ??
                e.response?.statusMessage);
      }
      throw CustomException(
          errorCode: e.response?.statusCode,
          errorMessage: e.response?.data['message'] ??
              e.response?.data['error'] ??
              e.response?.statusMessage);
    }
  }

  dynamic post(
    String path, {
    //Map<String, dynamic>? params,
    dynamic params,
    Map<String, dynamic>? queryParams,
    bool requiresToken = true,
    bool isFormData = false,
    FormData? formData,
  }) async {
    logInfo(_h, 'POST : PATH:$path  PARAMS:$params queryParams:$queryParams');
    try {
      if (formData != null) {
        // Log fields
        final fieldsLog = formData.fields
            .map((entry) => 'Key: ${entry.key}, Value: ${entry.value}')
            .join(', ');

        // Log files
        final filesLog = formData.files
            .map((entry) => 'Key: ${entry.key}, File: ${entry.value.filename}')
            .join(', ');

        logInfo(_h,
            'PATH:$path  FORMDATA:- \nFields: [$fieldsLog], \nFiles: [$filesLog]');
      }

      final response = await _dio.post(
        path,
        data: isFormData ? formData! : params,
        queryParameters: queryParams,
        options: Options(
          contentType: isFormData ? Headers.multipartFormDataContentType : null,
          headers: {
            'Authorization':
                requiresToken ? 'Bearer ${await _tokenService.getToken()}' : '',
          },
        ),
      );
      logSuccess(_h, 'Data: ${response.data}');
      //debugPrint("\n\n\n${response.data}", wrapWidth: 2000);

      return response.data;
    } on DioException catch (e) {
      logError(_h, 'Dio Error: ${e.response?.data}');
      logErrorObject(_h, e, e.message ?? "");
      // debugPrint('Status Code : ${e.response?.statusCode}');
      // debugPrint('Status Message ${e.response?.statusMessage}');
      // debugPrint('Response ${e.response?.data}');

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw TimeoutException(e.message);
      }
      if (e.type == DioExceptionType.unknown) {
        if (e.error!.toString().contains('SocketException')) {
          throw const SocketException('');
        }
      }
      if (e.type == DioExceptionType.badResponse) {
        if (e.response?.statusCode == 400) {
          throw CustomException(
              errorCode: e.response?.statusCode,
              errorMessage: e.response?.data['message'] ??
                  e.response?.data['error'] ??
                  e.response?.statusMessage);
        }
        if (e.response?.statusCode == 401) {
          throw CustomException(errorCode: e.response?.statusCode);
        }
        if (e.response?.statusCode == 422) {
          throw CustomException(
              errorCode: e.response?.statusCode,
              errorMessage:
                  e.response?.data['message'] ?? e.response?.statusMessage);
        }
        if (e.response?.statusCode == 406) {
          throw CustomException(
              errorCode: e.response?.statusCode,
              errorMessage:
                  e.response?.data['message'] ?? e.response?.statusMessage);
        }
        if (e.response?.statusCode == 102) {
          throw CustomException(errorCode: e.response?.statusCode);
        }
        if (e.response?.statusCode == 502) {
          throw CustomException(errorCode: e.response?.statusCode);
        }
        if (e.response?.statusCode == 500) {
          throw CustomException(errorCode: e.response?.statusCode);
        }
      }
      if (e.response?.data is Map<String, dynamic>) {
        throw CustomException(
            errorCode: e.response?.statusCode,
            errorMessage:
                e.response?.data['error'] ?? e.response?.statusMessage);
      }
      throw CustomException(
          errorCode: e.response?.statusCode,
          errorMessage: e.response?.statusMessage);
    }
  }
}

String _beautifyJson(Map<String, dynamic>? json) {
  if (json == null) {
    return 'null';
  }
  const encoder = JsonEncoder.withIndent('  ');
  return encoder.convert(json);
}

  dynamic _processResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.data;
        return responseJson;
      case 400: //Bad request
        throw BadRequestException(jsonDecode(response.data)['message']);
      case 401: //Unauthorized
        throw UnAuthorizedException(jsonDecode(response.data)['message']);
      case 403: //Forbidden
        throw UnAuthorizedException(jsonDecode(response.data)['message']);
      case 404: //Resource Not Found
        throw NotFoundException(jsonDecode(response.data)['message']);
      case 500: //Internal Server Error
      default:
        throw FetchDataException(
            'Something went wrong! ${response.statusCode}');
    }
  }