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

  /// update template section
  Future<EntityResponse> updateTemplateSection(
      TemplateSectionListItem templateSection) async {
    Response response =
        await super.put('$url/sections', body: templateSection.toJson());

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: response.body,
      );
    }

    throw Exception();
  }

  /// delete template section
  Future<EntityResponse> deleteTemplateSection(String sectionId) async {
    Response response = await super.delete('$url/sections/$sectionId');

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: response.body,
      );
    }

    if (response.statusCode == 409) {
      return EntityResponse.fromJson(response.body);
    }

    throw Exception();
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
  Future<List<TemplateSectionListItemForDetail>>
      getTemplateSectionListForDetail(String templateId) async {
    Response response = await super.get('$url/$templateId/sectionlist');

    return List.from(json.decode(response.body))
        .map((e) => TemplateSectionListItemForDetail.fromMap(e))
        .toList();
  }

  /// get template question details
  Future<List<TemplateSection>> getTemplateQuestionDetailList(
    String id,
    int itemType,
    String? templateSectionId,
  ) async {
    Map<String, String> map = {'itemType': itemType.toString()};

    if (templateSectionId != null) {
      map.addEntries(
          [MapEntry('templateSectionId', templateSectionId.toString())]);
    }
    Response response = await super.get('$url/$id/details', map);

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => TemplateSection.fromMap(e))
          .toList();
    }

    throw Exception();
  }

  /// get template audit list
  Future<AuditTemplateSnapshot> getTemplateAuditSnapshot(
      String templateId) async {
    Response response = await super.get('$url/$templateId/auditsnapshots');

    if (response.statusCode == 200) {
      return AuditTemplateSnapshot.fromJson(response.body);
    }

    throw Exception();
  }

  /// get template usage summary
  Future<TemplateUsageSummary> getTemplateUsageSummary(
      String templateId) async {
    Response response = await super.get('$url/$templateId/usagesummary');

    if (response.statusCode == 200) {
      return TemplateUsageSummary.fromJson(response.body);
    }

    throw Exception();
  }

  /// sort section list
  Future<EntityResponse> sortTemplateSectionList(
      List<SortOrder> sortOrderList) async {
    Response response =
        await super.post('$url/section/sort', body: jsonEncode(sortOrderList));

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: '',
      );
    }

    throw Exception();
  }

  /// sort question list for section
  Future<EntityResponse> sortTemplateSectionQuestionList(
      List<SortOrder> sortOrderList) async {
    Response response = await super
        .post('$url/sectionitems/sort', body: jsonEncode(sortOrderList));

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: '',
      );
    }

    throw Exception();
  }

  /// delete template by id
  Future<EntityResponse> deleteQuestion(String questionId) async {
    Response response = await super.delete('$url/sectionitems/$questionId');

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
}
