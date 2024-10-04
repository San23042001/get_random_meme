import 'package:dartz/dartz.dart';
import 'package:get_random_memes/data/model/meme_model.dart';
import 'package:get_random_memes/domain/entities/app_error.dart';

abstract class MemeRepository {
  Future<Either<AppError, Meme>> getMeme();
}
