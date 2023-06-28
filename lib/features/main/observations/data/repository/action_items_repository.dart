import 'package:uuid/uuid.dart';

import '/common_libraries.dart';

class ActionItemsRepository extends BaseRepository {
  ActionItemsRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/actionItems');

  /// get actionItems list
  Future<List<ActionItem>> getActionItemList(String observationId) async {
    // return [
    //   // ActionItem(
    //   //   id: const Uuid().v1(),
    //   //   task: 'Inspect the staircase on an ASAP basis.',
    //   //   due: DateTime.now(),
    //   //   assignee: 'Olive Alex',
    //   //   category: 'Bio Hazard',
    //   //   company: 'Green and Sons',
    //   //   project: 'Darren',
    //   //   location: 'By the admin office',
    //   //   notes: 'The task was closed after inspection',
    //   //   status: ActionItemStatus.open,
    //   // ),
    //   // ActionItem(
    //   //   id: const Uuid().v1(),
    //   //   task: 'Assign a cleaning crew to address this',
    //   //   due: DateTime.now(),
    //   //   assignee: 'Alexander Korshunov',
    //   //   category: 'Category',
    //   //   company: 'Comic Maroon',
    //   //   project: 'Blackwater',
    //   //   location: 'By the admin office',
    //   //   notes: 'The task was closed after inspection',
    //   //   status: ActionItemStatus.closed,
    //   // ),
    // ];

    Response response = await super.get(url);
    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body))
          .map((actionItemMap) => ActionItem.fromMap(actionItemMap))
          .toList();
    }
    return [];
  }

  /// get actionItem by id
  Future<ActionItem> getActionItemById(
    String actionItemId,
  ) async {
    Response response = await super.get('$url/$actionItemId');

    if (response.statusCode == 200) {
      return ActionItem.fromJson(response.body);
    }

    throw Exception();
  }

  /// add actionItem
  Future<EntityResponse> addActionItem(ActionItemCreate actionItem) async {
    Response response = await super.post(url, body: actionItem.toJson());

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse.fromJson(response.body);
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  /// edit actionItem
  Future<EntityResponse> editActionItem(ActionItemCreate actionItem) async {
    Response response = await super.put(
      url,
      body: actionItem.toJson(),
    );

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          message: response.body,
        );
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  /// delete actionItem by id
  Future<EntityResponse> deleteActionItem(String actionItemId) async {
    Response response = await super.delete('$url/$actionItemId');

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          message: response.body,
        );
      }
      return EntityResponse.fromJson(response.body);
    }

    throw Exception();
  }
}
