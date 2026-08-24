import 'dart:io';

import 'package:cli_ck_y_t/utils/bytes_to_megabytes.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeDownloader {
  final YoutubeExplode yt;
  late String _id;
  StreamManifest? _manifest;

  YoutubeDownloader() : yt = YoutubeExplode();

  Future<void> _youtubeDownloader(StreamInfo streamInfo) async {
    var stream = yt.videos.streams.get(streamInfo);

    var videoInfo = await yt.videos.get(_id);

    var (fileStream, filename) = getFileStream(
      streamInfo: streamInfo,
      videoName: videoInfo.title,
    );

    // Download Progress

    stdout.writeln('Descargando: $filename');

    var totalBytes = streamInfo.size.totalBytes;
    var downloadedBytes = 0;

    await for (final chunk in stream) {
      fileStream.add(chunk);
      downloadedBytes += chunk.length;

      printDownloadInfo(
        streamInfo: streamInfo,
        downloadedBytes: downloadedBytes,
        totalBytes: totalBytes,
      );
    }

    stdout.writeln('\nDescarga Completada!!');

    print('aqui funca1');

    await fileStream.flush();

    print('aqui funca2');
    await fileStream.close();

    print('aqui funca3');
  }

  // Marcos Code
  Future<void> downloadAudio() async {
    if (_manifest == null) throw Exception('Manifest Not Initialized');
    var streamInfo = _manifest!.audioOnly.first;
    return await _youtubeDownloader(streamInfo);
  }

  Future<void> downloadMuxedVideo() async {
    if (_manifest == null) throw Exception('Manifest Not Initialized');

    var streamInfo = _manifest!.muxed.bestQuality;
    return await _youtubeDownloader(streamInfo);
  }

  void printDownloadInfo({
    required StreamInfo streamInfo,
    required int downloadedBytes,
    required int totalBytes,
  }) {
    double progress = (downloadedBytes / totalBytes) * 100;

    stdout.write(
      '\rProgress: ${byteToMb(downloadedBytes)} MB / ${byteToMb(totalBytes)} MB  - ${progress.toStringAsFixed(1)}%',
    );
  }

  (IOSink, String) getFileStream({
    required StreamInfo streamInfo,
    required String videoName,
  }) {
    var filename = '$videoName.${streamInfo.container.name}';
    var file = File(filename);

    file.create(recursive: true);

    return (file.openWrite(), filename);
  }

  Future<void> getManifest(String url) async {
    _id = VideoId(url).value;
    _manifest = await yt.videos.streamsClient.getManifest(_id);
  }
}
