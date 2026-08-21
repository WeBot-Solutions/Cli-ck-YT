import 'package:args/args.dart';

ArgResults parseArguments(List<String> args) {
  var parser = ArgParser()
    ..addOption('url', abbr: 'u', help: 'Youtube Video Url')
    ..addOption('quality', abbr: 'q', help: 'Set Video Quality, default: 480p')
    ..addOption('output', abbr: 'o', help: 'Video Output Name');

  return parser.parse(args);
}
