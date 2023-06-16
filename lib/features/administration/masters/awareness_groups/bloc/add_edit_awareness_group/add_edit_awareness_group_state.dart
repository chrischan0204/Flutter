part of 'add_edit_awareness_group_bloc.dart';

class AddEditAwarenessGroupState extends Equatable {
  /// loaded awareness group
  final AwarenessGroup? loadedAwarenessGroup;

  /// awareness group name
  final String name;

  /// initial awarnesss group name to check form dirty
  final String initialName;

  /// validation message for awarness group name
  final String nameValidationMessage;

  /// creation & edition observation type
  final EntityStatus status;

  /// response message
  final String message;

  const AddEditAwarenessGroupState({
    this.loadedAwarenessGroup,
    this.name = '',
    this.initialName = '',
    this.nameValidationMessage = '',
    this.status = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        loadedAwarenessGroup,
        name,
        initialName,
        nameValidationMessage,
        status,
        message,
      ];

  bool get formDirty => Validation.isNotEmpty(name) && name != initialName;

  AwarenessGroup get awarenessGroup => AwarenessGroup(name: name);

  AddEditAwarenessGroupState copyWith({
    AwarenessGroup? loadedAwarenessGroup,
    String? name,
    String? initialName,
    String? nameValidationMessage,
    EntityStatus? status,
    String? message,
  }) {
    return AddEditAwarenessGroupState(
      loadedAwarenessGroup: loadedAwarenessGroup ?? this.loadedAwarenessGroup,
      name: name ?? this.name,
      initialName: initialName ?? this.initialName,
      nameValidationMessage:
          nameValidationMessage ?? this.nameValidationMessage,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
