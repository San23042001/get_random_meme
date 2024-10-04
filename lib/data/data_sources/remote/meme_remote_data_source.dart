import 'dart:convert';

import 'package:get_random_memes/core/api/api_client.dart';
import 'package:get_random_memes/core/api/api_constants.dart';
import 'package:get_random_memes/data/model/meme_model.dart';
import 'package:get_random_memes/logger.dart';
import 'package:injectable/injectable.dart';

abstract class MemeRemoteDataSource {
  Future<Meme> getMeme();
}

@LazySingleton(as: MemeRemoteDataSource)
class MemeRemoteDataSourceImpl implements MemeRemoteDataSource {
  final ApiClient _client;

  MemeRemoteDataSourceImpl(this._client);

  @override
  Future<Meme> getMeme() async {
    final res = await _client.get(ApiConstants.baseUrl);
    Map<String, dynamic> response = jsonDecode(res);
    logError("Response", 'Response: $response');
    return Meme.fromJson(response);
  }
}
