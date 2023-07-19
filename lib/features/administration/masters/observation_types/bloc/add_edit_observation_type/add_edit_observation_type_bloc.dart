import 'package:uuid/uuid.dart';

import '/common_libraries.dart';

part 'add_edit_observation_type_event.dart';
part 'add_edit_observation_type_state.dart';

class AddEditObservationTypeBloc
    extends Bloc<AddEditObservationTypeEvent, AddEditObservationTypeState> {
  final ObservationTypesRepository observationTypesRepository;
  final FormDirtyBloc formDirtyBloc;

  static String addErrorMessage = ErrorMessage('observation type').add;
  static String editErrorMessage = ErrorMessage('observation type').edit;

  AddEditObservationTypeBloc({
    required this.formDirtyBloc,
    required this.observationTypesRepository,
  }) : super(const AddEditObservationTypeState()) {
    on<AddEditObservationTypeAdded>(_onAddEditObservationTypeAdded);
    on<AddEditObservationTypeEdited>(_onAddEditObservationTypeEdited);
    on<AddEditObservationTypeLoaded>(_onAddEditObservationTypeLoaded);
    on<AddEditObservationTypeNameChanged>(_onAddEditObservationTypeNameChanged);
    on<AddEditObservationTypeSeverityChanged>(
        _onAddEditObservationTypeSeverityChanged);
    on<AddEditObservationTypeVisibilityChanged>(
        _onAddEditObservationTypeVisibilityChanged);
    on<AddEditObservationTypeDeactivatedChanged>(
        _onAddEditObservationTypeDeactivatedChanged);
  }

  Future<void> _onAddEditObservationTypeAdded(
    AddEditObservationTypeAdded event,
    Emitter<AddEditObservationTypeState> emit,
  ) async {
    if (_validate(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));
      try {
        EntityResponse response = await observationTypesRepository
            .addObservationType(state.observationType);
        if (response.isSuccess) {
          emit(state.copyWith(
            initialObservationTypeName: '',
            observationTypeName: '',
            initialObservationTypeSeverity: const Nullable.value(null),
            observationTypeSeverity: const Nullable.value(null),
            initialObservationTypeVisibility: const Nullable.value(null),
            observationTypeVisibility: const Nullable.value(null),
            loadedObservationType: Nullable.value(ObservationType(
              severity: '',
              id: const Uuid().v1(),
            )),
            initialDeactivated: state.deactivated,
            status: EntityStatus.success,
            message: response.message,
          ));

          formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
        } else {
          emit(state.copyWith(
            status: EntityStatus.initial,
            observationTypeNameValidationMessage: response.message,
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

  Future<void> _onAddEditObservationTypeEdited(
    AddEditObservationTypeEdited event,
    Emitter<AddEditObservationTypeState> emit,
  ) async {
    if (_validate(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));
      try {
        EntityResponse response = await observationTypesRepository
            .editObservationType(state.observationType.copyWith(id: event.id));
        if (response.isSuccess) {
          emit(state.copyWith(
            initialObservationTypeName: state.observationTypeName,
            initialObservationTypeSeverity:
                Nullable.value(state.observationTypeSeverity),
            initialObservationTypeVisibility:
                Nullable.value(state.observationTypeVisibility),
            initialDeactivated: state.deactivated,
            status: EntityStatus.success,
            message: response.message,
          ));

          formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
        } else {
          emit(state.copyWith(
            status: EntityStatus.initial,
            observationTypeNameValidationMessage: response.message,
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

  Future<void> _onAddEditObservationTypeLoaded(
    AddEditObservationTypeLoaded event,
    Emitter<AddEditObservationTypeState> emit,
  ) async {
    try {
      ObservationType observationType = await observationTypesRepository
          .getObservationTypeById(event.observationTypeId);
      emit(state.copyWith(
        loadedObservationType: Nullable.value(observationType),
        observationTypeName: observationType.name,
        observationTypeSeverity: Nullable.value(observationType.severity),
        observationTypeVisibility: Nullable.value(observationType.visibility),
        deactivated: !observationType.active,
        initialObservationTypeName: observationType.name,
        initialObservationTypeSeverity:
            Nullable.value(observationType.severity),
        initialObservationTypeVisibility:
            Nullable.value(observationType.visibility),
        initialDeactivated: !observationType.active,
      ));
    } catch (e) {}
  }

  void _onAddEditObservationTypeNameChanged(
    AddEditObservationTypeNameChanged event,
    Emitter<AddEditObservationTypeState> emit,
  ) {
    emit(state.copyWith(
      observationTypeName: event.observationTypeName,
      observationTypeNameValidationMessage: '',
    ));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditObservationTypeSeverityChanged(
    AddEditObservationTypeSeverityChanged event,
    Emitter<AddEditObservationTypeState> emit,
  ) {
    emit(state.copyWith(
      observationTypeSeverity: Nullable.value(event.observationTypeSeverity),
      observationTypeSeverityValidationMessage: '',
    ));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditObservationTypeVisibilityChanged(
    AddEditObservationTypeVisibilityChanged event,
    Emitter<AddEditObservationTypeState> emit,
  ) {
    emit(state.copyWith(
        observationTypeVisibility:
            Nullable.value(event.observationTypeVisibility)));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditObservationTypeDeactivatedChanged(
    AddEditObservationTypeDeactivatedChanged event,
    Emitter<AddEditObservationTypeState> emit,
  ) {
    emit(state.copyWith(deactivated: event.deactivated));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  bool _validate(Emitter<AddEditObservationTypeState> emit) {
    bool success = true;

    if (Validation.isEmpty(state.observationTypeName)) {
      emit(state.copyWith(
          observationTypeNameValidationMessage:
              FormValidationMessage(fieldName: 'Observation type name')
                  .requiredMessage));

      success = false;
    } else if (Validation.isNotEmpty(state.observationTypeName) &&
        !Validation.isAlphanumbericWithSpecialChars(
            state.observationTypeName)) {
      emit(state.copyWith(
          observationTypeNameValidationMessage:
              FormValidationMessage(fieldName: 'Observation type name')
                  .alphanumbericWithAllowSpecialCharMessage));

      success = false;
    } else if (state.observationTypeName.length >
        ObservationTypeFormValidation.observationTypeNameMaxLength) {
      emit(state.copyWith(
          observationTypeNameValidationMessage: FormValidationMessage(
        fieldName: 'Observation type',
        maxLength: ObservationTypeFormValidation.observationTypeNameMaxLength,
      ).maxLengthValidationMessage));

      success = false;
    }

    if (Validation.isEmpty(state.observationTypeSeverity)) {
      emit(state.copyWith(
          observationTypeSeverityValidationMessage:
              FormValidationMessage(fieldName: 'Severity').requiredMessage));

      success = false;
    }

    return success;
  }
}
