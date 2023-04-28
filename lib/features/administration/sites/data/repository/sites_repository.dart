import 'dart:convert';
import 'package:http/http.dart';

import '/data/repository/repository.dart';
import '/constants/uri.dart';
import '/data/model/model.dart';

class SitesRepository extends BaseRepository {
  SitesRepository({required super.token}) : super(url: '/api/Sites');

  Future<List<Site>> getSites() async {
    Response response =
        await get(Uri.https(ApiUri.host, url), headers: headers);
    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body))
          .map((siteJson) => Site.fromMap(siteJson))
          .toList();
    }
    return <Site>[];
  }

  Future<Site> getSiteById(String siteId) async {
    Response response =
        await get(Uri.https(ApiUri.host, '$url/$siteId'), headers: headers);
    if (response.statusCode == 200) {
      return Site.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> addSite(Site site) async {
    Response response = await post(
      Uri.https(ApiUri.host, url),
      headers: headers,
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
      headers: headers,
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
    Response response =
        await delete(Uri.https(ApiUri.host, '$url/$siteId'), headers: headers);
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
