part of 'add_edit_observation_type_bloc.dart';

class AddEditObservationTypeState extends Equatable {
  /// loaded observation type
  final ObservationType? loadedObservationType;

  /// observation type name
  final String observationTypeName;

  /// initial observation type name to check form dirty
  final String initialObservationTypeName;

  /// validation message for observation type name
  final String observationTypeNameValidationMessage;

  /// observation type severity
  final String? observationTypeSeverity;

  /// initial observation type severity to check form dirty
  final String? initialObservationTypeSeverity;

  /// validation message for observation type severity
  final String observationTypeSeverityValidationMessage;

  /// observation type visibility
  final String? observationTypeVisibility;

  /// initial observation type visibility to check form dirty
  final String? initialObservationTypeVisibility;

  /// deactivated
  final bool deactivated;

  /// initial deactivated
  final bool initialDeactivated;

  /// creation & edition observation type
  final EntityStatus status;

  /// response message
  final String message;

  const AddEditObservationTypeState({
    this.loadedObservationType,
    this.observationTypeName = '',
    this.initialObservationTypeName = '',
    this.observationTypeNameValidationMessage = '',
    this.observationTypeSeverity,
    this.initialObservationTypeSeverity,
    this.observationTypeSeverityValidationMessage = '',
    this.observationTypeVisibility,
    this.initialObservationTypeVisibility,
    this.deactivated = false,
    this.initialDeactivated = false,
    this.status = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        loadedObservationType,
        observationTypeName,
        initialObservationTypeName,
        observationTypeNameValidationMessage,
        observationTypeSeverity,
        initialObservationTypeSeverity,
        observationTypeSeverityValidationMessage,
        observationTypeVisibility,
        initialObservationTypeVisibility,
        deactivated,
        initialDeactivated,
        status,
        message,
      ];

  bool get formDirty =>
      (Validation.isNotEmpty(observationTypeName) &&
          observationTypeName != initialObservationTypeName) ||
      (observationTypeSeverity != null &&
          observationTypeSeverity != initialObservationTypeSeverity) ||
      (observationTypeVisibility != null &&
          observationTypeVisibility != initialObservationTypeVisibility) ||
      (deactivated != initialDeactivated);

  ObservationType get observationType => ObservationType(
        name: observationTypeName,
        severity: observationTypeSeverity!,
        visibility: observationTypeVisibility,
        active: !deactivated,
      );

  AddEditObservationTypeState copyWith({
    Nullable<ObservationType?>? loadedObservationType,
    String? observationTypeName,
    String? initialObservationTypeName,
    String? observationTypeNameValidationMessage,
    Nullable<String?>? observationTypeSeverity,
    Nullable<String?>? initialObservationTypeSeverity,
    String? observationTypeSeverityValidationMessage,
    Nullable<String?>? observationTypeVisibility,
    Nullable<String?>? initialObservationTypeVisibility,
    bool? deactivated,
    bool? initialDeactivated,
    EntityStatus? status,
    String? message,
  }) {
    return AddEditObservationTypeState(
      loadedObservationType: loadedObservationType != null
          ? loadedObservationType.value
          : this.loadedObservationType,
      observationTypeName: observationTypeName ?? this.observationTypeName,
      initialObservationTypeName:
          initialObservationTypeName ?? this.initialObservationTypeName,
      observationTypeNameValidationMessage:
          observationTypeNameValidationMessage ??
              this.observationTypeNameValidationMessage,
      observationTypeSeverity: observationTypeSeverity != null
          ? observationTypeSeverity.value
          : this.observationTypeSeverity,
      initialObservationTypeSeverity: initialObservationTypeSeverity != null
          ? initialObservationTypeSeverity.value
          : this.initialObservationTypeSeverity,
      observationTypeSeverityValidationMessage:
          observationTypeSeverityValidationMessage ??
              this.observationTypeSeverityValidationMessage,
      observationTypeVisibility: observationTypeVisibility != null
          ? observationTypeVisibility.value
          : this.observationTypeVisibility,
      initialObservationTypeVisibility: initialObservationTypeVisibility != null
          ? initialObservationTypeVisibility.value
          : this.initialObservationTypeVisibility,
      deactivated: deactivated ?? this.deactivated,
      initialDeactivated: initialDeactivated ?? this.initialDeactivated,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
