import 'dart:collection';
import 'dart:io';

import 'package:cli_ck_y_t/core/exit_with_error.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeDownloader {
  final YoutubeExplode yt;
  String? outputName;
  final String? id;
  StreamManifest? manifest;

  YoutubeDownloader({required String url, String? output})
    : yt = YoutubeExplode(),
      outputName = output,
      id = VideoId(url).value;

  void downloadMuxedVideo() async {
    manifest ??= await yt.videos.streamsClient.getManifest(id!);
    var streamInfo = manifest!.muxed.bestQuality;
    var stream = yt.videos.streams.get(streamInfo);
    outputName ??= 'exampleName';
    var file = File(outputName!);

    var fileStream = file.openWrite();
    await stream.pipe(fileStream);

    await fileStream.flush();
    await fileStream.close();
  }

  void printInfo() {
    print(yt);
    print(id);
  }

  Future<void> getAudioQualities() async {
    manifest ??= await yt.videos.streamsClient.getManifest(id!);
    print("Audio Qualities Available: ");
    for (var stream in manifest!.audioOnly) {
      print('- ${stream.bitrate} kbps (${stream.container})');
    }
  }
}
