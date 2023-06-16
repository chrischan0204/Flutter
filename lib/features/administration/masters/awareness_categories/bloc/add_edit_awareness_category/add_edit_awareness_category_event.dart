part of 'add_edit_awareness_category_bloc.dart';

abstract class AddEditAwarenessCategoryEvent extends Equatable {
  const AddEditAwarenessCategoryEvent();

  @override
  List<Object> get props => [];
}

class AddEditAwarenessCategoryLoaded extends AddEditAwarenessCategoryEvent {
  /// awareness category id to load
  final String id;
  const AddEditAwarenessCategoryLoaded({
    required this.id,
  });
}

class AddEditAwarenessCategoryGroupListLoaded
    extends AddEditAwarenessCategoryEvent {}

class AddEditAwarenessCategoryAdded extends AddEditAwarenessCategoryEvent {}

class AddEditAwarenessCategoryEdited extends AddEditAwarenessCategoryEvent {
  /// awareness category id to edit
  final String id;
  const AddEditAwarenessCategoryEdited({
    required this.id,
  });
}

class AddEditAwarenessCategoryNameChanged
    extends AddEditAwarenessCategoryEvent {
  /// awareness category name to change
  final String name;
  const AddEditAwarenessCategoryNameChanged({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}

class AddEditAwarenessCategoryGroupChanged
    extends AddEditAwarenessCategoryEvent {
  /// awareness group to change
  final AwarenessGroup awarenessGroup;
  const AddEditAwarenessCategoryGroupChanged({
    required this.awarenessGroup,
  });

  @override
  List<Object> get props => [awarenessGroup];
}

class AddEditAwarenessCategoryDeactivatedChanged
    extends AddEditAwarenessCategoryEvent {
  /// deactivated to change
  final bool deactivated;

  const AddEditAwarenessCategoryDeactivatedChanged({required this.deactivated});

  @override
  List<Object> get props => [deactivated];
}
