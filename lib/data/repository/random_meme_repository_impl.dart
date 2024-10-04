import 'package:dartz/dartz.dart';
import 'package:get_random_memes/core/api/api_call_with_error.dart';
import 'package:get_random_memes/data/data_sources/remote/random_remote_data_source.dart';

import 'package:get_random_memes/data/model/random_meme_model.dart';
import 'package:get_random_memes/domain/entities/app_error.dart';
import 'package:get_random_memes/domain/repository/random_meme_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RandomMemeRepository)
class RandomMemeRepositoryImpl implements RandomMemeRepository {
  final RandomMemeRemoteDataSource _randomMemeRemoteDataSource;

  RandomMemeRepositoryImpl(this._randomMemeRemoteDataSource);
  @override
  Future<Either<AppError, RandomMeme>> getMeme(String memeId) {
    return ApiCallWithError.call(
        () => _randomMemeRemoteDataSource.getMeme(memeId));
  }

  @override
  Future<Either<AppError, List<String>>> getAllMemeIds() {
    return ApiCallWithError.call(
        () => _randomMemeRemoteDataSource.getAllMemeIds());
  }

  @override
  Future<List<String>> getAllMemesIds() {
    return _randomMemeRemoteDataSource.getAllMemeIds();
  }

  @override
  Future<RandomMeme> getMemes(String memeId) {
    return _randomMemeRemoteDataSource.getMeme(memeId);
  }
}
