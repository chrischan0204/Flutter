import '/common_libraries.dart';

class TemplatesRepository extends BaseRepository {
  TemplatesRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/audits/templates');

  /// get template list
  Future<List<Template>> getTemplateList() async {
    Response response = await super.get(url);

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => Template.fromMap(e))
          .toList();
    }
    throw Exception();
  }


  /// get template by id
  Future<Template> getTemplateById(String templateId) async {
    Response response = await super.get('$url/$templateId');

    if (response.statusCode == 200) {
      return Template.fromJson(response.body);
    }

    throw Exception();
  }

  /// add template 
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

  /// edit template 
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

  /// delete template by id
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

  /// get filtered template list
  Future<FilteredTemplateData> getFilteredTemplateList(
      FilteredTableParameter option) async {
    Response response = await super.filter(option);

    if (response.statusCode == 200) {
      return FilteredTemplateData.fromJson(response.body);
    }
    throw Exception();
  }

  /// get template section list
  Future<List<TemplateSectionListItem>> getTemplateSectionList(
      String templateId) async {
    Response response = await super.get('$url/$templateId/sections');

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => TemplateSectionListItem.fromMap(e))
          .toList();
    }
    throw Exception();
  }

  /// add template section
  Future<EntityResponse> addTemplateSection(
    TemplateSectionListItem templateSection,
    String templateId,
  ) async {
    Response response =
        await super.post('$url/sections', body: templateSection.toJson());

    return EntityResponse.fromJson(response.body)
        .copyWith(statusCode: response.statusCode);
  }

  /// get template snap shot list for template detail
  Future<List<TemplateSnapshot>> getTemplateSnapshotList(
      String templateId) async {
    Response response = await super.get('$url/$templateId/snapshots');

    return List.from(json.decode(response.body))
        .map((e) => TemplateSnapshot.fromMap(e))
        .toList();
  }

  /// get template section list for template detail
  Future<List<TemplateSectionListItemForDetail>> getTemplateSectionListForDetail(
      String templateId) async {
    Response response = await super.get('$url/$templateId/sectionlist');

    return List.from(json.decode(response.body))
        .map((e) => TemplateSectionListItemForDetail.fromMap(e))
        .toList();
  }
}
