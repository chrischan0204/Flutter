import '/common_libraries.dart';

class SectionsRepository extends BaseRepository {
  SectionsRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/audits/templates/sections');

  /// get template section item list 
  Future<List<TemplateSectionQuestion>> getSectionItemList(
      String sectionId) async {
    Response response = await super.get('$url/$sectionId/items');

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => TemplateSectionQuestion.fromMap(e))
          .toList();
    }

    throw Exception();
  }

  /// add new template section item
  Future<EntityResponse> createTemplateSectionItem(
      TemplateSectionItem templateSectionItem) async {
    Response response =
        await super.post('$url/items', body: templateSectionItem.toJson());

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          isSuccess: true,
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      return EntityResponse.fromJson(response.body);
    }

    throw Exception();
  }

  /// update template section item
  Future<EntityResponse> editTemplateSectionItem(
      TemplateSectionItem templateSectionItem) async {
    Response response =
        await super.put('$url/items', body: templateSectionItem.toJson());

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          isSuccess: true,
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      return EntityResponse.fromJson(response.body);
    }

    throw Exception();
  }

  /// get question detail
  Future<QuestionDetail> getQuestionDetail(String id, int itemType) async {
    Response response = await super
        .get('$url/$id/itemdetails', {'itemType': itemType.toString()});

    if (response.statusCode == 200) {
      return QuestionDetail.fromJson(response.body);
    }

    throw Exception();
  }
}
