import '/common_libraries.dart';

class CompaniesRepository extends BaseRepository {
  CompaniesRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/Companies');

  // get companies list
  Future<List<Company>> getCompanyList() async {
    Response response = await super.get(url);

    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body))
          .map((companyMap) => Company.fromMap(companyMap))
          .toList();
    }
    return [];
  }

  // get company by id
  Future<Company> getCompanyById(String companyId) async {
    Response response = await super.get('$url/$companyId');

    if (response.statusCode == 200) {
      return Company.fromJson(response.body);
    }
    throw Exception();
  }

  // add company
  Future<EntityResponse> addCompany(Company company) async {
    Response response = await super.post(url, body: company.toJson());

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  // edit company
  Future<EntityResponse> editCompany(Company company) async {
    Response response = await super.put(url, body: company.toJson());

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
    Response response = await super.delete('$url/$companyId');

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
    Response response = await super
        .post('$url/assign/site', body: companySiteUpdation.toJson());

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          message: response.body,
        );
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> unassignSiteFromCompany(String companySiteId) async {
    Response response = await super.post('$url/unassign/$companySiteId/site');
    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          statusCode: response.statusCode,
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
    Response response = await super
        .post('$url/assign/project', body: projectCompanyAssignment.toJson());

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          statusCode: response.statusCode,
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
    Response response =
        await super.post('$url/unassign/$projectCompanyId/project');
    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          statusCode: response.statusCode,
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
    Response response = await super.get('$url/$companyId/sites', queryParams);
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
    Response response =
        await super.get('$url/$companyId/projects', queryParams);
    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body))
          .map((projectCompanyMap) => ProjectCompany.fromMap(projectCompanyMap))
          .toList();
    }
    return [];
  }

  Future<List<AuditTrail>> getAuditTrailsByCompanyId(String companyId) async {
    Response response = await super.get('$url/$companyId/AuditTrails');
    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((auditTrailMap) => AuditTrail.fromMap(auditTrailMap))
          .toList();
    }
    return [];
  }

  Future<FilteredCompanyData> getFilteredCompanyList(
      FilteredTableParameter option) async {
    Response response = await super.filter(option);

    if (response.statusCode == 200) {
      final data = FilteredCompanyData.fromJson(response.body);
      return data;
    }
    throw Exception();
  }
}
