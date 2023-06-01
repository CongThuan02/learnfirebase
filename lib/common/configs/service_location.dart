import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../injection.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  BuildContext get navigatorContext => navigatorKey.currentState!.context;

  void setupNavigator() {
    locator.registerLazySingleton(() => NavigationService());
  }

  Future<void> toNamed(
    String page, {
    Map<String, String>? parameters,
  }) async {
    if (parameters != null) {
      final uri = Uri(path: page, queryParameters: parameters);
      page = uri.toString();
    }
    await Future.delayed(const Duration(seconds: 0), () => navigatorContext.push(page));
  }
}
