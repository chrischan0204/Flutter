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

  Future<EntityResponse> addSite(Site site) async {
    Response response = await post(
      Uri.https(ApiUri.host, url),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
      body: site.toJson(),
    );

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> editSite(Site site) async {
    Response response = await put(
      Uri.https(ApiUri.host, url),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
      body: site.toJson(),
    );

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse.fromMap({
          'isSuccess': true,
          'message': response.body,
        });
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> deleteSite(String siteId) async {
    Response response = await delete(Uri.https(ApiUri.host, '$url/$siteId'));
    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse.fromMap({
          'isSuccess': true,
          'message': response.body,
        });
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }
}
