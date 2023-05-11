import 'dart:convert';
import 'package:http/http.dart';

import '/data/repository/repository.dart';
import '/constants/uri.dart';
import '/data/model/model.dart';

class SitesRepository extends BaseRepository {
  SitesRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/Sites');

  Future<List<Site>> getSites() async {
    Response response = await super.get(url);
    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body))
          .map((siteJson) => Site.fromMap(siteJson))
          .toList();
    }
    return <Site>[];
  }

  Future<Site> getSiteById(String siteId) async {
    Response response = await super.get('$url/$siteId');
    if (response.statusCode == 200) {
      return Site.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> addSite(Site site) async {
    Response response = await super.post(
      url,
      body: site.toJson(),
    );

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> editSite(Site site) async {
    Response response = await super.put(
      url,
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
    Response response = await super.delete('$url/$siteId');
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
