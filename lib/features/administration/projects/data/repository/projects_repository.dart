import 'dart:convert';

import 'package:http/http.dart';

import '/constants/uri.dart';
import '/data/model/model.dart';

class ProjectsRepository {
  static String url = '/api/Projects';

  Future<List<Project>> getProjects() async {
    Response response = await get(Uri.https(ApiUri.host, url));

    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body))
          .map((projectMap) => Project.fromMap(projectMap))
          .toList();
    }
    return [];
  }

  Future<Project> getProjectById(
    String projectId,
  ) async {
    Response response = await get(Uri.https(ApiUri.host, '$url/$projectId'));

    if (response.statusCode == 200) {
      return Project.fromJson(response.body);
    }
    throw Exception();
  }

  Future<String> addProject(Project project) async {
    Response response = await post(
      Uri.https(ApiUri.host, url),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'plain/text',
      },
      body: project.toJson(),
    );

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body).message;
    }
    throw Exception();
  }

  Future<String> editProject(Project project) async {
    Response response = await put(
      Uri.https(ApiUri.host, url),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'plain/text',
      },
      body: project.toJson(),
    );

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body).message;
    }
    throw Exception();
  }

  deleteProject(String projectId) async {
    Response response = await delete(Uri.https(ApiUri.host, '$url/company'));

    if (response.statusCode == 200) {
      return;
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
