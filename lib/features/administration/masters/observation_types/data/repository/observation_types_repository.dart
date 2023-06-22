import 'dart:convert';

import '/data/repository/base_repository.dart';
import '/data/model/model.dart';

class ObservationTypesRepository extends BaseRepository {
  ObservationTypesRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/ObservationType');
  Future<List<ObservationType>> getObservationTypeList() async {
    Response response = await super.get(
      url,
    );
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
    Response response = await super.get('$url/$observationTypeId');

    if (response.statusCode == 200) {
      return ObservationType.fromJson(response.body);
    }
    throw Exception('');
  }

  Future<EntityResponse> addObservationType(
      ObservationType observationType) async {
    Response response = await super.post(
      url,
      body: observationType.toJson(),
    );

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> editObservationType(
      ObservationType observationType) async {
    Response response = await super.put(
      url,
      body: observationType.toJson(),
    );

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> deleteObservationType(String observationTypeId) async {
    Response response = await super.delete('$url/$observationTypeId');

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }
}
