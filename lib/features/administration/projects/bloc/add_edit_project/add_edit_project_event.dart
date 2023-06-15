part of 'add_edit_project_bloc.dart';

abstract class AddEditProjectEvent extends Equatable {
  const AddEditProjectEvent();

  @override
  List<Object> get props => [];
}

/// event to add project
class AddEditProjectAdded extends AddEditProjectEvent {}

/// event to edit project
class AddEditProjectEdited extends AddEditProjectEvent {
  /// project id to edit
  final String id;
  const AddEditProjectEdited({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

/// event to load the project by id
class AddEditProjectLoaded extends AddEditProjectEvent {
  /// project id to load
  final String id;
  const AddEditProjectLoaded({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

/// event to load the site list
class AddEditProjectSiteListLoaded extends AddEditProjectEvent {}

/// event to change the project name
class AddEditProjectNameChanged extends AddEditProjectEvent {
  /// project name to change
  final String name;
  const AddEditProjectNameChanged({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}

/// event to change the site
class AddEditProjecSiteChanged extends AddEditProjectEvent {
  /// site to change
  final Site site;
  const AddEditProjecSiteChanged({
    required this.site,
  });

  @override
  List<Object> get props => [site];
}

/// event to change the reference number
class AddEditProjectReferenceNumberChanged extends AddEditProjectEvent {
  /// reference number to change
  final String referenceNumber;
  const AddEditProjectReferenceNumberChanged({
    required this.referenceNumber,
  });

  @override
  List<Object> get props => [referenceNumber];
}

/// event to change the reference name
class AddEditProjectReferenceNameChanged extends AddEditProjectEvent {
  /// reference name to change
  final String referenceName;
  const AddEditProjectReferenceNameChanged({
    required this.referenceName,
  });

  @override
  List<Object> get props => [referenceName];
}
