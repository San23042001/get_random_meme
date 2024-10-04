import 'package:dartz/dartz.dart';

import 'package:get_random_memes/data/model/random_meme_model.dart';
import 'package:get_random_memes/domain/entities/app_error.dart';

abstract class RandomMemeRepository {
  Future<Either<AppError, RandomMeme>> getMeme(String memeId);
  Future<Either<AppError, List<String>>> getAllMemeIds();

    Future<RandomMeme> getMemes(String memeId);
  Future<List<String>> getAllMemesIds();
}
