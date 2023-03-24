import 'dart:convert';
import 'package:http/http.dart';

import '/constants/uri.dart';
import '/data/model/model.dart';

class AwarenessGroupsRepository {
  static String url = '/api/AwarenessGroups';
  Future<List<AwarenessGroup>> getAwarenessGroups() async {
    Response response = await get(Uri.https(ApiUri.host, url));

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

  Future<AwarenessGroup> getAwarenessGroupById(String awarenessGroupId) async {
    Response response =
        await get(Uri.https(ApiUri.host, '$url/$awarenessGroupId'));

    if (response.statusCode == 200) {
      return AwarenessGroup.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> addAwarenessGroup(
    AwarenessGroup awarenessGroup,
  ) async {
    Response response = await post(
      Uri.https(ApiUri.host, url),
      headers: {'Content-Type': 'application/json', 'accept': 'text/plain'},
      body: awarenessGroup.toJson(),
    );

    if (response.statusCode == 200) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> editAwarenessGroup(
    AwarenessGroup awarenessGroup,
  ) async {
    Response response = await put(
      Uri.https(
        ApiUri.host,
        url,
      ),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'text/plain',
      },
      body: awarenessGroup.toJson(),
    );

    if (response.statusCode == 200) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> deleteAwarenessGroup(String awarenessGroupId) async {
    Response response =
        await delete(Uri.https(ApiUri.host, '$url/$awarenessGroupId'));

    if (response.statusCode == 200) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }
}
