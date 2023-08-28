import 'dart:convert';

import '/data/repository/repository.dart';
import '/data/model/model.dart';

class AwarenessGroupsRepository extends BaseRepository {
  AwarenessGroupsRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/AwarenessGroups');

  /// get awareness groups list
  Future<List<AwarenessGroup>> getAwarenessGroups() async {
    Response response = await super.get(
      url,
    );

    if (response.statusCode == 200) {
      List<AwarenessGroup> awarenessGroups =
          List.from(jsonDecode(response.body))
              .map((awarenessGroupJson) =>
                  AwarenessGroup.fromMap(awarenessGroupJson))
              .toList();
      return awarenessGroups;
    }
    return [];
  }

  /// get awareness group by id
  Future<AwarenessGroup> getAwarenessGroupById(
    String awarenessGroupId,
  ) async {
    Response response = await super.get('$url/$awarenessGroupId');

    if (response.statusCode == 200) {
      return AwarenessGroup.fromJson(response.body);
    }
    throw Exception();
  }

  /// add awareness group
  Future<EntityResponse> addAwarenessGroup(
    AwarenessGroup awarenessGroup,
  ) async {
    Response response = await super.post(
      url,
      body: awarenessGroup.toJson(),
    );

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  /// edit awareness group
  Future<EntityResponse> editAwarenessGroup(
    AwarenessGroup awarenessGroup,
  ) async {
    Response response = await super.put(
      url,
      body: awarenessGroup.toJson(),
    );

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  /// delete awareness group
  Future<EntityResponse> deleteAwarenessGroup(String awarenessGroupId) async {
    Response response = await super.delete('$url/$awarenessGroupId');

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }
}
