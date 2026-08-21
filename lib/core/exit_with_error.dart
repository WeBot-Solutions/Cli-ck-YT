import 'dart:io';

void exitWithError(String error, int exitType) {
  stderr.writeln(error);
  exit(exitType);
}
