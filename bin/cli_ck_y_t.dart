import 'package:cli_ck_y_t/core/exit_with_error.dart';
import 'package:cli_ck_y_t/args/parse_arguments.dart';
import 'package:cli_ck_y_t/download/download_video_stream.dart';

import 'dart:io';

void main(List<String> arguments) async {
  if (arguments.isEmpty) exitWithError('Empty Args', exit(1));

  var results = parseArguments(arguments);

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
