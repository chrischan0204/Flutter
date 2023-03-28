part of 'sites_bloc.dart';

abstract class SitesEvent extends Equatable {
  const SitesEvent();

  @override
  List<Object> get props => [];
}

class SitesRetrieved extends SitesEvent {}
