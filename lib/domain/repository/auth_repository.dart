import 'package:dartz/dartz.dart';
import 'package:get_random_memes/data/model/user/user.dart';
import 'package:get_random_memes/domain/entities/app_error.dart';

abstract class AuthRepository {
  Future<Either<AppError, User?>> getUser();

  Future<Either<AppError, void>> cacheUser(User user);

  Future<Either<AppError, void>> logout();
}
