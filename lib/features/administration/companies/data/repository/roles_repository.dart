import 'dart:convert';

import 'package:safety_eta/data/repository/repository.dart';

import '/data/model/model.dart';

class RolesRepository extends BaseRepository {
  RolesRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/Roles');

  /// get user role list
  Future<List<Role>> getRoles() async {
    Response response = await super.get(url);

    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body))
          .map((roleMap) => Role.fromMap(roleMap))
          .toList();
    }
    return [];
  }
}
