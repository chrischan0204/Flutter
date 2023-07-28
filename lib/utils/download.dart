import 'package:file_saver/file_saver.dart';
import 'package:http/http.dart' as http;

import '../data/model/model.dart';

Future<void> downloadFile(
  String url, {
  required String filename,
  required String ext,
}) async {
  http.get(Uri.parse(url)).then((response) async {
    await FileSaver.instance.saveFile(
      name: filename,
      bytes: response.bodyBytes,
      ext: ext,
      mimeType: MimeType.other,
    );
  });
}

Future<void> downloadFileUsingDocument(Document document) async {
  String url = document.uri ?? '';
  String filename = document.originalFileName ?? '';
  String ext = document.documentType!.split('.').last;
  http.get(Uri.parse(url)).then((response) async {
    await FileSaver.instance.saveFile(
      name: filename,
      bytes: response.bodyBytes,
      ext: ext,
      mimeType: MimeType.other,
    );
  });
}
