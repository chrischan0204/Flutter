import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
export 'package:http/http.dart';
import '/common_libraries.dart';

class BaseRepository {
  final String url;
  final String token;
  final Map<String, String> headers;
  final AuthBloc authBloc;
  BaseRepository({
    required this.url,
    required this.token,
    required this.authBloc,
  }) : headers = {
          'Content-Type': 'application/json',
          'accept': '*/*',
          'Authorization': 'Bearer $token'
        };

  Future<http.Response> get(String encodedPath,
      [Map<String, dynamic>? queryParams]) async {
    http.Response response;
    try {
      response = await http.get(
          Uri.https(ApiUri.host, encodedPath, queryParams),
          headers: headers);
      return response;
    } on http.ClientException catch (_) {
      authBloc.add(const AuthUnauthenticated(statusCode: 401));
      throw Exception();
    }
  }

  Future<http.Response> post(
    String encodedPath, {
    Object? body,
    Encoding? encoding,
  }) async {
    late http.Response response;
    try {
      response = await http.post(
        Uri.https(ApiUri.host, encodedPath),
        headers: headers,
        body: body,
        encoding: encoding,
      );
      return response;
    } catch (e) {
      authBloc.add(const AuthUnauthenticated(statusCode: 401));
      throw Exception();
    }
  }

  Future<http.Response> put(
    String encodedPath, {
    Object? body,
    Encoding? encoding,
  }) async {
    late http.Response response;
    try {
      response = await http.put(
        Uri.https(ApiUri.host, encodedPath),
        headers: headers,
        body: body,
        encoding: encoding,
      );
      return response;
    } catch (e) {
      authBloc.add(const AuthUnauthenticated(statusCode: 401));
      throw Exception();
    }
  }

  Future<http.Response> delete(
    String encodedPath, {
    Object? body,
    Encoding? encoding,
  }) async {
    late http.Response response;
    try {
      response = await http.delete(
        Uri.https(ApiUri.host, encodedPath),
        headers: headers,
        body: body,
        encoding: encoding,
      );

      return response;
    } catch (e) {
      authBloc.add(const AuthUnauthenticated(statusCode: 401));
      throw Exception();
    }
  }

  Future<http.Response> filter(FilteredTableParameter option) async {
    late http.Response response;
    try {
      response = await post('$url/list', body: option.toJson());
      return response;
    } catch (e) {
      authBloc.add(const AuthUnauthenticated(statusCode: 401));
      throw Exception();
    }
  }

  Future<String> uploadMultipartFile({
    required String encodedPath,
    required Map<String, String> queryParams,
    required List<PlatformFile> fileList,
  }) async {
    try {
      MultipartRequest request = http.MultipartRequest(
          'POST', Uri.https(ApiUri.host, encodedPath, queryParams));

      request.headers.addAll(headers);

      for (int i = 0; i < fileList.length; i++) {
        request.files.add(http.MultipartFile.fromBytes(
          'documents',
          fileList[i].bytes ?? [],
          filename: fileList[i].name,
        ));
      }

      var streamedResponse = await request.send();
      var result = await http.Response.fromStream(streamedResponse);

      if (result.statusCode == 200) {
        return result.body;
      }

      throw Exception();
    } catch (e) {
      authBloc.add(const AuthUnauthenticated(statusCode: 401));
      throw Exception();
    }
  }
}
