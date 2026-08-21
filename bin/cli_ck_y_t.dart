import 'package:cli_ck_y_t/core/constants.dart';
import 'package:cli_ck_y_t/core/exit_with_error.dart';
import 'package:cli_ck_y_t/args/parse_arguments.dart';
import 'package:cli_ck_y_t/download/download_video_stream.dart';

import 'dart:io';

void main(List<String> arguments) {
  if (arguments.isEmpty) exitWithError('Empty Args', exit(1));

  var results = parseArguments(arguments);

  // Option Values
  var url = results['url'] as String?;
  var quality = results['quality'] as String? ?? defaultQuality;
  var outputName = results['output'] as String?;

  if (url != null) {
    var ytDownloader = YoutubeDownloader(url: url);
    ytDownloader.getAudioQualities();
  }
}
