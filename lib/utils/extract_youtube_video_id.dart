String? extractYouTubeVideoId(String url) {
  final regex = RegExp(
    r'(?:youtube\.com\/shorts\/|youtu\.be\/|youtube\.com\/watch\?v=|youtube\.com\/embed\/|youtube\.com\/v\/)([a-zA-Z0-9_-]{11})',
    caseSensitive: false,
  );
  final match = regex.firstMatch(url);
  return match?.group(1);
}
