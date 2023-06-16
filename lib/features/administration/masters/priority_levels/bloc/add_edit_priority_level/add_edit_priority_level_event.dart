part of 'add_edit_priority_level_bloc.dart';

abstract class AddEditPriorityLevelEvent extends Equatable {
  const AddEditPriorityLevelEvent();

  @override
  List<Object> get props => [];
}

class AddEditPriorityLevelAdded extends AddEditPriorityLevelEvent {}

class AddEditPriorityLevelEdited extends AddEditPriorityLevelEvent {
  /// priority level id to edit
  final String id;

  const AddEditPriorityLevelEdited({required this.id});
  @override
  List<Object> get props => [id];
}

class AddEditPriorityLevelLoaded extends AddEditPriorityLevelEvent {
  /// priority level id to load
  final String id;

  const AddEditPriorityLevelLoaded({required this.id});

  @override
  List<Object> get props => [id];
}

class AddEditPriorityLevelChanged extends AddEditPriorityLevelEvent {
  /// priority level to change
  final String priorityLevel;

  const AddEditPriorityLevelChanged({
    required this.priorityLevel,
  });

  @override
  List<Object> get props => [priorityLevel];
}

class AddEditPriorityLevelTypeChanged extends AddEditPriorityLevelEvent {
  /// priority type to change
  final String priorityType;

  const AddEditPriorityLevelTypeChanged({
    required this.priorityType,
  });

  @override
  List<Object> get props => [priorityType];
}

class AddEditPriorityLevelColorCodeChanged extends AddEditPriorityLevelEvent {
  /// color code to change
  final Color colorCode;

  const AddEditPriorityLevelColorCodeChanged({
    required this.colorCode,
  });

  @override
  List<Object> get props => [colorCode];
}

class AddEditPriorityLevelDeactivatedChanged extends AddEditPriorityLevelEvent {
  /// deactivated to change
  final bool deactivated;

  const AddEditPriorityLevelDeactivatedChanged({required this.deactivated});

  @override
  List<Object> get props => [deactivated];
}
