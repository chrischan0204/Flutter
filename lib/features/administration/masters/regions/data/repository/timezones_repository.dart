import 'dart:convert';

import 'package:http/http.dart';
import 'package:safety_eta/common_libraries.dart';

class TimeZonesRepository extends BaseRepository {
  TimeZonesRepository({required super.token}) : super(url: '/api/Timezones');

  Future<List<TimeZone>> getTimeZoneList() async {
    Response response =
        await get(Uri.https(ApiUri.host, '$url/list'), headers: headers);

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((timeZoneMap) => TimeZone.fromMap(timeZoneMap))
          .toList();
    }
    throw Exception();
  }
}
