extension StringExtension on String {
  bool isHttp() {
    final httpFormat = RegExp(r'^https?://');
    return httpFormat.hasMatch(this);
  }
}
