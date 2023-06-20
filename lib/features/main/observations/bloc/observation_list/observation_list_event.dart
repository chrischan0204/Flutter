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
