String parseAuthenticate(String source, String attribute) {
  String result = "";

  attribute += "=";
  if (source.contains(attribute)) {
    for (int i = source.indexOf(attribute) + attribute.length; i < source.length && source[i] != '&'; i++) {
      result += source[i];
    }
  }
  return result;
}

Map<String, String> getRangedMap(Map<String, String> map, int begin, int end) {
  Map<String, String> newMap = new Map<String, String>();

  for (int i = begin; i < map.length && (end < 0 || i <= end); i++) {
    var element = map.entries.elementAt(i);
    newMap[element.key] = element.value;
  }

  return newMap;
}