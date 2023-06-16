import '/common_libraries.dart';

part 'add_edit_priority_level_event.dart';
part 'add_edit_priority_level_state.dart';

class AddEditPriorityLevelBloc
    extends Bloc<AddEditPriorityLevelEvent, AddEditPriorityLevelState> {
  final PriorityLevelsRepository priorityLevelsRepository;
  final FormDirtyBloc formDirtyBloc;

  static String addErrorMessage =
      'There was an error while adding priority level. Our team has been notified. Please wait a few minutes and try again.';
  static String editErrorMessage =
      'There was an error while editing priority level. Our team has been notified. Please wait a few minutes and try again.';

  static String deleteErrorMessage =
      'There was an error while deleting priority level. Our team has been notified. Please wait a few minutes and try again.';

  AddEditPriorityLevelBloc({
    required this.priorityLevelsRepository,
    required this.formDirtyBloc,
  }) : super(const AddEditPriorityLevelState()) {
    on<AddEditPriorityLevelAdded>(_onAddEditPriorityLevelAdded);
    on<AddEditPriorityLevelEdited>(_onAddEditPriorityLevelEdited);
    on<AddEditPriorityLevelLoaded>(_onAddEditPriorityLevelLoaded);
    on<AddEditPriorityLevelChanged>(_onAddEditPriorityLevelChanged);
    on<AddEditPriorityLevelTypeChanged>(_onAddEditPriorityLevelTypeChanged);
    on<AddEditPriorityLevelColorCodeChanged>(
        _onAddEditPriorityLevelColorCodeChanged);
    on<AddEditPriorityLevelDeactivatedChanged>(
        _onAddEditPriorityLevelDeactivatedChanged);
  }

  Future<void> _onAddEditPriorityLevelAdded(
    AddEditPriorityLevelAdded event,
    Emitter<AddEditPriorityLevelState> emit,
  ) async {
    if (_validate(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));
      try {
        EntityResponse response = await priorityLevelsRepository
            .addPriorityLevel(state.priorityLevel);
        if (response.isSuccess) {
          emit(state.copyWith(
            initialPriorityLevelName: state.priorityLevelName,
            initialPriorityType: state.priorityType,
            initialColorCode: state.colorCode,
            initialDeactivated: state.deactivated,
            status: EntityStatus.success,
            message: response.message,
          ));

          formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
        } else {
          emit(state.copyWith(
            priorityLevelNameValidationMessage: response.message,
            status: EntityStatus.initial,
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          status: EntityStatus.failure,
          message: addErrorMessage,
        ));
      }
    }
  }

  Future<void> _onAddEditPriorityLevelEdited(
    AddEditPriorityLevelEdited event,
    Emitter<AddEditPriorityLevelState> emit,
  ) async {
    if (_validate(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));
      try {
        EntityResponse response = await priorityLevelsRepository
            .editPriorityLevel(state.priorityLevel.copyWith(id: event.id));
        if (response.isSuccess) {
          emit(state.copyWith(
            initialPriorityLevelName: state.priorityLevelName,
            initialPriorityType: state.priorityType,
            initialColorCode: state.colorCode,
            initialDeactivated: state.deactivated,
            status: EntityStatus.success,
            message: response.message,
          ));

          formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
        } else {
          emit(state.copyWith(
            priorityLevelNameValidationMessage: response.message,
            status: EntityStatus.initial,
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          status: EntityStatus.failure,
          message: editErrorMessage,
        ));
      }
    }
  }

  Future<void> _onAddEditPriorityLevelLoaded(
    AddEditPriorityLevelLoaded event,
    Emitter<AddEditPriorityLevelState> emit,
  ) async {
    try {
      PriorityLevel priorityLevel =
          await priorityLevelsRepository.getPriorityLevelById(event.id);

      emit(state.copyWith(
        loadedPriorityLevel: priorityLevel,
        priorityLevelName: priorityLevel.name,
        priorityType: priorityLevel.priorityType,
        colorCode: priorityLevel.colorCode,
        deactivated: !priorityLevel.active,
        initialPriorityLevelName: priorityLevel.name,
        initialPriorityType: priorityLevel.priorityType,
        initialColorCode: priorityLevel.colorCode,
        initialDeactivated: !priorityLevel.active,
      ));
    } catch (e) {}
  }

  void _onAddEditPriorityLevelChanged(
    AddEditPriorityLevelChanged event,
    Emitter<AddEditPriorityLevelState> emit,
  ) {
    emit(state.copyWith(
      priorityLevelName: event.priorityLevel,
      priorityLevelNameValidationMessage: '',
    ));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditPriorityLevelColorCodeChanged(
    AddEditPriorityLevelColorCodeChanged event,
    Emitter<AddEditPriorityLevelState> emit,
  ) {
    emit(state.copyWith(colorCode: event.colorCode));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditPriorityLevelTypeChanged(
    AddEditPriorityLevelTypeChanged event,
    Emitter<AddEditPriorityLevelState> emit,
  ) {
    emit(state.copyWith(
      priorityType: event.priorityType,
      priorityTypeValidationMessage: '',
    ));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditPriorityLevelDeactivatedChanged(
    AddEditPriorityLevelDeactivatedChanged event,
    Emitter<AddEditPriorityLevelState> emit,
  ) {
    emit(state.copyWith(deactivated: event.deactivated));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  /// validate the form
  bool _validate(Emitter<AddEditPriorityLevelState> emit) {
    bool success = true;

    if (Validation.isEmpty(state.priorityLevelName)) {
      emit(state.copyWith(
          priorityLevelNameValidationMessage: 'Priority level is required.'));

      success = false;
    } else if (Validation.isNotEmpty(state.priorityLevelName) &&
        !Validation.isAlphanumbericWithSpecialChars(state.priorityLevelName)) {
      emit(state.copyWith(
          priorityLevelNameValidationMessage:
              'Priority level should be alphanumeric with allow special char.'));

      success = false;
    } else if (state.priorityLevelName.length >
        PriorityLevelFormValidation.priorityLevelMaxLength) {
      emit(state.copyWith(
          priorityLevelNameValidationMessage:
              'Priority level can be ${PriorityLevelFormValidation.priorityLevelMaxLength} long at maximum.'));

      success = false;
    }

    if (Validation.isEmpty(state.priorityType)) {
      emit(state.copyWith(
          priorityTypeValidationMessage: 'Priority type is required.'));

      success = false;
    }

    return success;
  }
}
