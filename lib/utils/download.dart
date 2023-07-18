import 'package:file_saver/file_saver.dart';
import 'package:http/http.dart' as http;

Future<void> downloadFile(
  String url, {
  required String filename,
  required String ext,
}) async {
  http
      .get(Uri.parse('https://api.allorigins.win/raw?url=$url'))
      .then((response) async {
    await FileSaver.instance.saveFile(
      name: filename,
      bytes: response.bodyBytes,
      ext: ext,
      mimeType: MimeType.other,
    );
  });
}
