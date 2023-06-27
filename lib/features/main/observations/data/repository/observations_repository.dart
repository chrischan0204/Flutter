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

  /// get action item list
  Future<List<ActionItem>> getActionItemList(String auditId) async {
    return [
      ActionItem(
        id: const Uuid().v1(),
        task: 'Inspect the staircase on an ASAP basis.',
        due: DateTime.now(),
        assignee: 'Olive Alex',
        category: 'Bio Hazard',
        company: 'Green and Sons',
        project: 'Darren',
        location: 'By the admin office',
        notes: 'The task was closed after inspection',
        status: ActionItemStatus.open,
      ),
      ActionItem(
        id: const Uuid().v1(),
        task: 'Assign a cleaning crew to address this',
        due: DateTime.now(),
        assignee: 'Alexander Korshunov',
        category: 'Category',
        company: 'Comic Maroon',
        project: 'Blackwater',
        location: 'By the admin office',
        notes: 'The task was closed after inspection',
        status: ActionItemStatus.closed,
      ),
    ];
  }
}
