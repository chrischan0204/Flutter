import 'dart:convert';

import '/data/repository/repository.dart';

import '/data/model/entity.dart';
import '../model/priority_level.dart';

class PriorityLevelsRepository extends BaseRepository {
  PriorityLevelsRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/PriorityLevels');
  Future<List<PriorityLevel>> getPriorityLevelList() async {
    Response response = await super.get(url);
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
    Response response = await super.get('$url/$priorityLevelId');

    if (response.statusCode == 200) {
      return PriorityLevel.fromJson(response.body);
    }
    throw Exception('');
  }

  Future<EntityResponse> addPriorityLevel(
    PriorityLevel priorityLevel,
  ) async {
    Response response = await super.post(
      url,
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
      url,
      body: priorityLevel.toJson(),
    );

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> deletePriorityLevel(String priorityLevelId) async {
    Response response = await super.delete('$url/$priorityLevelId');

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<List<Entity>> getActivePriorityLevelList() async {
    Response response = await super.get('$url/items');
    if (response.statusCode == 200) {
      List<Entity> priorityLevels = List.from(jsonDecode(response.body))
          .map((priorityLevelJson) => Entity.fromMap(priorityLevelJson))
          .toList();
      return priorityLevels;
    }
    throw Exception();
  }
}
