import 'dart:convert';

import 'package:http/http.dart';
import 'package:safety_eta/constants/uri.dart';

import '/data/model/model.dart';

class ObservationTypesRepository {
  static String url = '/api/ObservationType';
  Future<List<ObservationType>> getObservationTypes() async {
    Response response = await get(Uri.https(ApiUri.host, url));
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

  Future<ObservationType> getObservationTypeById(
      String observationTypeId) async {
    Response response =
        await get(Uri.https(ApiUri.host, '$url/$observationTypeId'));

    if (response.statusCode == 200) {
      return ObservationType.fromJson(response.body);
    }
    throw Exception('');
  }

  Future<EntityResponse> addObservationType(
      ObservationType observationType) async {
    Response response = await post(
      Uri.https(ApiUri.host, url),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'text/plain',
      },
      body: observationType.toJson(),
    );

    if (response.statusCode == 200) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> editObservationType(
      ObservationType observationType) async {
    Response response = await put(Uri.https(ApiUri.host, url),
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
        body: observationType.toJson());

    if (response.statusCode == 200) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> deleteObservationType(String observationTypeId) async {
    Response response = await delete(
      Uri.https(ApiUri.host, '$url/$observationTypeId'),
    );

    if (response.statusCode == 200) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }
}
