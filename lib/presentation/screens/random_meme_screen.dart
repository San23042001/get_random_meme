import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_random_memes/get_it/get_it.dart';
import 'package:get_random_memes/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:get_random_memes/presentation/cubit/google_signin_cubit/google_signin_cubit.dart';

import 'package:get_random_memes/presentation/cubit/random_meme/random_meme_cubit.dart';
import 'package:get_random_memes/presentation/routes/app_router.dart';

@RoutePage()
class RandomMemeScreen extends StatelessWidget implements AutoRouteWrapper {
  const RandomMemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocConsumer<GoogleSigninCubit, GoogleSigninState>(
            listener: (context, state) {
              if (state is GoogleSignOutSuccess) {
                Fluttertoast.showToast(msg: 'Signed Out!');
                context.router.replaceAll([const LoginRoute()]);
              }
              if (state is GoogleSigninError) {
                Fluttertoast.showToast(msg: state.error.errorMessage);
              }
            },
            builder: (context, state) {
              return IconButton(
                  onPressed: (state is GoogleSigninLoading)
                      ? null
                      : () async {
                          context.read<GoogleSigninCubit>().googleSignOut();
                          context.read<AuthCubit>().logout();
                        },
                  icon: const Icon(Icons.logout));
            },
          )
        ],
      ),
      body: BlocBuilder<RandomMemeCubit, RandomMemeState>(
        builder: (context, state) {
          if (state is RandomMemeLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          if (state is RandomMemeLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.meme.name,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.network(
                  state.meme.url,
                ),
              ],
            );
          }
          if (state is RandomMemeError) {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.error.errorMessage),
                    TextButton(
                      onPressed: () {
                        context.read<RandomMemeCubit>().loadRandomMeme();
                      },
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.skip_next),
        onPressed: () {
          context.read<RandomMemeCubit>().loadRandomMeme();
        },
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RandomMemeCubit>()..loadRandomMeme(),
      child: this,
    );
  }
}
