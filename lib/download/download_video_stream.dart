import 'package:cli_ck_y_t/core/exit_with_error.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeDownloader {
  final YoutubeExplode yt;
  final String? id;
  late final StreamManifest manifest;

  YoutubeDownloader({required String url})
    : yt = YoutubeExplode(),
      id = VideoId(url).value;

  void printInfo() {
    print(yt);
    print(id);
  }

  void init() async {
    manifest = await yt.videos.streamsClient.getManifest(id);
  }

  void getAudioQualities() {
    print("Audio Qualities Available: ");
    for (var stream in manifest.audioOnly) {
      print('- ${stream.bitrate} kbps (${stream.container})');
    }
  }
}
