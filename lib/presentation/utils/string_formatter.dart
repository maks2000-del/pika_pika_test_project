class StringFormatter {
  static String consvertUrlToId(String url) {
    final list = url.split('/');
    final idPosition = list.indexOf('pokemon') + 1;

    return list[idPosition];
  }
}
