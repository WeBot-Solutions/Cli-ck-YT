import 'package:args/args.dart';

import 'dart:io';

void showHelp(ArgParser parser) {
  final programName = Platform.script.pathSegments.last;
  print('''
 CLI-Ck YT

Uso: dart $programName [opciones]

${parser.usage}

Ejemplos:
  dart $programName -u https://youtube.com/shorts/_6HzLIJPH2A?si=znltF99g82qpVw_a --audio-only
  dart $programName -u https://youtu.be/fJ9rUzIMcZQ?si=Dq_2EKelBmhbFjnM 
''');
}
