import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get_random_memes/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:get_random_memes/presentation/cubit/google_signin_cubit/google_signin_cubit.dart';

import 'package:get_random_memes/presentation/routes/app_router.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<GoogleSigninCubit, GoogleSigninState>(
        listener: (context, state) {
          if (state is GoogleSigninSuccess) {
            context.read<AuthCubit>().updateAuth(state.user);
            Fluttertoast.showToast(msg: 'Signed in as ${state.user.userName}');

            context.replaceRoute(const RandomMemeRoute());
          }
          if (state is GoogleSigninError) {
            Fluttertoast.showToast(msg: state.error.errorMessage);
          }
        },
        builder: (context, state) {
          return Center(
            child: ElevatedButton(
              onPressed: (state is GoogleSigninLoading)
                  ? null
                  : () async {
                      context.read<GoogleSigninCubit>().signinWithGoogle();
                    },
              child: const Text('Sign In with Google'),
            ),
          );
        },
      ),
    );
  }
}
