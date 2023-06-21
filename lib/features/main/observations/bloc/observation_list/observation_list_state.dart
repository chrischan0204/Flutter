// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'observation_list_bloc.dart';

class ObservationListState extends Equatable {
  /// loaded observation list
  final List<Observation> observationList;

  /// observation list load status
  final EntityStatus observationListLoadStatus;

  /// select observation for detail
  final Observation? observation;

  /// total rows of observation list
  final int totalRows;
  const ObservationListState({
    this.observationList = const [],
    this.observation,
    this.observationListLoadStatus = EntityStatus.initial,
    this.totalRows = 0,
  });

  @override
  List<Object?> get props => [
        observationList,
        observationListLoadStatus,
        observation,
        totalRows,
      ];

  ObservationListState copyWith({
    List<Observation>? observationList,
    EntityStatus? observationListLoadStatus,
    Observation? observation,
    int? totalRows,
  }) {
    return ObservationListState(
      observationList: observationList ?? this.observationList,
      observationListLoadStatus:
          observationListLoadStatus ?? this.observationListLoadStatus,
      observation: observation ?? this.observation,
      totalRows: totalRows ?? this.totalRows,
    );
  }
}
