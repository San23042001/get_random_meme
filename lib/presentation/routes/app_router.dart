import 'package:auto_route/auto_route.dart';
import 'package:get_random_memes/presentation/screens/login/login_screen.dart';
import 'package:get_random_memes/presentation/screens/random_meme_screen.dart';
import 'package:get_random_memes/presentation/screens/splash/splash_screen.dart';
import 'package:injectable/injectable.dart';

part 'app_router.gr.dart';

@LazySingleton()
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RandomMemeRoute.page)
      ];
}
