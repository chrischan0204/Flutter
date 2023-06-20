part of 'observation_detail_bloc.dart';

abstract class ObservationDetailState extends Equatable {
  const ObservationDetailState();
  
  @override
  List<Object> get props => [];
}

class ObservationDetailInitial extends ObservationDetailState {}
