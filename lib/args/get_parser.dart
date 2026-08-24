import 'package:args/args.dart';

ArgParser getParser() {
  var parser = ArgParser()
    ..addOption('url', abbr: 'u', help: 'Youtube Video Url')
    ..addFlag(
      'audio-only',
      abbr: 'a',
      help: 'Download only Audio`s video',
      defaultsTo: false,
    )
    ..addOption('quality', abbr: 'q', help: 'Set Video Quality, default: 480p')
    ..addFlag(
      "help",
      abbr: 'h',
      help: "show info about how to use",
      defaultsTo: false,
    ) // Marcos estuvo aqui
    ..addOption('output', abbr: 'o', help: 'Video Output Name');

  return parser;
}
