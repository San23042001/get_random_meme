import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_random_memes/data/local/token_local_data_source.dart';
import 'package:get_random_memes/domain/entities/unauthorised_exception.dart';
import 'package:get_random_memes/domain/repository/token_repository.dart';
import 'package:get_random_memes/get_it/get_it.dart';
import 'package:get_random_memes/logger.dart';
import 'package:get_random_memes/presentation/routes/app_router.dart';
import 'package:injectable/injectable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

const String _h = 'token_service';

@lazySingleton
class TokenService {
  final TokenRepository _tokenRepository;

  TokenService(this._tokenRepository);

  Future<String> getToken() async {
    final String? accessToken = await _tokenRepository.getAccessToken();
    //final String? refreshToken = await _tokenRepository.getRefreshToken();
    //if (accessToken == null || refreshToken == null) {
    if (accessToken == null) {
      getIt<AppRouter>().replaceAll([const LoginRoute()]);
      Fluttertoast.showToast(msg: 'Session expired. Please login again');
      throw UnauthorisedException();
    } else if (JwtDecoder.isExpired(accessToken)) {
      logFatal(_h, null, 'Access token is expired');

      await Future.wait([
        // getIt<AuthLocalDataSource>().deleteUser(),
        getIt<TokenLocalDataSource>().deleteAllTokens(),
      ]);
      getIt<AppRouter>().replaceAll([const LoginRoute()]);

      Fluttertoast.showToast(msg: 'Session expired. Please login again');
      throw UnauthorisedException();

      // if (JwtDecoder.isExpired(refreshToken)) {
      //   logFatal(_h, null, 'Refresh token is expired');
      //   NavigationService.instance.navigationKey.currentState!.pushNamedAndRemoveUntil(Routes.logout, (route) => false);
      //   Fluttertoast.showToast(msg: 'Session expired. Please login again');
      //   throw UnauthorisedException();
      // } else {
      //   try {
      //     final response = await _dio.post(
      //       ApiConstants.refreshTokenEndPoint,
      //       data: {"refreshToken": refreshToken},
      //       // options:
      //       //     Options(headers: {'Authorisation': 'Bearer $refreshToken'})
      //     );
      //     if (response.statusCode == 200) {
      //       final Map<String, dynamic> body = response.data['data'];
      //       final String accessToken = body['accessToken'];
      //       await _tokenRepository.setAccessToken(accessToken);
      //       return accessToken;
      //     }
      //     throw "Unauthorised";
      //   } on DioError {
      //     rethrow;
      //   }
      // }
    } else {
      logDebugFine(_h, accessToken);
      return accessToken;
    }
  }
}
