import 'dart:convert';
import 'package:http/http.dart';
import 'package:safety_eta/data/repository/base_repository.dart';
import '/constants/uri.dart';

import '/data/model/entity.dart';
import '../model/awareness_category.dart';

class AwarenessCategoriesRepository extends BaseRepository {
  AwarenessCategoriesRepository({required super.token})
      : super(url: '/api/AwarenessCategory');

  // get awareness categories list from api
  Future<List<AwarenessCategory>> getAwarenessCategories() async {
    Response response =
        await get(Uri.https(ApiUri.host, url), headers: headers);

    if (response.statusCode == 200) {
      List<AwarenessCategory> awarenessCategories =
          List.from(jsonDecode(response.body))
              .map((awarenessCategoryJson) =>
                  AwarenessCategory.fromMap(awarenessCategoryJson))
              .toList();
      return awarenessCategories;
    }
    return <AwarenessCategory>[];
  }

  // get awareness category by id from api
  Future<AwarenessCategory> getAwarenessCategoryById(
    String awarenessCategoryId,
  ) async {
    Response response = await get(
        Uri.https(ApiUri.host, '$url/$awarenessCategoryId'),
        headers: headers);

    if (response.statusCode == 200) {
      return AwarenessCategory.fromJson(response.body);
    }
    throw Exception();
  }

  // add awareness category using api
  Future<EntityResponse> addAwarenessCategory(
    AwarenessCategory awarenessCategory,
  ) async {
    Response response = await post(
      Uri.https(ApiUri.host, url),
      headers: headers,
      body: awarenessCategory.toJson(),
    );

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  // awareness category using api
  Future<EntityResponse> editAwarenessCategory(
    AwarenessCategory awarenessCategory,
  ) async {
    Response response = await put(
      Uri.https(ApiUri.host, url),
      headers: headers,
      body: awarenessCategory.toJson(),
    );

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  // delete awarness category by id
  Future<EntityResponse> deleteAwarenessCategory(
    String awarenessCategoryId,
  ) async {
    Response response = await delete(
        Uri.https(ApiUri.host, '$url/$awarenessCategoryId'),
        headers: headers);

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: 'Awareness Category deleted successfully',
      );
    }

    throw Exception();
  }
}
