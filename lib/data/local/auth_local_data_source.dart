import 'package:get_random_memes/constants/hive_constants.dart';
import 'package:get_random_memes/data/model/user/user.dart';
import 'package:get_random_memes/logger.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

const String _h = 'account_local_data_source';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(User user);

  Future<void> deleteUser();

  Future<User?> getUser();
}



@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<void> cacheUser(User user) async {
    logDebug(_h, 'CacheUser : $user');
    final Box accountBox = await Hive.openBox(
      HiveConstants.userBoxName,
    );
    return await accountBox.put(HiveConstants.userKey, user);
  }

  @override
  Future<void> deleteUser() async {
    logWarning(_h, 'Deleted local User !');
    final box = await Hive.openBox(HiveConstants.userBoxName);
    await box.delete(HiveConstants.userKey);
  }

  @override
  Future<User?> getUser() async {
    logDebug(_h, 'Get Cached User');
    final box = await Hive.openBox(HiveConstants.userBoxName);
    return box.get(HiveConstants.userKey);
  }
}
