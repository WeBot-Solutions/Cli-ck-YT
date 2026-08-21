import 'dart:collection';

import 'package:cli_ck_y_t/core/exit_with_error.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeDownloader {
  final YoutubeExplode yt;
  final String? id;
  StreamManifest? manifest;

  YoutubeDownloader({required String url})
    : yt = YoutubeExplode(),
      id = VideoId(url).value;

  void downloadMuxedVideo() async {

    manifest ??= await yt.videos.streamsClient.getManifest(id!);
    var streamInfo = manifest! .muxed.withHigestVideoQuality();
    
    // Get the actual byte stream
var stream = yt.video.streams.get(streamInfo);

// Open a file for writing.
var file = File(filePath);
var fileStream = file.openWrite();

// Pipe all the content of the stream into the file.
await stream.pipe(fileStream);

// Close the file.
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
    for (var stream in manifest!  .audioOnly) {
      print('- ${stream.bitrate} kbps (${stream.container})');
    }
  }
}
