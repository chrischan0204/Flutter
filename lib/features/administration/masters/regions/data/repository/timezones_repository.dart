import 'dart:convert';

import 'package:http/http.dart';
import 'package:safety_eta/common_libraries.dart';

class TimeZonesRepository extends BaseRepository {
  TimeZonesRepository({required super.token}) : super(url: '/api/Timezones');

  Future<List<TimeZone>> getTimeZones() async {
    Response response = await get(Uri.https(ApiUri.host, '$url/list'));

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((timeZoneMap) => TimeZone.fromMap(timeZoneMap))
          .toList();
    }
    return [];
  }
}
