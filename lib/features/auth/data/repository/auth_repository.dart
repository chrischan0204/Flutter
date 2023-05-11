import 'package:http/http.dart';
import '/common_libraries.dart';

class AuthRepository {
  static String url = '/api/Auth/token';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'accept': '*/*',
  };

  Future<AuthUser> login(Auth auth) async {
    Response response = await post(
      Uri.https(ApiUri.host, url),
      headers: headers,
      body: auth.toJson(),
    );

    if (response.statusCode == 200) {
      return AuthUser.fromJson(response.body);
    }
    throw Exception();
  }

  Future<void> logout() async {}
}
