import 'dart:io';

import 'package:cli_ck_y_t/args/show_help.dart';
import 'package:cli_ck_y_t/args/get_parser.dart';
import 'package:cli_ck_y_t/download/download_video_stream.dart';

import 'package:cli_ck_y_t/utils/extract_youtube_video_id.dart';

void main(List<String> arguments) async {
  print('loading...');
  var parser = getParser();
  var results = parser.parse(arguments);

  // Option Values
  var url = results['url'] as String?;
  var audioSelected = results['audio-only'] as bool;

  if (arguments.isEmpty || results['help'] || url == null) {
    showHelp(parser);
    return;
  }

  var yt = YoutubeDownloader();
  var videoId = extractYouTubeVideoId(url);

  if (videoId == null) {
    showHelp(parser);
    return;
  }

  await yt.getManifest(videoId);

  audioSelected ? await yt.downloadAudio() : await yt.downloadMuxedVideo();
}
