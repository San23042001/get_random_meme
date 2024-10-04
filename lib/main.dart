import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_random_memes/app.dart';
import 'package:get_random_memes/data/model/random_meme_model.dart';
import 'package:get_random_memes/data/model/user/user.dart';
import 'package:get_random_memes/firebase_options.dart';
import 'package:get_random_memes/get_it/get_it.dart';
import 'package:get_random_memes/presentation/cubit/bloc_observer.dart';

import 'package:hive_flutter/adapters.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await Future.wait([
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
    Hive.initFlutter(),
  ]);
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(RandomMemeAdapter());
  Bloc.observer = MyBlocObserver();
  runApp(const RandomMemesApp());
}
