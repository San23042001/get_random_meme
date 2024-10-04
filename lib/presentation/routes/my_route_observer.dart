import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_random_memes/logger.dart';


const String _h = 'route_observer';

class MyRouteObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    logInfo(_h, 'didPush ${route.toString()}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    logInfo(_h, 'didPop ${route.settings.name}');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    logInfo(_h, 'didRemove ${route.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    logInfo(_h, 'didReplace ${newRoute?.settings.name}');
  }
}
