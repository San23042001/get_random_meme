import 'package:get_random_memes/constants/hive_constants.dart';
import 'package:get_random_memes/data/model/random_meme_model.dart';
import 'package:get_random_memes/logger.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

const String _h = 'meme_local_data_source';

abstract class MemeLocalDataSource {
  Future<void> cacheMemes(RandomMeme meme);
  Future<void> deleteMemes();
  Future<RandomMeme> getMemes();
}

@LazySingleton(as: MemeLocalDataSource)
class MemeLocalDataSourceImpl implements MemeLocalDataSource {
  @override
  Future<void> cacheMemes(RandomMeme meme) async {
    logDebug(_h, 'cacheMems : $meme');
    final Box accountBox = await Hive.openBox(HiveConstants.memeBoxName);

    return await accountBox.put(HiveConstants.memeKey, meme);
  }

  @override
  Future<void> deleteMemes() async {
    logWarning(_h, 'Deleted local Mems!');
    final box = await Hive.openBox(HiveConstants.memeBoxName);
    await box.delete(HiveConstants.memeKey);
  }

  @override
  Future<RandomMeme> getMemes() async {
    logDebug(_h, 'Get Cached Tags');
    final box = await Hive.openBox(HiveConstants.memeBoxName);
    return box.get(HiveConstants.memeKey);
  }
}
