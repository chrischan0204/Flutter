import 'package:flutter_dotenv/flutter_dotenv.dart';

// regions

class ApiUri {
  static String host = dotenv.env['API_URL']!;
}
