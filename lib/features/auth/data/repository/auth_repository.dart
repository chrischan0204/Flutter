import 'package:http/http.dart';

import '/constants/uri.dart';
import '../model/auth.dart';

class AuthRepository {
  static String url = '/api/Auth/token';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'accept': '*/*',
  };

  Future<String> login(Auth auth) async {
    Response response = await post(
      Uri.https(ApiUri.host, url),
      headers: headers,
      body: auth.toJson(),
    );

    if (response.statusCode == 200) {
      return response.body;
    }
    throw Exception();
  }

  Future<void> logout() async {}
}
