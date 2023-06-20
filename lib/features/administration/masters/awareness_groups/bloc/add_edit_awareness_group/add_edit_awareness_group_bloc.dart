import '/common_libraries.dart';

part 'add_edit_awareness_group_event.dart';
part 'add_edit_awareness_group_state.dart';

class AddEditAwarenessGroupBloc
    extends Bloc<AddEditAwarenessGroupEvent, AddEditAwarenessGroupState> {
  final AwarenessGroupsRepository awarenessGroupsRepository;
  final FormDirtyBloc formDirtyBloc;

  static String addErrorMessage =
      'There was an error while adding awareness group. Our team has been notified. Please wait a few minutes and try again.';
  static String editErrorMessage =
      'There was an error while editing awareness group. Our team has been notified. Please wait a few minutes and try again.';

  AddEditAwarenessGroupBloc({
    required this.awarenessGroupsRepository,
    required this.formDirtyBloc,
  }) : super(const AddEditAwarenessGroupState()) {
    on<AddEditAwarenessGroupLoaded>(_onAddEditAwarenessGroupLoaded);
    on<AddEditAwarenessGroupAdded>(_onAddEditAwarenessGroupAdded);
    on<AddEditAwarenessGroupEdited>(_onAddEditAwarenessGroupEdited);
    on<AddEditAwarenessGroupNameChanged>(_onAddEditAwarenessGroupNameChanged);
  }

  Future<void> _onAddEditAwarenessGroupLoaded(
    AddEditAwarenessGroupLoaded event,
    Emitter<AddEditAwarenessGroupState> emit,
  ) async {
    try {
      AwarenessGroup awarenessGroup =
          await awarenessGroupsRepository.getAwarenessGroupById(event.id);

      emit(state.copyWith(
        loadedAwarenessGroup: awarenessGroup,
        name: awarenessGroup.name,
        initialName: awarenessGroup.name,
      ));
    } catch (e) {}
  }

  Future<void> _onAddEditAwarenessGroupAdded(
    AddEditAwarenessGroupAdded event,
    Emitter<AddEditAwarenessGroupState> emit,
  ) async {
    if (_validate(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));
      try {
        EntityResponse response = await awarenessGroupsRepository
            .addAwarenessGroup(state.awarenessGroup);
        if (response.isSuccess) {
          emit(state.copyWith(
            initialName: state.name,
            status: EntityStatus.success,
            message: response.message,
          ));

          formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
        } else {
          emit(state.copyWith(
            status: EntityStatus.initial,
            nameValidationMessage: response.message,
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

  Future<void> _onAddEditAwarenessGroupEdited(
    AddEditAwarenessGroupEdited event,
    Emitter<AddEditAwarenessGroupState> emit,
  ) async {
    if (_validate(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));
      try {
        EntityResponse response = await awarenessGroupsRepository
            .editAwarenessGroup(state.awarenessGroup.copyWith(id: event.id));
        if (response.isSuccess) {
          emit(state.copyWith(
            initialName: state.name,
            status: EntityStatus.success,
            message: response.message,
          ));

          formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
        } else {
          emit(state.copyWith(
            status: EntityStatus.initial,
            nameValidationMessage: response.message,
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

  void _onAddEditAwarenessGroupNameChanged(
    AddEditAwarenessGroupNameChanged event,
    Emitter<AddEditAwarenessGroupState> emit,
  ) {
    emit(state.copyWith(
      name: event.name,
      nameValidationMessage: '',
    ));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  bool _validate(Emitter<AddEditAwarenessGroupState> emit) {
    bool success = true;

    if (Validation.isEmpty(state.name)) {
      emit(state.copyWith(
          nameValidationMessage:
              FormValidationMessage(fieldName: 'Awareness group')
                  .requiredMessage));

      success = false;
    } else if (Validation.isNotEmpty(state.name) &&
        !Validation.isAlphanumbericWithSpecialChars(state.name)) {
      emit(state.copyWith(
          nameValidationMessage:
              FormValidationMessage(fieldName: 'Awareness group')
                  .alphanumbericWithAllowSpecialCharMessage));

      success = false;
    } else if (state.name.length >
        AwarenessGroupFormValidation.awarenessGroupNameMaxLength) {
      emit(state.copyWith(
          nameValidationMessage: FormValidationMessage(
                  fieldName: 'Awareness group',
                  maxLength:
                      AwarenessGroupFormValidation.awarenessGroupNameMaxLength)
              .maxLengthValidationMessage));

      success = false;
    }

    return success;
  }
}
