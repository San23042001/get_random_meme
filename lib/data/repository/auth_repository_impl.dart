import 'package:dartz/dartz.dart';
import 'package:get_random_memes/core/api/api_call_with_error.dart';
import 'package:get_random_memes/data/local/auth_local_data_source.dart';
import 'package:get_random_memes/data/local/token_local_data_source.dart';
import 'package:get_random_memes/data/model/user/user.dart';
import 'package:get_random_memes/domain/entities/app_error.dart';
import 'package:get_random_memes/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  late final AuthLocalDataSource _authLocalDataSource;
  late final TokenLocalDataSource _tokenLocalDataSource;

  AuthRepositoryImpl(this._authLocalDataSource, this._tokenLocalDataSource);

  @override
  Future<Either<AppError, void>> cacheUser(User user) async {
    return ApiCallWithError.call(
      () async {
        return await _authLocalDataSource.cacheUser(user);
      },
    );
  }

  @override
  Future<Either<AppError, User?>> getUser() async {
    return ApiCallWithError.call(
      () async {
        final res = await _authLocalDataSource.getUser();
        return res;
      },
    );
  }

  @override
  Future<Either<AppError, void>> logout() async {
    await Future.wait([
      _authLocalDataSource.deleteUser(),
      _tokenLocalDataSource.deleteAllTokens(),
    ]);
    return const Right(null);
  }
}
