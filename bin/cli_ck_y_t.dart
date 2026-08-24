import 'package:cli_ck_y_t/args/show_help.dart';
import 'package:cli_ck_y_t/core/exit_with_error.dart';
import 'package:cli_ck_y_t/args/get_parser.dart';
import 'package:cli_ck_y_t/download/download_video_stream.dart';

import 'dart:io';

void main(List<String> arguments) async {
  var parser = getParser();
  var results = parser.parse(arguments);

  if (arguments.isEmpty || results['help']) showHelp(parser);

  // Option Values
  var url = results['url'] as String?;
  var outputName = results['output'] as String?;
  var audioSelected = results['audio-only'] as bool;

  if (url != null) {
    var yt = YoutubeDownloader();
    await yt.getManifest(url);

    audioSelected ? yt.downloadAudio() : yt.downloadMuxedVideo();
  }
}
