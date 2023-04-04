import 'dart:convert';
import 'package:http/http.dart';

import '/constants/uri.dart';
import '/data/model/model.dart';

class SitesRepository {
  static String url = '/api/Sites';
  List<Site> sites = const [];

  Future<List<Site>> getSites() async {
    Response response = await get(Uri.https(ApiUri.host, url));
    if (response.statusCode == 200) {
      sites = List.from(jsonDecode(response.body))
          .map((siteJson) => Site.fromMap(siteJson))
          .toList();
      return sites;
    }
    return <Site>[];
  }

  Future<Site> getSiteById(String siteId) async {
    Response response = await get(Uri.https(ApiUri.host, '$url/$siteId'));
    if (response.statusCode == 200) {
      return Site.fromJson(response.body);
    }
    throw Exception();
  }

  Future<String> addSite(Site site) async {
    Response response = await post(
      Uri.https(ApiUri.host, url),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'text/plain',
      },
      body: site.toJson(),
    );

    if (response.statusCode == 200) {
      return response.body;
    }
    throw Exception();
  }

  deleteSite(String siteId) async {
    Response response = await delete(Uri.https(ApiUri.host, '$url/$siteId'));
    if (response.statusCode == 200) {
      return response.body;
    }
    throw Exception();
  }
}
