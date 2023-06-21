import 'package:uuid/uuid.dart';

import '/common_libraries.dart';

class ObservationsRepository extends BaseRepository {
  ObservationsRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/observations');

  /// get observations list
  Future<List<Observation>> getObservationList() async {
    return [
      Observation(
        id: const Uuid().v1(),
        name: 'Broken electric wire hanging from pole',
        statusName: 'Draft',
        location: 'Delivery gate - South entrance',
        source: '--',
        reportedBy: 'Anonymous',
        reportedAt: '14th May 2021 at 2:31 PM',
        via: 'Tap in App',
        assessed: 'Yes',
        assessedBy: 'Kartik Sharma',
        assessedAs: 'Good Catch',
        actionItems: 'One assigned to Jack Donner / Open Status',
      ),
      Observation(
        id: const Uuid().v1(),
        statusName: 'In Progress',
        name: 'Broken electric wire hanging from pole',
        location: 'Delivery gate - South entrance',
        source: '--',
        reportedBy: 'Anonymous',
        reportedAt: '14th May 2021 at 2:31 PM',
        via: 'Tap in App',
        assessed: 'No',
        assessedBy: 'Josh Lucas',
        assessedAs: 'Good Catch',
        actionItems: 'One assigned to Jack Donner / Open Status',
      ),
      Observation(
        id: const Uuid().v1(),
        statusName: 'Draft',
        name: 'Broken electric wire hanging from pole',
        location: 'Delivery gate - South entrance',
        source: '--',
        reportedBy: 'Lake Shore Drive, Chicago',
        reportedAt: '14th May 2021 at 2:31 PM',
        via: 'Tap in App',
        assessed: 'Yes',
        assessedBy: 'Kartik Sharma',
        assessedAs: 'Good Catch',
        actionItems: 'One assigned to Jack Donner / Open Status',
      ),
      Observation(
        id: const Uuid().v1(),
        name: 'Broken electric wire hanging from pole',
        statusName: 'Completed',
        location: 'Delivery gate - South entrance',
        source: '--',
        reportedBy: 'Lake Shore Drive, Chicago',
        reportedAt: '14th May 2021 at 2:31 PM',
        via: 'Tap in App',
        assessed: 'No',
        assessedBy: 'Josh Lucas',
        assessedAs: 'Good Catch',
        actionItems: 'One assigned to Jack Donner / Open Status',
      )
    ];

    Response response = await super.get(url);
    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body))
          .map((observationMap) => Observation.fromMap(observationMap))
          .toList();
    }
    return [];
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

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse.fromJson(response.body);
      }
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
}
