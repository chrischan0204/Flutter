import 'dart:convert';

import 'package:http/http.dart';

import '/constants/uri.dart';
import '/data/model/model.dart';

class ProjectsRepository {
  static String url = '/api/Projects';

  // get projects list
  Future<List<Project>> getProjects() async {
    Response response = await get(Uri.https(ApiUri.host, url));

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
    Response response = await get(Uri.https(ApiUri.host, '$url/$projectId'));

    if (response.statusCode == 200) {
      return Project.fromJson(response.body);
    }
    throw Exception();
  }

  // add project
  Future<EntityResponse> addProject(Project project) async {
    Response response = await post(
      Uri.https(ApiUri.host, url),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
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
      headers: {
        'Content-Type': 'application/json',
        'accept': 'plain/text',
      },
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
    Response response = await delete(Uri.https(ApiUri.host, '$url/$projectId'));

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

  Future<List<ProjectCompany>> getCompaniesForProject(String projectId) async {
    Response response =
        await get(Uri.https(ApiUri.host, '$url/$projectId/companies'));

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((projectCompanyJson) =>
              ProjectCompany.fromJson(projectCompanyJson))
          .toList();
    }
    return [];
  }

  assignCompanyToProject(
      ProjectCompanyAssignment projectCompanyAssignment) async {
    Response response = await post(
      Uri.https(ApiUri.host, '$url/assign/company'),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'text/plain',
      },
      body: projectCompanyAssignment.toJson(),
    );

    if (response.statusCode == 200) {
      return;
    }
    throw Exception();
  }

  unassignCompanyToProject(String projectCompanyAssignmentId) async {
    Response response = await post(
      Uri.https(
          ApiUri.host, '$url/unassign/$projectCompanyAssignmentId/company'),
    );

    if (response.statusCode == 200) {
      return;
    }
    throw Exception();
  }
}
