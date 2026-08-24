String? extractYouTubeVideoId(String url) {
  final regex = RegExp(
    r'(?:v=|shorts\/|youtu\.be\/|embed\/|v\/)([a-zA-Z0-9_-]{11})(?:[?&]|$)',
    caseSensitive: false,
  );
  final match = regex.firstMatch(url);
  return match?.group(1);
}
