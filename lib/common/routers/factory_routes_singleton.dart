
import 'package:go_router/go_router.dart';

import '../../injection.dart';
import '../configs/service_location.dart';
import '../storage/_localStorage.dart';
import 'routes.name.dart';
import 'routes.package.dart';

class FactoryNavRoutesSingleton {
  static final FactoryNavRoutesSingleton _instance = FactoryNavRoutesSingleton._internal();

  factory FactoryNavRoutesSingleton() {
    return _instance;
  }

  FactoryNavRoutesSingleton._internal();

  final GoRouter _items = routerGoRoutes;
  GoRouter get items => _items;

  void offAll() {
    LocalStorage.clear();
    final _navigatorKey = locator<NavigationService>().navigatorKey;

    _navigatorKey.currentContext!.go(RouteConfigName.DEFAULT);
  }
}
