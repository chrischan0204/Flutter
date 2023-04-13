import 'dart:convert';

import 'package:http/http.dart';
import 'package:safety_eta/constants/uri.dart';

import '/data/model/model.dart';

class RolesRepository {
  static String url = '/api/Roles';

  Future<List<Role>> getRoles() async {
    Response response = await get(Uri.https(ApiUri.host, url));

    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body))
          .map((roleMap) => Role.fromMap(roleMap))
          .toList();
    }
    return [];
  }
}
