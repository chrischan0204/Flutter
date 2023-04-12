import 'dart:convert';

import 'package:http/http.dart';

import '/constants/uri.dart';
import '/data/model/model.dart';

class CompaniesRepository {
  static String url = '/api/Companies';

  // get companies list
  Future<List<Company>> getCompanies() async {
    Response response = await get(Uri.https(ApiUri.host, url));

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
    List<Company> companies = await getCompanies();

    return companies.firstWhere(
      (company) => company.id == companyId,
      orElse: () {
        throw Exception();
      },
    );
  }

  // add company
  Future<EntityResponse> addCompany(Company company) async {
    Response response = await post(
      Uri.https(ApiUri.host, url),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
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
      headers: {
        'Content-Type': 'application/json',
        'accept': 'plain/text',
      },
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
    Response response = await delete(Uri.https(ApiUri.host, '$url/$companyId'));

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
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
      body: companySiteUpdation.toJson(),
    );

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          isSuccess: true,
          message: 'message',
        );
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> unassignSiteFromCompany(String companySiteId) async {
    Response response = await post(
      Uri.https(
        ApiUri.host,
        '$url/unassign/$companySiteId/site',
      ),
    );
    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          isSuccess: true,
          message: 'message',
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
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
      body: projectCompanyAssignment.toJson(),
    );

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          isSuccess: true,
          message: 'message',
        );
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> unassignProjectFromCompany(
      String projectCompanyId) async {
    Response response = await post(
      Uri.https(
        ApiUri.host,
        '$url/unassign/$projectCompanyId/project',
      ),
    );
    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          isSuccess: true,
          message: 'message',
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
      queryParams.addEntries([MapEntry('assigned', assigned)]);
    }
    if (name != null) {
      queryParams.addEntries([MapEntry('name', name)]);
    }
    Response response = await get(
      Uri.https(ApiUri.host, '$url/$companyId/sites', queryParams),
    );
    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body))
          .map((companySiteMap) => CompanySite.fromMap(companySiteMap))
          .toList();
    }
    return [];
  }

  Future<List<ProjectCompany>> getProjectCompanies(
    String companyId,
    bool? assigned,
    String? name,
  ) async {
    Map<String, dynamic> queryParams = {};
    if (assigned != null) {
      queryParams.addEntries([MapEntry('assigned', assigned)]);
    }
    if (name != null) {
      queryParams.addEntries([MapEntry('name', name)]);
    }
    Response response = await get(
        Uri.https(ApiUri.host, '$url/$companyId/projects', queryParams));
    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body))
          .map((projectCompanyMap) => ProjectCompany.fromMap(projectCompanyMap))
          .toList();
    }
    return [];
  }
}
