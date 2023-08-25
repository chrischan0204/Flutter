part of 'add_edit_awareness_category_bloc.dart';

abstract class AddEditAwarenessCategoryEvent extends Equatable {
  const AddEditAwarenessCategoryEvent();

  @override
  List<Object> get props => [];
}

/// event to load category detail by id
class AddEditAwarenessCategoryLoaded extends AddEditAwarenessCategoryEvent {
  /// awareness category id to load
  final String id;
  const AddEditAwarenessCategoryLoaded({
    required this.id,
  });
}

/// event to load category group list
class AddEditAwarenessCategoryGroupListLoaded
    extends AddEditAwarenessCategoryEvent {}

/// event to add awareness category
class AddEditAwarenessCategoryAdded extends AddEditAwarenessCategoryEvent {}

/// event to edit awareness category
class AddEditAwarenessCategoryEdited extends AddEditAwarenessCategoryEvent {
  /// awareness category id to edit
  final String id;
  const AddEditAwarenessCategoryEdited({
    required this.id,
  });
}

/// event to change awareness category name
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

/// event to change category group
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

/// event to change deactivated
class AddEditAwarenessCategoryDeactivatedChanged
    extends AddEditAwarenessCategoryEvent {
  /// deactivated to change
  final bool deactivated;

  const AddEditAwarenessCategoryDeactivatedChanged({required this.deactivated});

  @override
  List<Object> get props => [deactivated];
}
