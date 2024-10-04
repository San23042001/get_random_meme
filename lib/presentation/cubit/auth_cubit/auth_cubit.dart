import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_random_memes/data/model/user/user.dart';
import 'package:get_random_memes/domain/entities/app_error.dart';
import 'package:get_random_memes/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';

@LazySingleton()
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;

  AuthCubit(this._repository) : super(AuthInitial());

  void checkAuth() async {
    emit(AuthLoading());
    final res = await _repository.getUser();
    if (isClosed) return;
    res.fold(
      (l) => emit(AuthError(l)),
      (r) {
        if (r == null) {
          emit(Unauthenticated());
        } else {
          emit(Authenticated(r));
        }
      },
    );
  }

  void updateAuth(User user) async {
    emit(Authenticated(user));
  }

  void logout() async {
    await _repository.logout();
    emit(Unauthenticated());
  }
}
