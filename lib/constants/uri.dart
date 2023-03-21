import 'package:flutter_dotenv/flutter_dotenv.dart';

// regions

class ApiUri {
  static String host = dotenv.env['API_URL']!;
  static Uri getAssignedRegionsUri = Uri(
    scheme: 'https',
    host: host,
    path: '/api/Regions/GetAssignedRegions',
  );

  static Uri getUnAssignedRegionsUri = Uri(
    scheme: 'https',
    host: host,
    path: '/api/Regions/GetUnAssignedRegions',
  );

  static Uri getTimeZonesForRegionUri = Uri(
      scheme: 'https',
      host: host,
      path: '/api/Timezones/GetTimeZonesForRegion');
}
