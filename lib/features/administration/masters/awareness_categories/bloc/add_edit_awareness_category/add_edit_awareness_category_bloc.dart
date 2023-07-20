import 'package:uuid/uuid.dart';

import '/common_libraries.dart';

part 'add_edit_awareness_category_event.dart';
part 'add_edit_awareness_category_state.dart';

class AddEditAwarenessCategoryBloc
    extends Bloc<AddEditAwarenessCategoryEvent, AddEditAwarenessCategoryState> {
  final AwarenessCategoriesRepository awarenessCategoriesRepository;
  final AwarenessGroupsRepository awarenessGroupsRepository;
  final FormDirtyBloc formDirtyBloc;

  final String addErrorMessage = ErrorMessage('awareness category').add;
  final String editErrorMessage = ErrorMessage('awareness category').edit;

  AddEditAwarenessCategoryBloc({
    required this.formDirtyBloc,
    required this.awarenessCategoriesRepository,
    required this.awarenessGroupsRepository,
  }) : super(const AddEditAwarenessCategoryState()) {
    on<AddEditAwarenessCategoryLoaded>(_onAddEditAwarenessCategoryLoaded);
    on<AddEditAwarenessCategoryGroupListLoaded>(
        _onAddEditAwarenessCategoryGroupListLoaded);
    on<AddEditAwarenessCategoryAdded>(_onAddEditAwarenessCategoryAdded);
    on<AddEditAwarenessCategoryEdited>(_onAddEditAwarenessCategoryEdited);
    on<AddEditAwarenessCategoryNameChanged>(
        _onAddEditAwarenessCategoryNameChanged);
    on<AddEditAwarenessCategoryGroupChanged>(
        _onAddEditAwarenessCategoryGroupChanged);
    on<AddEditAwarenessCategoryDeactivatedChanged>(
        _onAddEditAwarenessCategoryDeactivatedChanged);
  }

  Future<void> _onAddEditAwarenessCategoryLoaded(
    AddEditAwarenessCategoryLoaded event,
    Emitter<AddEditAwarenessCategoryState> emit,
  ) async {
    try {
      AwarenessCategory awarenessCategory = await awarenessCategoriesRepository
          .getAwarenessCategoryById(event.id);

      emit(state.copyWith(
        loadedAwarenessCategory: Nullable.value(awarenessCategory),
        initialName: awarenessCategory.name,
        initialDeactivated: !awarenessCategory.active,
        initialAwarenessGroup: Nullable.value(AwarenessGroup(
          id: awarenessCategory.groupId,
          name: awarenessCategory.groupName,
        )),
        name: awarenessCategory.name,
        deactivated: !awarenessCategory.active,
        awarenessGroup: Nullable.value(AwarenessGroup(
          id: awarenessCategory.groupId,
          name: awarenessCategory.groupName,
        )),
      ));
    } catch (e) {}
  }

  Future<void> _onAddEditAwarenessCategoryGroupListLoaded(
    AddEditAwarenessCategoryGroupListLoaded event,
    Emitter<AddEditAwarenessCategoryState> emit,
  ) async {
    try {
      List<AwarenessGroup> awarenessGroupList =
          await awarenessGroupsRepository.getAwarenessGroups();

      emit(state.copyWith(awarenessGroupList: awarenessGroupList));
    } catch (e) {}
  }

  Future<void> _onAddEditAwarenessCategoryAdded(
    AddEditAwarenessCategoryAdded event,
    Emitter<AddEditAwarenessCategoryState> emit,
  ) async {
    if (_validate(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));
      try {
        EntityResponse response = await awarenessCategoriesRepository
            .addAwarenessCategory(state.awarenessCategory);

        if (response.isSuccess) {
          emit(state.copyWith(
            initialName: '',
            name: '',
            loadedAwarenessCategory:
                Nullable.value(AwarenessCategory(id: const Uuid().v1())),
            initialDeactivated: false,
            initialAwarenessGroup: Nullable.value(state.awarenessGroup),
            awarenessGroup: const Nullable.value(null),
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

  Future<void> _onAddEditAwarenessCategoryEdited(
    AddEditAwarenessCategoryEdited event,
    Emitter<AddEditAwarenessCategoryState> emit,
  ) async {
    if (_validate(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));
      try {
        EntityResponse response =
            await awarenessCategoriesRepository.editAwarenessCategory(
                state.awarenessCategory.copyWith(id: event.id));
        if (response.isSuccess) {
          emit(state.copyWith(
            initialName: state.name,
            initialDeactivated: state.deactivated,
            initialAwarenessGroup: Nullable.value(state.awarenessGroup),
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
          message: editErrorMessage,
        ));
      }
    }
  }

  void _onAddEditAwarenessCategoryNameChanged(
    AddEditAwarenessCategoryNameChanged event,
    Emitter<AddEditAwarenessCategoryState> emit,
  ) {
    emit(state.copyWith(
      name: event.name,
      nameValidationMessage: '',
    ));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditAwarenessCategoryGroupChanged(
    AddEditAwarenessCategoryGroupChanged event,
    Emitter<AddEditAwarenessCategoryState> emit,
  ) {
    emit(state.copyWith(
      awarenessGroup: Nullable.value(event.awarenessGroup),
      awarenessGroupValidationMessage: '',
    ));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditAwarenessCategoryDeactivatedChanged(
    AddEditAwarenessCategoryDeactivatedChanged event,
    Emitter<AddEditAwarenessCategoryState> emit,
  ) {
    emit(state.copyWith(deactivated: event.deactivated));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  /// validate form
  bool _validate(Emitter<AddEditAwarenessCategoryState> emit) {
    bool success = true;

    if (Validation.isEmpty(state.name)) {
      emit(state.copyWith(
          nameValidationMessage:
              FormValidationMessage(fieldName: 'Awareness category')
                  .requiredMessage));

      success = false;
    } else if (Validation.isNotEmpty(state.name) &&
        !Validation.isAlphanumbericWithSpecialChars(state.name)) {
      emit(state.copyWith(
          nameValidationMessage:
              FormValidationMessage(fieldName: 'Awareness category')
                  .alphanumbericWithAllowSpecialCharMessage));

      success = false;
    } else if (state.name.length >
        AwarenessCategoryFormValidation.awarenessCategoryMaxLength) {
      emit(state.copyWith(
          nameValidationMessage: FormValidationMessage(
                  fieldName: 'Awareness category',
                  maxLength: AwarenessCategoryFormValidation
                      .awarenessCategoryMaxLength)
              .maxLengthValidationMessage));

      success = false;
    }

    if (state.awarenessGroup == null) {
      emit(state.copyWith(
          awarenessGroupValidationMessage:
              FormValidationMessage(fieldName: 'Awareness group')
                  .requiredMessage));

      success = false;
    }

    return success;
  }
}
