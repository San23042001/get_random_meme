import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_random_memes/data/model/user/user.dart';
import 'package:get_random_memes/domain/entities/app_error.dart';
import 'package:get_random_memes/domain/repository/auth_repository.dart';
import 'package:get_random_memes/domain/repository/token_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
part 'google_signin_state.dart';

@LazySingleton()
class GoogleSigninCubit extends Cubit<GoogleSigninState> {
  final AuthRepository _authRepository;
  final TokenRepository _tokenRepository;

  final auth = firebase_auth.FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  GoogleSigninCubit(this._authRepository, this._tokenRepository)
      : super(GoogleSigninInitial());

  signinWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (isClosed) return;

      if (googleSignInAccount != null) {
        emit(GoogleSigninLoading());
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final firebase_auth.AuthCredential authCredential =
            firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        firebase_auth.UserCredential userCredential =
            await auth.signInWithCredential(authCredential);

        if (userCredential.user != null) {
          final idToken = await userCredential.user?.getIdToken();

          User userData = User(
              userName: userCredential.user?.displayName,
              email: userCredential.user?.email,
              profilePictureUrl: userCredential.user?.photoURL,
              mobileNumber: userCredential.user?.phoneNumber);

          await _authRepository.cacheUser(userData);

          await _tokenRepository.setAccessToken(idToken!);

          emit(GoogleSigninSuccess(userData));
        } else {
          emit(GoogleSigninError(AppError(
              type: AppErrorType.unknown,
              errorMessage: "No user from Firebase")));
        }
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      emit(GoogleSigninError(
          AppError(type: AppErrorType.unknown, errorMessage: e.toString())));
    }
  }

  googleSignOut() {
    try {
      googleSignIn.signOut();
      auth.signOut();
      emit(GoogleSignOutSuccess());
    } catch (e) {
      emit(GoogleSigninError(
          AppError(type: AppErrorType.unknown, errorMessage: e.toString())));
    }
  }
}
