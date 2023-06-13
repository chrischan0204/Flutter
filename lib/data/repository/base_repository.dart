import 'dart:convert';

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
        } {
    print(token);
  }

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

  Future<http.Response> filter(FilteredTableParameter option) async {
    late http.Response response;
    try {
      // if (option.filterOption == null) {
      //   Map<String, String> queryParams = {
      //     'includeDeleted': option.includeDeleted.toString()
      //   };

      //   if (!Validation.isEmpty(option.filterId)) {
      //     queryParams.addEntries([MapEntry('filterId', option.filterId)]);
      //   }

      //   queryParams
      //       .addEntries([MapEntry('pageNum', option.pageNum.toString())]);

      //   queryParams
      //       .addEntries([MapEntry('pageSize', option.pageSize.toString())]);

      //   response = await get('$url/list', queryParams);
      // } else {
      response = await post('$url/list', body: option.toJson());
      // }
    } catch (e) {
      authBloc.add(const AuthUnauthenticated(statusCode: 401));
    }
    return response;
  }
}
