import 'dart:convert';

import 'package:http/http.dart';
import 'package:safety_eta/constants/uri.dart';

import '../model/awareness_category.dart';

class AwarenessCategoriesRepository {
  Future<List<AwarenessCategory>> getAwarenessCategories() async {
    Response response = await get(ApiUri.getAwarenessCategoriesUri);

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
}
