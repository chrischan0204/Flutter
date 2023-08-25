
import '/common_libraries.dart';

class ProjectsRepository extends BaseRepository {
  ProjectsRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/Projects');

  // get projects list
  Future<List<Project>> getProjectList() async {
    Response response = await super.get(url);

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
    Response response = await super.get('$url/$projectId');

    if (response.statusCode == 200) {
      return Project.fromJson(response.body);
    }
    throw Exception();
  }

  // add project
  Future<EntityResponse> addProject(Project project) async {
    Response response = await super.post(
      url,
      body: project.toJson(),
    );

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  // edit project
  Future<EntityResponse> editProject(Project project) async {
    Response response = await super.put(
      url,
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
    Response response = await super.delete('$url/$projectId');

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

  Future<List<ProjectCompany>> getCompanyListForProject(String projectId,
      [bool? assigned, String? name]) async {
    Map<String, dynamic> map = {};
    if (assigned != null) {
      map.addEntries([MapEntry('assigned', assigned.toString())]);
    }
    if (name != null && name.isNotEmpty) {
      map.addEntries([MapEntry('name', name)]);
    }
    Response response = await super.get('$url/$projectId/companies', map);

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((projectMap) => ProjectCompany.fromMap(projectMap))
          .toList();
    }
    return [];
  }

  assignCompanyToProject(
      ProjectCompanyAssignment projectCompanyAssignment) async {
    Response response = await super.post(
      '$url/assign/company',
      body: projectCompanyAssignment.toJson(),
    );

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

  unassignCompanyFromProject(String projectCompanyAssignmentId) async {
    Response response =
        await super.post('$url/unassign/$projectCompanyAssignmentId/company');

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

  Future<FilteredProjectData> getFilteredProjectList(
      FilteredTableParameter option) async {
    Response response = await super.filter(option);

    if (response.statusCode == 200) {
      final data = FilteredProjectData.fromJson(response.body);
      return data;
    }
    throw Exception();
  }
}
