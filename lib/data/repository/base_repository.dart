import 'dart:convert';

import 'package:http/http.dart' as http;

import '/features/auth/bloc/auth_bloc.dart';

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

  void _checkJwt(int statusCode) {
    if (statusCode == 401) {
      authBloc.add(AuthUnauthenticated(statusCode: statusCode));
    }
  }

  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    http.Response response = await http.get(url, headers: headers);
    _checkJwt(response.statusCode);
    return response;
  }

  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
      encoding: encoding,
    );

    _checkJwt(response.statusCode);
    return response;
  }

  Future<http.Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    http.Response response = await http.put(
      url,
      headers: headers,
      body: body,
      encoding: encoding,
    );

    _checkJwt(response.statusCode);
    return response;
  }

  Future<http.Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    http.Response response = await http.delete(
      url,
      headers: headers,
      body: body,
      encoding: encoding,
    );

    _checkJwt(response.statusCode);
    return response;
  }
}
