import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_random_memes/get_it/get_it.dart';
import 'package:get_random_memes/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:get_random_memes/presentation/cubit/google_signin_cubit/google_signin_cubit.dart';

import 'package:get_random_memes/presentation/routes/app_router.dart';
import 'package:get_random_memes/presentation/routes/my_route_observer.dart';

class RandomMemesApp extends StatefulWidget {
  const RandomMemesApp({super.key});

  @override
  State<RandomMemesApp> createState() => _RandomMemesAppState();
}

class _RandomMemesAppState extends State<RandomMemesApp> {
  final AppRouter _appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AuthCubit>()..checkAuth(),
        ),
        BlocProvider(
          create: (_) => getIt<GoogleSigninCubit>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Random Meme App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        routerConfig: _appRouter.config(
          navigatorObservers: () => [
            MyRouteObserver(),
          ],
        ),
      ),
    );
  }
}
