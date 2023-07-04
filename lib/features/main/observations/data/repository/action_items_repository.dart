import '/common_libraries.dart';

class ActionItemsRepository extends BaseRepository {
  ActionItemsRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/actionItems');

  Future<List<ActionItem>> getActionItemList() async {
    Response response = await super.get(url);

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => ActionItem.fromMap(e))
          .toList();
    }

    throw Exception();
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
        return EntityResponse(
          isSuccess: true,
          message: response.body,
        );
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

  /// get filtered action item data
  Future<FilteredActionItemData> getFilteredActionItemList(
      FilteredTableParameter option) async {
    Response response = await super.filter(option);

    if (response.statusCode == 200) {
      return FilteredActionItemData.fromJson(response.body);
    }
    throw Exception();
  }

  /// get action item parent info
  Future<ActionItemParentInfo> getActionItemParentInfo(
      String actionItemId) async {
    Response response = await super.get('$url/$actionItemId/parentinformations');

    if (response.statusCode == 200) {
      return ActionItemParentInfo.fromJson(response.body);
    }

    throw Exception();
  }
}
