import 'package:args/args.dart';

import 'dart:io';

void showHelp(ArgParser parser) {
  final programName = Platform.script.pathSegments.last;
  print('''
 CLI-Ck YT

Uso: $programName [opciones]

${parser.usage}

Ejemplos:
  $programName -u https://youtube.com/shorts/_6HzLIJPH2A?si=znltF99g82qpVw_a --audio-only
  $programName -u https://youtu.be/fJ9rUzIMcZQ?si=Dq_2EKelBmhbFjnM 
''');
}
