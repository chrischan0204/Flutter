import 'dart:convert';

import 'package:http/http.dart';
import 'package:safety_eta/constants/uri.dart';

import '../model/awareness_group.dart';

class AwarenessGroupsRepository {
  Future<List<AwarenessGroup>> getAwarenessGroups() async {
    Response response = await get(ApiUri.getAwarenessGroupsUri);

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
}
