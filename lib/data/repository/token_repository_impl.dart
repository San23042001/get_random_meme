import 'package:get_random_memes/data/local/token_local_data_source.dart';
import 'package:get_random_memes/domain/repository/token_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TokenRepository)
class TokenRepositoryImpl implements TokenRepository {
  final TokenLocalDataSource _tokenLocalDataSource;

  TokenRepositoryImpl(this._tokenLocalDataSource);

  @override
  Future<void> clearTokens() async =>
      await _tokenLocalDataSource.deleteAllTokens();

  @override
  Future<String?> getAccessToken() async =>
      await _tokenLocalDataSource.getAccessToken();

  @override
  Future<void> setAccessToken(String accessToken) async =>
      await _tokenLocalDataSource.cacheAccessToken(accessToken);
}