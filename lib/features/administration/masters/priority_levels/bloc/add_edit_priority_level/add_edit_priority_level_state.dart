// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_edit_priority_level_bloc.dart';

class AddEditPriorityLevelState extends Equatable {
  /// loaded priority level by id
  final PriorityLevel? loadedPriorityLevel;

  /// priority level
  final String priorityLevelName;

  /// initial priority level to check form dirty
  final String initialPriorityLevelName;

  /// validation message for template priority level
  final String priorityLevelNameValidationMessage;

  /// priority level
  final String? priorityType;

  /// initial priority type to check form dirty
  final String? initialPriorityType;

  /// validation message for priority type date;
  final String priorityTypeValidationMessage;

  /// color code
  final Color colorCode;

  /// initial priority type to check form dirty
  final Color initialColorCode;

  /// deactivated
  final bool deactivated;

  /// initial deactivated
  final bool initialDeactivated;

  /// creation & edition priority level status
  final EntityStatus status;

  /// response message
  final String message;

  const AddEditPriorityLevelState({
    this.loadedPriorityLevel,
    this.priorityLevelName = '',
    this.initialPriorityLevelName = '',
    this.priorityLevelNameValidationMessage = '',
    this.priorityType,
    this.initialPriorityType,
    this.priorityTypeValidationMessage = '',
    this.colorCode = Colors.white,
    this.initialColorCode = Colors.white,
    this.deactivated = false,
    this.initialDeactivated = false,
    this.status = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        loadedPriorityLevel,
        priorityLevelName,
        initialPriorityLevelName,
        priorityLevelNameValidationMessage,
        priorityType,
        initialPriorityType,
        priorityTypeValidationMessage,
        colorCode,
        initialColorCode,
        deactivated,
        initialDeactivated,
        status,
        message,
      ];

  bool get formDirty =>
      (!Validation.isEmpty(priorityLevelName) &&
          priorityLevelName != initialPriorityLevelName) ||
      (priorityType != null && priorityType != initialPriorityType) ||
      colorCode != initialColorCode ||
      deactivated != initialDeactivated;

  PriorityLevel get priorityLevel => PriorityLevel(
        colorCode: colorCode,
        priorityType: priorityType!,
        name: priorityLevelName,
        active: !deactivated,
      );

  AddEditPriorityLevelState copyWith({
    Nullable<PriorityLevel?>? loadedPriorityLevel,
    String? priorityLevelName,
    String? initialPriorityLevelName,
    String? priorityLevelNameValidationMessage,
    Nullable<String?>? priorityType,
    String? initialPriorityType,
    String? priorityTypeValidationMessage,
    Color? colorCode,
    Color? initialColorCode,
    bool? deactivated,
    bool? initialDeactivated,
    EntityStatus? status,
    String? message,
  }) {
    return AddEditPriorityLevelState(
      loadedPriorityLevel: loadedPriorityLevel != null
          ? loadedPriorityLevel.value
          : this.loadedPriorityLevel,
      priorityLevelName: priorityLevelName ?? this.priorityLevelName,
      initialPriorityLevelName:
          initialPriorityLevelName ?? this.initialPriorityLevelName,
      priorityLevelNameValidationMessage: priorityLevelNameValidationMessage ??
          this.priorityLevelNameValidationMessage,
      priorityType:
          priorityType != null ? priorityType.value : this.priorityType,
      initialPriorityType: initialPriorityType ?? this.initialPriorityType,
      priorityTypeValidationMessage:
          priorityTypeValidationMessage ?? this.priorityTypeValidationMessage,
      colorCode: colorCode ?? this.colorCode,
      initialColorCode: initialColorCode ?? this.initialColorCode,
      deactivated: deactivated ?? this.deactivated,
      initialDeactivated: initialDeactivated ?? this.initialDeactivated,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
