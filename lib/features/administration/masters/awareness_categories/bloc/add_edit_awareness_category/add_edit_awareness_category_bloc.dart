import '/common_libraries.dart';

part 'add_edit_awareness_category_event.dart';
part 'add_edit_awareness_category_state.dart';

class AddEditAwarenessCategoryBloc
    extends Bloc<AddEditAwarenessCategoryEvent, AddEditAwarenessCategoryState> {
  final AwarenessCategoriesRepository awarenessCategoriesRepository;
  final AwarenessGroupsRepository awarenessGroupsRepository;
  final FormDirtyBloc formDirtyBloc;

  final String addErrorMessage =
      'There was an error while adding awareness category. Our team has been notified. Please wait a few minutes and try again.';
  final String editErrorMessage =
      'There was an error while editing awareness category. Our team has been notified. Please wait a few minutes and try again.';
  final String deleteErrorMessage =
      'There was an error while deleting awareness category. Our team has been notified. Please wait a few minutes and try again.';

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
        loadedAwarenessCategory: awarenessCategory,
        initialName: awarenessCategory.name,
        initialDeactivated: !awarenessCategory.active,
        initialAwarenessGroup: AwarenessGroup(
          id: awarenessCategory.groupId,
          name: awarenessCategory.groupName,
        ),
        name: awarenessCategory.name,
        deactivated: !awarenessCategory.active,
        awarenessGroup: AwarenessGroup(
          id: awarenessCategory.groupId,
          name: awarenessCategory.groupName,
        ),
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
            initialName: state.name,
            initialDeactivated: state.deactivated,
            initialAwarenessGroup: state.awarenessGroup,
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
            initialAwarenessGroup: state.awarenessGroup,
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
      awarenessGroup: event.awarenessGroup,
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
          nameValidationMessage: 'Awareness category is required.'));

      success = false;
    } else if (Validation.isNotEmpty(state.name) &&
        !Validation.isAlphanumbericWithSpecialChars(state.name)) {
      emit(state.copyWith(
          nameValidationMessage:
              'Awareness category should be alphanumeric with allow special char.'));

      success = false;
    } else if (state.name.length >
        AwarenessCategoryFormValidation.awarenessCategoryMaxLength) {
      emit(state.copyWith(
          nameValidationMessage: Validation.maxLengthValidationMessage(
              'Awareness category',
              AwarenessCategoryFormValidation.awarenessCategoryMaxLength)));

      success = false;
    }

    if (state.awarenessGroup == null) {
      emit(state.copyWith(
          awarenessGroupValidationMessage: 'Awareness group is required.'));

      success = false;
    }

    return success;
  }
}
