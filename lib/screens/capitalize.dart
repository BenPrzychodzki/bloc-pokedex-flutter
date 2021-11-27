/// Used for capitalize strings (e.g. pokemon names)
String capitalize(String string) {
  if (string.isEmpty) {
    return string;
  }
  return string[0].toUpperCase() + string.substring(1);
}
