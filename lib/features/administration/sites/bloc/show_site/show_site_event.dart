// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'show_site_bloc.dart';

abstract class ShowSiteEvent extends Equatable {
  const ShowSiteEvent();

  @override
  List<Object> get props => [];
}

/// event to load site
class ShowSiteLoaded extends ShowSiteEvent {
  /// site id to load
  final String id;

  const ShowSiteLoaded({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

/// event to load audit template list
class ShowSiteAssignedAutitTemplateListLoaded extends ShowSiteEvent {
  /// site id to load template list
  final String id;

  const ShowSiteAssignedAutitTemplateListLoaded({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

/// event to load audit project list for site
class ShowSiteAssignedAutitProjectListLoaded extends ShowSiteEvent {
  /// site id to load projects list
  final String id;

  const ShowSiteAssignedAutitProjectListLoaded({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

/// event to load audit company list for site
class ShowSiteAssignedAutitCompanyListLoaded extends ShowSiteEvent {
  /// site id to load projects list
  final String id;

  const ShowSiteAssignedAutitCompanyListLoaded({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

/// event to delete site
class ShowSiteDeleted extends ShowSiteEvent {
  /// site id to delete
  final String id;

  const ShowSiteDeleted({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
