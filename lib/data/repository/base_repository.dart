import 'dart:convert';

import 'package:http/http.dart' as http;
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
    late http.Response response;
    try {
      response = await http.get(
          Uri.https(ApiUri.host, encodedPath, queryParams),
          headers: headers);
    } on http.ClientException catch (_) {
      authBloc.add(const AuthUnauthenticated(statusCode: 401));
    }
    return response;
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
    } catch (e) {
      authBloc.add(const AuthUnauthenticated(statusCode: 401));
    }
    return response;
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
    } catch (e) {
      authBloc.add(const AuthUnauthenticated(statusCode: 401));
    }
    return response;
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
    } catch (e) {
      authBloc.add(const AuthUnauthenticated(statusCode: 401));
    }
    return response;
  }
}
