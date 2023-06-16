// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_edit_awareness_category_bloc.dart';

class AddEditAwarenessCategoryState extends Equatable {
  /// loaded awareness category
  final AwarenessCategory? loadedAwarenessCategory;

  /// awareness group list
  final List<AwarenessGroup> awarenessGroupList;

  /// awareness group
  final AwarenessGroup? awarenessGroup;

  /// intial awreness group to check form dirty
  final AwarenessGroup? initialAwarenessGroup;

  /// validation message for awareness group
  final String awarenessGroupValidationMessage;

  /// awareness category name
  final String name;

  /// initial awarenss category name to check form dirty
  final String initialName;

  /// validation message for awareness category
  final String nameValidationMessage;

  /// deactivated
  final bool deactivated;

  /// initial deactivated
  final bool initialDeactivated;

  /// creation & edition observation type
  final EntityStatus status;

  /// response message
  final String message;

  const AddEditAwarenessCategoryState({
    this.loadedAwarenessCategory,
    this.awarenessGroupList = const [],
    this.awarenessGroup,
    this.initialAwarenessGroup,
    this.awarenessGroupValidationMessage = '',
    this.name = '',
    this.initialName = '',
    this.nameValidationMessage = '',
    this.deactivated = false,
    this.initialDeactivated = false,
    this.status = EntityStatus.initial,
    this.message = '',
  });

  bool get formDirty =>
      (awarenessGroup != null &&
          awarenessGroup?.id != initialAwarenessGroup?.id) ||
      (Validation.isNotEmpty(name) && name != initialName) ||
      deactivated != initialDeactivated;

  AwarenessCategory get awarenessCategory => AwarenessCategory(
        name: name,
        groupId: awarenessGroup!.id!,
        groupName: awarenessGroup!.name!,
        active: !deactivated,
      );

  @override
  List<Object?> get props => [
        loadedAwarenessCategory,
        awarenessGroupList,
        awarenessGroup,
        initialAwarenessGroup,
        awarenessGroupValidationMessage,
        name,
        initialName,
        nameValidationMessage,
        deactivated,
        initialDeactivated,
        status,
        message,
      ];

  AddEditAwarenessCategoryState copyWith({
    AwarenessCategory? loadedAwarenessCategory,
    List<AwarenessGroup>? awarenessGroupList,
    AwarenessGroup? awarenessGroup,
    AwarenessGroup? initialAwarenessGroup,
    String? awarenessGroupValidationMessage,
    String? name,
    String? initialName,
    String? nameValidationMessage,
    bool? deactivated,
    bool? initialDeactivated,
    EntityStatus? status,
    String? message,
  }) {
    return AddEditAwarenessCategoryState(
      loadedAwarenessCategory:
          loadedAwarenessCategory ?? this.loadedAwarenessCategory,
      awarenessGroupList: awarenessGroupList ?? this.awarenessGroupList,
      awarenessGroup: awarenessGroup ?? this.awarenessGroup,
      initialAwarenessGroup:
          initialAwarenessGroup ?? this.initialAwarenessGroup,
      awarenessGroupValidationMessage: awarenessGroupValidationMessage ??
          this.awarenessGroupValidationMessage,
      name: name ?? this.name,
      initialName: initialName ?? this.initialName,
      nameValidationMessage:
          nameValidationMessage ?? this.nameValidationMessage,
      deactivated: deactivated ?? this.deactivated,
      initialDeactivated: initialDeactivated ?? this.initialDeactivated,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
