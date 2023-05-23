import 'dart:convert';

import '/common_libraries.dart';

class SectionsRepository extends BaseRepository {
  SectionsRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/audits/sections');

  Future<List<ResponseScaleItem>> getSectionItemList(String sectionId) async {
    Response response = await super.get('$url/$sectionId/items');

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => ResponseScaleItem.fromMap(e))
          .toList();
    }

    throw Exception();
  }

  Future<EntityResponse> createTemplateSectionItem(
      TemplateSectionItem templateSectionItem) async {
    Response response =
        await super.post('$url/items', body: templateSectionItem.toJson());

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: 'message',
      );
    }

    throw Exception();
  }
}
