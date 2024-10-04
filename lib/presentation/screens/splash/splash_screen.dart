import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_random_memes/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:get_random_memes/presentation/routes/app_router.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }

        if (state is AuthError) {
          return Center(child: Text(state.error.errorMessage));
        }
        return const SizedBox();
      }, listener: (context, state) {
        if (state is AuthError) {
          context.replaceRoute(const LoginRoute());
        }
        if (state is Unauthenticated) {
          context.replaceRoute(const LoginRoute());
        }
        if (state is Authenticated) {
          context.replaceRoute(const RandomMemeRoute());
        }
      }),
    );
  }
}
