import 'dart:convert';

import 'package:http/http.dart';
import 'package:safety_eta/constants/uri.dart';

import '../model/priority_level.dart';

class PriorityLevelsRepository {
  Future<List<PriorityLevel>> getPriorityLevels() async {
    Response response = await get(ApiUri.getPrioritiesUri);
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
}
