// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_edit_awareness_group_bloc.dart';

abstract class AddEditAwarenessGroupEvent extends Equatable {
  const AddEditAwarenessGroupEvent();

  @override
  List<Object> get props => [];
}

class AddEditAwarenessGroupLoaded extends AddEditAwarenessGroupEvent {
  /// awareness group id to load
  final String id;

  const AddEditAwarenessGroupLoaded({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class AddEditAwarenessGroupAdded extends AddEditAwarenessGroupEvent {}

class AddEditAwarenessGroupEdited extends AddEditAwarenessGroupEvent {
  /// awareness group id to edit
  final String id;

  const AddEditAwarenessGroupEdited({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class AddEditAwarenessGroupNameChanged extends AddEditAwarenessGroupEvent {
  /// awareness group name to change
  final String name;

  const AddEditAwarenessGroupNameChanged({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}
