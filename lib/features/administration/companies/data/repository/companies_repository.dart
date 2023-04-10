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
    Response response = await get(Uri.https(ApiUri.host, '$url/$companyId'));

    if (response.statusCode == 200) {
      return Company.fromJson(response.body);
    }
    throw Exception();
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
}
