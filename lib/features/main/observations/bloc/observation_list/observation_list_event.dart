// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'observation_list_bloc.dart';

abstract class ObservationListEvent extends Equatable {
  const ObservationListEvent();

  @override
  List<Object?> get props => [];
}

class ObservationListLoaded extends ObservationListEvent {}

class ObservationListFiltered extends ObservationListEvent {
  final FilteredTableParameter option;
  const ObservationListFiltered({
    required this.option,
  });

  @override
  List<Object?> get props => [option];
}

class ObservationListObservationSelected extends ObservationListEvent {
  final Observation observation;
  const ObservationListObservationSelected({
    required this.observation,
  });

  @override
  List<Object?> get props => [observation];
}
