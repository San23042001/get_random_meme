import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_random_memes/data/model/random_meme_model.dart';
import 'package:get_random_memes/domain/entities/app_error.dart';
import 'package:get_random_memes/domain/repository/random_meme_repository.dart';
import 'package:injectable/injectable.dart';

part 'random_meme_state.dart';

@injectable
class RandomMemeCubit extends Cubit<RandomMemeState> {
  final RandomMemeRepository _randomMemeRepository;
  List<String> _memeIds = [];

  RandomMemeCubit(this._randomMemeRepository) : super(RandomMemeInitial()) {
    _loadMemeIds();
  }

  void _loadMemeIds() async {
    final res = await _randomMemeRepository.getAllMemeIds();
    res.fold(
      (error) => emit(RandomMemeError(error)),
      (ids) {
        _memeIds = ids;
        // Load a random meme once IDs are loaded
        loadRandomMeme();
      },
    );
  }

  void loadRandomMeme() {
    if (_memeIds.isEmpty) return;
    final randomId = _memeIds[Random().nextInt(_memeIds.length)];
    if (kDebugMode) {
      print('Loading meme with ID: $randomId');
    } // Debug log
    getMeme(randomId);
  }

  void getMeme(String memeId) async {
    emit(RandomMemeLoading());
    final res = await _randomMemeRepository.getMeme(memeId);
    res.fold(
      (l) {
        if (kDebugMode) {
          print('Error loading meme: ${l.errorMessage}');
        } // Debug log
        emit(RandomMemeError(l));
      },
      (r) {
        if (kDebugMode) {
          print('Meme loaded successfully');
        } // Debug log
        emit(RandomMemeLoaded(r));
      },
    );
  }
}
