import 'dart:convert';

import 'package:http/http.dart';

import '/common_libraries.dart';

class SettingsRepository extends BaseRepository {
  SettingsRepository({required super.token, required super.authBloc})
      : super(url: '/api/settings');

  Future<ViewSetting> getViewSetting(String name) async {
    Response response = await super.get('$url/view', {'name': name});

    if (response.statusCode == 200) {
      return ViewSetting.fromJson(response.body);
    }

    throw Exception();
  }

  Future<List<FilterSetting>> getFilterSettingList(String name) async {
    Response response = await super.get('$url/filter', {'name': name});

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((filterSettingMap) => FilterSetting.fromMap(filterSettingMap))
          .toList();
    }

    throw Exception();
  }
}
