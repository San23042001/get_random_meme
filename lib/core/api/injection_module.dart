import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_random_memes/core/api/api_constants.dart';
import 'package:injectable/injectable.dart';

@module
abstract class InjectionModule {
  @Named('baseUrl')
  String get baseUrl => ApiConstants.baseUrl;

  @lazySingleton
  Dio dio(@Named('baseUrl') String baseUrl) => Dio(BaseOptions(
        baseUrl: baseUrl,
        contentType: Headers.jsonContentType,
        connectTimeout: const Duration(minutes: 5),
        receiveTimeout: const Duration(minutes: 5),
        sendTimeout: const Duration(minutes: 5),
      ));

  @lazySingleton
  Connectivity connectivity() => Connectivity();
}
