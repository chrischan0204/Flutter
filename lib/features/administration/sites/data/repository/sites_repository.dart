import '/common_libraries.dart';

class SitesRepository extends BaseRepository {
  SitesRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/Sites');

  Future<List<Site>> getSiteList() async {
    Response response = await super.get(url);
    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body))
          .map((siteJson) => Site.fromMap(siteJson))
          .toList();
    }
    return <Site>[];
  }

  Future<List<Entity>> getActiveSiteList() async {
    Response response = await super.get('$url/items');
    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body))
          .map((siteJson) => Entity.fromMap(siteJson))
          .toList();
    }
    throw Exception();
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

  Future<List<SiteType>> getSiteTypeList() async {
    Response response = await super.get('$url/sitetypes');

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => SiteType.fromMap(e))
          .toList();
    }

    throw Exception();
  }

  Future<FilteredSiteData> getFilteredSiteList(
      FilteredTableParameter option) async {
    Response response = await super.filter(option);

    if (response.statusCode == 200) {
      final data = FilteredSiteData.fromJson(response.body);
      return data;
    }
    throw Exception();
  }

  /// get audit template list by site id
  Future<List<Template>> getAuditTemlateList(String siteId,
      [bool? assigned, String? name]) async {
    Map<String, String> queryParams = {};

    if (assigned != null) {
      queryParams = {'assigned': assigned.toString()};
    }

    if (name != null) {
      queryParams.addEntries([MapEntry('name', name)]);
    }

    Response response = await super.get('$url/$siteId/templates', queryParams);

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => Template.fromMap(e))
          .toList();
    }

    throw Exception();
  }

  /// toggle assign template to site
  Future<EntityResponse> toggleAssignTemplateToSite(
      TemplateSiteAssignment templateSiteAssignment) async {
    Response response = await super.put(
        '$url/${templateSiteAssignment.siteId}/templates/toggle',
        body: templateSiteAssignment.toJson());

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: response.body,
      );
    }
    throw Exception();
  }

  Future<List<Project>> getProjectListForSite(String siteId) async {
    Response response = await super.get('$url/$siteId/projects');

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => Project.fromMap(e))
          .toList();
    }

    throw Exception();
  }

  Future<List<Template>> getTemplateListForSite(String siteId) async {
    Response response =
        await super.get('$url/$siteId/templates', {'assigned': 'true'});

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => Template.fromMap(e))
          .toList();
    }

    throw Exception();
  }

  Future<List<CompanySite>> getCompanyListForSite(String siteId) async {
    Response response = await super.get('$url/$siteId/companies');

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => CompanySite.fromMap(e))
          .toList();
    }

    throw Exception();
  }

  Future<List<Entity>> getUserListForSite(String siteId) async {
    Response response = await super.get('$url/$siteId/users');

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => Entity.fromMap(e))
          .toList();
    }

    throw Exception();
  }
}
