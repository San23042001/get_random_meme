import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_random_memes/data/model/meme_model.dart';
import 'package:get_random_memes/domain/entities/app_error.dart';
import 'package:get_random_memes/domain/repository/meme_repository.dart';
import 'package:injectable/injectable.dart';

part 'meme_cubit_state.dart';

@injectable
class MemeCubitCubit extends Cubit<MemeCubitState> {
  final MemeRepository _memeRepository;
  MemeCubitCubit(this._memeRepository) : super(MemeCubitInitial());

  void getMeme() async {
    emit(MemeCubitLoading());
    final res = await _memeRepository.getMeme();
    res.fold((l) => emit(MemeCubitError(error: l)),
        (r) => emit(MemeCubitSuccess(r)));
  }
}
