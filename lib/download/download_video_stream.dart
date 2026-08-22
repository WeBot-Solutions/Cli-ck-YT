import 'dart:io';

import 'package:cli_ck_y_t/utils/bytes_to_megabytes.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeDownloader {
  final YoutubeExplode yt;
  late String id;
  StreamManifest? manifest;

  YoutubeDownloader() : yt = YoutubeExplode();

  void downloadMuxedVideo() async {
    if (manifest == null) throw Exception('Manifest Not Initialized');

    var streamInfo = manifest!.muxed.bestQuality;
    var stream = yt.videos.streams.get(streamInfo);

    var videoInfo = await yt.videos.get(id);

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

    await fileStream.flush();
    await fileStream.close();
  }

  void printDownloadInfo({
    required MuxedStreamInfo streamInfo,
    required int downloadedBytes,
    required int totalBytes,
  }) {
    double progress = (downloadedBytes / totalBytes) * 100;

    stdout.write(
      '\rProgress: ${byteToMb(downloadedBytes)} MB / ${byteToMb(totalBytes)} MB  - ${progress.toStringAsFixed(1)}%',
    );
  }

  (IOSink, String) getFileStream({
    required MuxedStreamInfo streamInfo,
    required String videoName,
  }) {
    var filename = '$videoName.${streamInfo.container.name}';
    var file = File(filename);

    file.create(recursive: true);

    return (file.openWrite(), filename);
  }

  Future<void> getManifest(String url) async {
    id = VideoId(url).value;
    manifest = await yt.videos.streamsClient.getManifest(id);
  }
}
