import 'dart:convert';
import 'package:http/http.dart';

import '/data/repository/repository.dart';
import '/constants/uri.dart';
import '/data/model/model.dart';

class AwarenessGroupsRepository extends BaseRepository {
  AwarenessGroupsRepository({required super.token})
      : super(url: '/api/AwarenessGroups');

  // get awareness groups list
  Future<List<AwarenessGroup>> getAwarenessGroups() async {
    Response response =
        await get(Uri.https(ApiUri.host, url), headers: headers);

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

  // get awareness group by id
  Future<AwarenessGroup> getAwarenessGroupById(
    String awarenessGroupId,
  ) async {
    Response response = await get(
        Uri.https(ApiUri.host, '$url/$awarenessGroupId'),
        headers: headers);

    if (response.statusCode == 200) {
      return AwarenessGroup.fromJson(response.body);
    }
    throw Exception();
  }

  // add awareness group
  Future<EntityResponse> addAwarenessGroup(
    AwarenessGroup awarenessGroup,
  ) async {
    Response response = await post(
      Uri.https(ApiUri.host, url),
      headers: headers,
      body: awarenessGroup.toJson(),
    );

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  // edit awareness group
  Future<EntityResponse> editAwarenessGroup(
    AwarenessGroup awarenessGroup,
  ) async {
    Response response = await put(
      Uri.https(ApiUri.host, url),
      headers: headers,
      body: awarenessGroup.toJson(),
    );

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  // delete awareness group
  Future<EntityResponse> deleteAwarenessGroup(String awarenessGroupId) async {
    Response response = await delete(
        Uri.https(ApiUri.host, '$url/$awarenessGroupId'),
        headers: headers);

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }
}
