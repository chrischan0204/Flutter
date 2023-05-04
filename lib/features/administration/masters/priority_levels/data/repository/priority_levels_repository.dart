import 'dart:convert';

import 'package:http/http.dart';
import '/constants/uri.dart';
import '/data/repository/repository.dart';

import '/data/model/entity.dart';
import '../model/priority_level.dart';

class PriorityLevelsRepository extends BaseRepository {
  PriorityLevelsRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/PriorityLevels');
  Future<List<PriorityLevel>> getPriorityLevels() async {
    Response response =
        await super.get(Uri.https(ApiUri.host, url), headers: headers);
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
    Response response = await super.get(
        Uri.https(ApiUri.host, '$url/$priorityLevelId'),
        headers: headers);

    if (response.statusCode == 200) {
      return PriorityLevel.fromJson(response.body);
    }
    throw Exception('');
  }

  Future<EntityResponse> addPriorityLevel(
    PriorityLevel priorityLevel,
  ) async {
    Response response = await super.post(
      Uri.https(ApiUri.host, url),
      headers: headers,
      body: priorityLevel.toJson(),
    );

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> editPriorityLevel(
    PriorityLevel priorityLevel,
  ) async {
    Response response = await super.put(
      Uri.https(ApiUri.host, url),
      headers: headers,
      body: priorityLevel.toJson(),
    );

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> deletePriorityLevel(String priorityLevelId) async {
    Response response = await super.delete(
        Uri.https(ApiUri.host, '$url/$priorityLevelId'),
        headers: headers);

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }
}
