import 'package:get_random_memes/domain/repository/meme_repository.dart';
import 'package:get_random_memes/get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class MemeDomainController {
  getNextMeme() async {
    return await getIt<MemeRepository>().getMeme();
  }
}
