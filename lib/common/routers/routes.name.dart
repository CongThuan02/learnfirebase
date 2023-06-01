class RouteConfigName {
  static const DEFAULT = "/";
  static const HOMEPAGE = "/home-page";
  static const LOGIN = "/login";

  static String passParams(String routeName, Map<String, dynamic> params, {Map<String, dynamic>? appends}) {
    routeName = mapParamsToRoute(routeName, params);
    if (appends == null) return routeName;
    return appendParamsToRoute(routeName, appends);
  }

  static String mapParamsToRoute(String route, Map<String, dynamic> params) {
    params.forEach((key, value) {
      route = route.replaceAll(':$key', value);
    });
    return route;
  }

  static String appendParamsToRoute(String route, Map<String, dynamic> params) {
    List<MapEntry> list = params.entries.toList();
    String result = route;
    for (var i = 0; i < list.length; i++) {
      if (i == 0) {
        result += "?${list[i].key}=${list[i].value}";
      } else {
        result += "&${list[i].key}=${list[i].value}";
      }
    }
    return result;
  }
}
