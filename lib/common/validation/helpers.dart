shift(List l) {
  if (l.isNotEmpty) {
    var first = l.first;
    l.removeAt(0);
    return first;
  }
  return null;
}

Map merge(Map? obj, defaults) {
  obj ??= {};
  defaults.forEach((key, val) => obj!.putIfAbsent(key, () => val));
  return obj;
}
