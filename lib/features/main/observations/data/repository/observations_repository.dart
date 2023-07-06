import 'package:uuid/uuid.dart';

import '/common_libraries.dart';

class ObservationsRepository extends BaseRepository {
  ObservationsRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/observations');

  /// get observations list
  Future<List<Observation>> getObservationList() async {
    return [];

    // Response response = await super.get(url);
    // if (response.statusCode == 200) {
    //   return List.from(jsonDecode(response.body))
    //       .map((observationMap) => Observation.fromMap(observationMap))
    //       .toList();
    // }
    // return [];
  }

  /// get observation by id
  Future<Observation> getObservationById(
    String observationId,
  ) async {
    Response response = await super.get('$url/$observationId');

    if (response.statusCode == 200) {
      return Observation.fromJson(response.body);
    }

    throw Exception();
  }

  /// add observation
  Future<EntityResponse> addObservation(ObservationCreate observation) async {
    Response response = await super.post(url, body: observation.toJson());

    if (response.statusCode == 200) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  /// edit observation
  Future<EntityResponse> editObservation(ObservationCreate observation) async {
    Response response = await super.put(
      url,
      body: observation.toJson(),
    );

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

  /// delete observation by id
  Future<EntityResponse> deleteObservation(String observationId) async {
    Response response = await super.delete('$url/$observationId');

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

  /// get filtered observation data
  Future<FilteredObservationData> getFilteredObservationList(
      FilteredTableParameter option) async {
    Response response = await super.filter(option);

    if (response.statusCode == 200) {
      return FilteredObservationData.fromJson(response.body);
    }
    throw Exception();
  }

  /// add aseessment
  Future<void> addAssessment(
    String observationId,
    AssessmentCreate assessmentCreate,
  ) async {
    Response response = await super.post(
      '$url/$observationId/assessments',
      body: assessmentCreate.toJson(),
    );

    if (response.statusCode == 200) {}

    throw Exception();
  }

  /// get action item list
  Future<List<ActionItem>> getActionItemList(String observationId) async {
    Response response = await super.get('$url/$observationId/actionitems');

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => ActionItem.fromMap(e))
          .toList();
    }

    throw Exception();
  }
}
