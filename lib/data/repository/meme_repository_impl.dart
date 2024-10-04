import 'package:dartz/dartz.dart';
import 'package:get_random_memes/core/api/api_call_with_error.dart';
import 'package:get_random_memes/data/data_sources/remote/meme_remote_data_source.dart';
import 'package:get_random_memes/data/model/meme_model.dart';
import 'package:get_random_memes/domain/entities/app_error.dart';
import 'package:get_random_memes/domain/repository/meme_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: MemeRepository)
class MemeRepositoryImpl implements MemeRepository {
  final MemeRemoteDataSource _memeRemoteDataSource;

  MemeRepositoryImpl(this._memeRemoteDataSource);
  @override
  Future<Either<AppError, Meme>> getMeme() {
    return ApiCallWithError.call(() => _memeRemoteDataSource.getMeme());
  }
}
