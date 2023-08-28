// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'observation_list_bloc.dart';

abstract class ObservationListEvent extends Equatable {
  const ObservationListEvent();

  @override
  List<Object?> get props => [];
}

/// event to load observation list
class ObservationListLoaded extends ObservationListEvent {}

class ObservationListFiltered extends ObservationListEvent {
  final FilteredTableParameter option;
  const ObservationListFiltered({
    required this.option,
  });

  @override
  List<Object?> get props => [option];
}

/// event to load observation detail for side
class ObservationListObservationForSideDetailLoaded
    extends ObservationListEvent {
  final String observationId;
  const ObservationListObservationForSideDetailLoaded(
      {required this.observationId});

  @override
  List<Object?> get props => [observationId];
}
