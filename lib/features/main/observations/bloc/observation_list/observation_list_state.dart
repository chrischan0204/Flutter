part of 'observation_list_bloc.dart';

class ObservationListState extends Equatable {
  /// loaded observation list
  final List<Observation> observationList;

  /// observation list load status
  final EntityStatus observationListLoadStatus;

  /// total rows of observation list
  final int totalRows;
  const ObservationListState({
    this.observationList = const [],
    this.observationListLoadStatus = EntityStatus.initial,
    this.totalRows = 0,
  });

  @override
  List<Object> get props => [
        observationList,
        observationListLoadStatus,
        totalRows,
      ];

  ObservationListState copyWith({
    List<Observation>? observationList,
    EntityStatus? observationListLoadStatus,
    int? totalRows,
  }) {
    return ObservationListState(
      observationList: observationList ?? this.observationList,
      observationListLoadStatus:
          observationListLoadStatus ?? this.observationListLoadStatus,
      totalRows: totalRows ?? this.totalRows,
    );
  }
}
