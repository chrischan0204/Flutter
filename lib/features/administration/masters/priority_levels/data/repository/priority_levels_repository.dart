import 'dart:convert';

import 'package:http/http.dart';
import 'package:safety_eta/constants/uri.dart';

import '/data/model/entity.dart';
import '../model/priority_level.dart';

class PriorityLevelsRepository {
  static String url = '/api/PriorityLevels';
  Future<List<PriorityLevel>> getPriorityLevels() async {
    Response response = await get(Uri.https(ApiUri.host, url));
    if (response.statusCode == 200) {
      List<PriorityLevel> priorityLevels = List.from(jsonDecode(response.body))
          .map(
            (priorityLevelJson) => PriorityLevel.fromMap(priorityLevelJson),
          )
          .toList();
      return priorityLevels;
    }
    return [];
  }

  Future<PriorityLevel> getPriorityLevelById(
    String priorityLevelId,
  ) async {
    Response response =
        await get(Uri.https(ApiUri.host, '$url/$priorityLevelId'));

    if (response.statusCode == 200) {
      return PriorityLevel.fromJson(response.body);
    }
    throw Exception('');
  }

  Future<EntityResponse> addPriorityLevel(
    PriorityLevel priorityLevel,
  ) async {
    Response response = await post(
      Uri.https(ApiUri.host, url),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'text/plain',
      },
      body: priorityLevel.toJson(),
    );

    if (response.statusCode == 200) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> editPriorityLevel(
    PriorityLevel priorityLevel,
  ) async {
    Response response = await put(Uri.https(ApiUri.host, url),
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
        body: priorityLevel.toJson());

    if (response.statusCode == 200) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> deletePriorityLevel(String priorityLevelId) async {
    Response response = await delete(
      Uri.https(ApiUri.host, '$url/$priorityLevelId'),
    );

    if (response.statusCode == 200) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }
}
