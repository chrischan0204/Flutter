import 'dart:convert';

import 'package:http/http.dart';

import '/data/repository/repository.dart';
import '/constants/uri.dart';
import '/data/model/model.dart';

class ProjectsRepository extends BaseRepository {
  ProjectsRepository({required super.token}) : super(url: '/api/Projects');

  // get projects list
  Future<List<Project>> getProjects() async {
    Response response =
        await get(Uri.https(ApiUri.host, url), headers: headers);

    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body))
          .map((projectMap) => Project.fromMap(projectMap))
          .toList();
    }
    return [];
  }

  // get project by id
  Future<Project> getProjectById(
    String projectId,
  ) async {
    Response response =
        await get(Uri.https(ApiUri.host, '$url/$projectId'), headers: headers);

    if (response.statusCode == 200) {
      return Project.fromJson(response.body);
    }
    throw Exception();
  }

  // add project
  Future<EntityResponse> addProject(Project project) async {
    Response response = await post(
      Uri.https(ApiUri.host, url),
      headers: headers,
      body: project.toJson(),
    );

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  // edit project
  Future<EntityResponse> editProject(Project project) async {
    Response response = await put(
      Uri.https(ApiUri.host, url),
      headers: headers,
      body: project.toJson(),
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

  Future<EntityResponse> deleteProject(String projectId) async {
    Response response = await delete(Uri.https(ApiUri.host, '$url/$projectId'),
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

  Future<List<ProjectCompany>> getCompaniesForProject(String projectId,
      [bool? assigned, String? name]) async {
    Map<String, dynamic> map = {};
    if (assigned != null) {
      map.addEntries([MapEntry('assigned', assigned.toString())]);
    }
    if (name != null && name.isNotEmpty) {
      map.addEntries([MapEntry('name', name)]);
    }
    Response response = await get(
        Uri.https(ApiUri.host, '$url/$projectId/companies', map),
        headers: headers);

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((projectMap) => ProjectCompany.fromMap(projectMap))
          .toList();
    }
    return [];
  }

  assignCompanyToProject(
      ProjectCompanyAssignment projectCompanyAssignment) async {
    Response response = await post(
      Uri.https(ApiUri.host, '$url/assign/company'),
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

  unassignCompanyFromProject(String projectCompanyAssignmentId) async {
    Response response = await post(
        Uri.https(
            ApiUri.host, '$url/unassign/$projectCompanyAssignmentId/company'),
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
}
