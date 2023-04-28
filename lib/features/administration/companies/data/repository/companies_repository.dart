import 'dart:convert';

import 'package:http/http.dart';

import '/data/repository/repository.dart';
import '/constants/uri.dart';
import '/data/model/model.dart';

class CompaniesRepository extends BaseRepository {
  CompaniesRepository({required super.token}) : super(url: '/api/Companies');

  // get companies list
  Future<List<Company>> getCompanies() async {
    Response response =
        await get(Uri.https(ApiUri.host, url), headers: headers);

    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body))
          .map((companyMap) => Company.fromMap(companyMap))
          .toList();
    }
    return [];
  }

  // get company by id
  Future<Company> getCompanyById(
    String companyId,
  ) async {
    Response response =
        await get(Uri.https(ApiUri.host, '$url/$companyId'), headers: headers);

    if (response.statusCode == 200) {
      return Company.fromJson(response.body);
    }
    throw Exception();
  }

  // add company
  Future<EntityResponse> addCompany(Company company) async {
    Response response = await post(
      Uri.https(ApiUri.host, url),
      headers: headers,
      body: company.toJson(),
    );

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  // edit company
  Future<EntityResponse> editCompany(Company company) async {
    Response response = await put(
      Uri.https(ApiUri.host, url),
      headers: headers,
      body: company.toJson(),
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

  Future<EntityResponse> deleteCompany(String companyId) async {
    Response response = await delete(Uri.https(ApiUri.host, '$url/$companyId'),
        headers: headers);

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

  Future<EntityResponse> assignSiteToCompany(
      CompanySiteUpdation companySiteUpdation) async {
    Response response = await post(
      Uri.https(ApiUri.host, '$url/assign/site'),
      headers: headers,
      body: companySiteUpdation.toJson(),
    );

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          isSuccess: true,
          message: response.body,
        );
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> unassignSiteFromCompany(String companySiteId) async {
    Response response = await post(
        Uri.https(ApiUri.host, '$url/unassign/$companySiteId/site'),
        headers: headers);
    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          isSuccess: true,
          message: response.body,
        );
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> assignProjectToCompany(
      ProjectCompanyAssignment projectCompanyAssignment) async {
    Response response = await post(
      Uri.https(ApiUri.host, '$url/assign/project'),
      headers: headers,
      body: projectCompanyAssignment.toJson(),
    );

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          isSuccess: true,
          message: response.body,
        );
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> unassignProjectFromCompany(
      String projectCompanyId) async {
    Response response = await post(
        Uri.https(ApiUri.host, '$url/unassign/$projectCompanyId/project'),
        headers: headers);
    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          isSuccess: true,
          message: response.body,
        );
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<List<CompanySite>> getCompanySites(
    String companyId,
    bool? assigned,
    String? name,
  ) async {
    Map<String, dynamic> queryParams = {};
    if (assigned != null) {
      queryParams.addEntries([MapEntry('assigned', assigned.toString())]);
    }
    if (name != null && name.isNotEmpty) {
      queryParams.addEntries([MapEntry('name', name)]);
    }
    Response response = await get(
        Uri.https(ApiUri.host, '$url/$companyId/sites', queryParams),
        headers: headers);
    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body))
          .map((companySiteMap) => CompanySite.fromMap(companySiteMap))
          .toList();
    }
    return [];
  }

  Future<List<ProjectCompany>> getProjectCompanies(
    String companyId, [
    bool? assigned,
    String? name,
    String? siteId,
  ]) async {
    Map<String, dynamic> queryParams = {};
    if (assigned != null) {
      queryParams.addEntries([MapEntry('assigned', assigned.toString())]);
    }
    if (name != null && name.isNotEmpty) {
      queryParams.addEntries([MapEntry('name', name)]);
    }

    if (siteId != null && siteId.isNotEmpty) {
      queryParams.addEntries([MapEntry('siteId', siteId)]);
    }
    Response response = await get(
        Uri.https(ApiUri.host, '$url/$companyId/projects', queryParams),
        headers: headers);
    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body))
          .map((projectCompanyMap) => ProjectCompany.fromMap(projectCompanyMap))
          .toList();
    }
    return [];
  }

  Future<List<AuditTrail>> getAuditTrailsByCompanyId(String companyId) async {
    Response response = await get(
        Uri.https(ApiUri.host, '$url/$companyId/AuditTrails'),
        headers: headers);
    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((auditTrailMap) => AuditTrail.fromMap(auditTrailMap))
          .toList();
    }
    return [];
  }
}
