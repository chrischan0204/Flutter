import '/common_libraries.dart';

class TemplatesRepository extends BaseRepository {
  TemplatesRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/audits/templates');

  Future<List<Template>> getTemplateList() async {
    Response response = await super.get(url);

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => Template.fromMap(e))
          .toList();
    }
    throw Exception();
  }

  Future<Template> getTemplateById(String templateId) async {
    Response response = await super.get('$url/$templateId');

    if (response.statusCode == 200) {
      return Template.fromJson(response.body);
    }

    throw Exception();
  }

  Future<EntityResponse> addTemplate(Template template) async {
    Response response = await super.post(url, body: template.toJson());

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse.fromJson(response.body)
            .copyWith(statusCode: response.statusCode);
      }
      return EntityResponse.fromJson(response.body)
          .copyWith(statusCode: response.statusCode);
    }
    throw Exception();
  }

  Future<EntityResponse> editTemplate(Template template) async {
    Response response = await super.put(url, body: template.toJson());

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(isSuccess: true, message: response.body)
            .copyWith(statusCode: response.statusCode);
      }
      return EntityResponse.fromJson(response.body)
          .copyWith(statusCode: response.statusCode);
    }
    throw Exception();
  }

  Future<EntityResponse> deleteTemplate(String templateId) async {
    Response response = await super.delete('$url/$templateId');

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

  Future<FilteredTemplateData> getFilteredTemplateList(
      FilteredTableParameter option) async {
    Response response = await super.filter(option);

    if (response.statusCode == 200) {
      return FilteredTemplateData.fromJson(response.body);
    }
    throw Exception();
  }

  Future<List<TemplateSection>> getTemplateSectionList(
      String templateId) async {
    Response response = await super.get('$url/$templateId/sections');

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => TemplateSection.fromMap(e))
          .toList();
    }
    throw Exception();
  }

  Future<EntityResponse> addTemplateSection(
    TemplateSection templateSection,
    String templateId,
  ) async {
    Response response =
        await super.post('$url/sections', body: templateSection.toJson());

    return EntityResponse.fromJson(response.body)
        .copyWith(statusCode: response.statusCode);
  }

  Future<List<TemplateSnapshot>> getTemplateSnapshotList(
      String templateId) async {
    Response response = await super.get('$url/$templateId/snapshots');

    return List.from(json.decode(response.body))
        .map((e) => TemplateSnapshot.fromMap(e))
        .toList();
  }
}
