import 'dart:convert';
import 'package:safety_eta/data/repository/base_repository.dart';

import '/data/model/entity.dart';
import '../model/awareness_category.dart';

class AwarenessCategoriesRepository extends BaseRepository {
  AwarenessCategoriesRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/AwarenessCategory');

  /// get awareness categories list from api
  Future<List<AwarenessCategory>> getAwarenessCategorieList() async {
    Response response = await super.get(url);

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

  /// get active awareness categories list from api
  Future<List<Entity>> getActiveAwarenessCategorieList() async {
    Response response = await super.get('$url/items');

    if (response.statusCode == 200) {
      List<Entity> awarenessCategories = List.from(jsonDecode(response.body))
          .map((awarenessCategoryJson) => Entity.fromMap(awarenessCategoryJson))
          .toList();
      return awarenessCategories;
    }

    throw Exception();
  }

  /// get awareness category by id from api
  Future<AwarenessCategory> getAwarenessCategoryById(
    String awarenessCategoryId,
  ) async {
    Response response = await super.get('$url/$awarenessCategoryId');

    if (response.statusCode == 200) {
      return AwarenessCategory.fromJson(response.body);
    }
    throw Exception();
  }

  /// add awareness category using api
  Future<EntityResponse> addAwarenessCategory(
    AwarenessCategory awarenessCategory,
  ) async {
    Response response = await super.post(
      url,
      body: awarenessCategory.toJson(),
    );

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  /// awareness category using api
  Future<EntityResponse> editAwarenessCategory(
    AwarenessCategory awarenessCategory,
  ) async {
    Response response = await super.put(
      url,
      body: awarenessCategory.toJson(),
    );

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  /// delete awarness category by id
  Future<EntityResponse> deleteAwarenessCategory(
    String awarenessCategoryId,
  ) async {
    Response response = await super.delete('$url/$awarenessCategoryId');

    if (response.statusCode == 200) {
      return EntityResponse(
        statusCode: response.statusCode,
        isSuccess: true,
        message: 'Awareness Category deleted successfully',
      );
    } else {
      if (response.statusCode == 409) {
        return EntityResponse.fromJson(response.body);
      }
    }

    throw Exception();
  }
}
