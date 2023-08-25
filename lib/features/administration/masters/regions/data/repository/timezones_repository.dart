
import 'package:safety_eta/common_libraries.dart';

class TimeZonesRepository extends BaseRepository {
  TimeZonesRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/Timezones');

  Future<List<TimeZone>> getTimeZoneList() async {
    Response response = await super.get('$url/list');

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((timeZoneMap) => TimeZone.fromMap(timeZoneMap))
          .toList();
    }
    throw Exception();
  }
}
