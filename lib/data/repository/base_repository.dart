class BaseRepository {
  final String url;
  final String token;
  final Map<String, String> headers;
  BaseRepository({
    required this.url,
    required this.token,
  }) : headers = {
          'Content-Type': 'application/json',
          'accept': '*/*',
          'Authorization': 'Bearer $token'
        };
}
