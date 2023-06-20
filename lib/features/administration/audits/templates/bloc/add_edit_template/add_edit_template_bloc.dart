import '/common_libraries.dart';

part 'add_edit_template_event.dart';
part 'add_edit_template_state.dart';

class AddEditTemplateBloc
    extends Bloc<AddEditTemplateEvent, AddEditTemplateState> {
  final TemplatesRepository templatesRepository;
  final FormDirtyBloc formDirtyBloc;

  static String templateAddErrorMessage =
      'There was a problem in creating the template. We have made a note of this. Please try again after a few minutes....';

  static String templateEditErrorMessage =
      'There was a problem in editing the template. We have made a note of this. Please try again after a few minutes....';

  AddEditTemplateBloc({
    required this.templatesRepository,
    required this.formDirtyBloc,
  }) : super(const AddEditTemplateState()) {
    on<AddEditTemplateDescriptionChanged>(_onAddEditTemplateDescriptionChanged);
    on<AddEditTemplateDateChanged>(_onAddEditTemplateDateChanged);
    on<AddEditTemplateTemplateAddEdited>(_onAddEditTemplateTemplateAddEdited);
    on<AddEditTemplateLoaded>(_onAddEditTemplateLoaded);
  }

  void _onAddEditTemplateDescriptionChanged(
    AddEditTemplateDescriptionChanged event,
    Emitter<AddEditTemplateState> emit,
  ) {
    emit(state.copyWith(
      templateDescription: event.description,
      templateDescriptionValidationMessage: '',
    ));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditTemplateDateChanged(
    AddEditTemplateDateChanged event,
    Emitter<AddEditTemplateState> emit,
  ) {
    emit(state.copyWith(
      date: event.date,
      dateValidationMesage: '',
    ));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  Future<void> _onAddEditTemplateTemplateAddEdited(
    AddEditTemplateTemplateAddEdited event,
    Emitter<AddEditTemplateState> emit,
  ) async {
    if (_validate(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));

      try {
        EntityResponse response = event.templateId == null
            ? await templatesRepository.addTemplate(state.template)
            : await templatesRepository
                .editTemplate(state.template.copyWith(id: event.templateId!));

        if (response.isSuccess) {
          emit(state.copyWith(
            status: EntityStatus.success,
            initialDate: state.date,
            initialTemplateDescription: state.templateDescription,
            createdTemplateId: response.data?.id,
            message: response.message,
          ));

          formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
        } else {
          if (response.statusCode == 409) {
            emit(state.copyWith(
              templateDescriptionValidationMessage: response.message,
              status: response.isSuccess.toEntityStatusCode(),
            ));
          } else {
            emit(state.copyWith(
              status: response.isSuccess.toEntityStatusCode(),
              message: response.message,
            ));
          }
        }
      } catch (e) {
        emit(state.copyWith(
          status: EntityStatus.failure,
          message: event.templateId == null
              ? templateAddErrorMessage
              : templateEditErrorMessage,
        ));
      }
    }
  }

  Future<void> _onAddEditTemplateLoaded(
    AddEditTemplateLoaded event,
    Emitter<AddEditTemplateState> emit,
  ) async {
    try {
      Template template =
          await templatesRepository.getTemplateById(event.templateId);

      emit(state.copyWith(
        loadedTemplate: template,
        initialDate: DateTime.parse(template.revisionDate),
        initialTemplateDescription: template.name,
        date: DateTime.parse(template.revisionDate),
        templateDescription: template.name,
      ));
    } catch (e) {}
  }

  bool _validate(Emitter<AddEditTemplateState> emit) {
    bool success = true;
    if (Validation.isEmpty(state.templateDescription)) {
      emit(state.copyWith(
          templateDescriptionValidationMessage:
              FormValidationMessage(fieldName: 'Description').requiredMessage));
      success = false;
    }

    if (Validation.isEmpty(state.date?.toIso8601String())) {
      emit(state.copyWith(
          dateValidationMesage:
              FormValidationMessage(fieldName: 'Date').requiredMessage));
      success = false;
    }

    return success;
  }
}
