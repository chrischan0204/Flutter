// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'observation_list_bloc.dart';

class ObservationListState extends Equatable {
  /// loaded observation list
  final List<Observation> observationList;

  /// observation list load status
  final EntityStatus observationListLoadStatus;

  /// selected observation for detail
  final Observation? observation;

  /// observation load status
  final EntityStatus observationLoadStatus;

  /// total rows of observation list
  final int totalRows;
  const ObservationListState({
    this.observationList = const [],
    this.observation,
    this.observationListLoadStatus = EntityStatus.initial,
    this.observationLoadStatus = EntityStatus.initial,
    this.totalRows = 0,
  });

  @override
  List<Object?> get props => [
        observationList,
        observationListLoadStatus,
        observationLoadStatus,
        observation,
        totalRows,
      ];

  ObservationListState copyWith({
    List<Observation>? observationList,
    EntityStatus? observationListLoadStatus,
    Observation? observation,
    EntityStatus? observationLoadStatus,
    int? totalRows,
  }) {
    return ObservationListState(
      observationList: observationList ?? this.observationList,
      observationListLoadStatus:
          observationListLoadStatus ?? this.observationListLoadStatus,
      observation: observation ?? this.observation,
      observationLoadStatus:
          observationLoadStatus ?? this.observationLoadStatus,
      totalRows: totalRows ?? this.totalRows,
    );
  }
}
