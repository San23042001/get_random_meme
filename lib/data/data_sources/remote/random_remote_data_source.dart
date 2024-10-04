import 'package:get_random_memes/core/api/api_client.dart';
import 'package:get_random_memes/core/api/api_constants.dart';

import 'package:get_random_memes/data/model/random_meme_model.dart';
import 'package:get_random_memes/logger.dart';
import 'package:injectable/injectable.dart';

abstract class RandomMemeRemoteDataSource {
  Future<RandomMeme> getMeme(String memeId);
  Future<List<String>> getAllMemeIds();
}

@LazySingleton(as: RandomMemeRemoteDataSource)
class RandomMemeRemoteDataSourceImpl implements RandomMemeRemoteDataSource {
  final ApiClient _client;

  RandomMemeRemoteDataSourceImpl(this._client);

  @override
  Future<RandomMeme> getMeme(String memeId) async {
    final res = await _client.get(ApiConstants.baseUrl);
    // Access the 'data' key first, then 'memes'
    final List memes = res['data']['memes'];

    try {
      final meme = memes.firstWhere(
        (meme) => meme['id'].toString() == memeId,
        orElse: () => null, // Provide a default value if no meme is found
      );

      if (meme == null) {
        throw Exception('Meme with ID $memeId not found');
      }

      logError("Response", 'Response: $meme');
      return RandomMeme.fromJson(meme);
    } catch (e) {
      // Handle other potential errors here
      logError("Error", e.toString());
      rethrow; // Optionally rethrow the error after logging
    }
  }

  @override
  Future<List<String>> getAllMemeIds() async {
    final res = await _client.get(ApiConstants.baseUrl);
    final List memes = res['data']['memes'];
    return memes.map<String>((meme) => meme['id'].toString()).toList();
  }
}
