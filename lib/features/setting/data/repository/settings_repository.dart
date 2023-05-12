import 'dart:convert';

import '/common_libraries.dart';

class SettingsRepository extends BaseRepository {
  SettingsRepository({required super.token, required super.authBloc})
      : super(url: '/api');

  Future<ViewSetting> getViewSetting(String name) async {
    Response response = await super.get('$url/settings/view', {'name': name});

    if (response.statusCode == 200) {
      return ViewSetting.fromJson(response.body);
    }

    throw Exception();
  }

  Future<ViewSetting> applyViewSetting(
      ViewSettingUpdate viewSettingUpdate) async {
    Response response =
        await super.post('$url/users/view', body: viewSettingUpdate.toJson());

    if (response.statusCode == 200) {
      return ViewSetting.fromJson(response.body);
    }

    throw Exception();
  }

  Future<List<FilterSetting>> getFilterSettingList(String name) async {
    Response response = await super.get('$url/settings/filter', {'name': name});

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((filterSettingMap) => FilterSetting.fromMap(filterSettingMap))
          .toList();
    }

    throw Exception();
  }

  Future<List<UserFilterSetting>> getUserFilterSettingList(String name) async {
    Response response = await super.get('$url/users/filters', {'name': name});

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((userFilterSettingMap) =>
              UserFilterSetting.fromMap(userFilterSettingMap))
          .toList();
    }
    throw Exception();
  }

  Future<UserFilter> getUserFilterById(String userFilterId) async {
    Response response = await super.get('$url/users/filters/$userFilterId');

    if (response.statusCode == 200) {
      return UserFilter.fromJson(response.body);
    }
    throw Exception();
  }

  Future<UserFilterSetting> updateUserFilterSetting(
      UserFilter userFilterUpdate) async {
    Response response =
        await super.post('$url/users/filter', body: userFilterUpdate.toJson());

    if (response.statusCode == 200) {
      return UserFilterSetting.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> deleteUserFilterSettingById(
      String userFilterSettingId) async {
    Response response =
        await super.delete('$url/users/filters/$userFilterSettingId');

    if (response.statusCode == 200) {
      return EntityResponse(isSuccess: true, message: 'message');
    }
    throw Exception();
  }

  Future<List<String>> getNameList(String url) async {
    Response response = await super.get(url);

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => e['name'] as String)
          .toList();
    }
    throw Exception();
  }
}
