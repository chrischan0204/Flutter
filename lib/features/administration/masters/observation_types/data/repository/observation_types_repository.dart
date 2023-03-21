import 'dart:convert';

import 'package:http/http.dart';
import 'package:safety_eta/constants/uri.dart';

import '../model/observation_type.dart';

class ObservationTypesRepository {
  Future<List<ObservationType>> getObservationTypes() async {
    Response response = await get(ApiUri.getObservationTypesUri);
    if (response.statusCode == 200) {
      List<ObservationType> observationTypes =
          List.from(jsonDecode(response.body))
              .map(
                (observationTypeJson) =>
                    ObservationType.fromMap(observationTypeJson),
              )
              .toList();
      return observationTypes;
    }
    return [];
  }
}
