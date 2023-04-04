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
    Response response = await get(Uri.https(ApiUri.host, url));

    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body))
          .map((projectMap) => Project.fromMap(projectMap))
          .toList()
          .firstWhere(
            (project) => project.id == projectId,
          );
    }
    throw Exception();
  }

  Future<String> addProject(Project project) async {
    Response response = await post(Uri.https(ApiUri.host, url),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'plain/text',
        },
        body: project.toJson());

    if (response.statusCode == 200) {
      return response.body;
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
}
