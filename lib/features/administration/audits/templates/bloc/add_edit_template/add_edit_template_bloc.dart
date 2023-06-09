import 'package:equatable/equatable.dart';
import '/common_libraries.dart';

part 'add_edit_template_event.dart';
part 'add_edit_template_state.dart';

class AddEditTemplateBloc
    extends Bloc<AddEditTemplateEvent, AddEditTemplateState> {
  final TemplatesRepository templatesRepository;

  static String templateAddErrorMessage =
      'There was a problem in creating the template. We have made a note of this. Please try again after a few minutes....';

  AddEditTemplateBloc({required this.templatesRepository})
      : super(const AddEditTemplateState()) {
    on<AddEditTemplateDescriptionChanged>(_onAddEditTemplateDescriptionChanged);
    on<AddEditTemplateDateChanged>(_onAddEditTemplateDateChanged);
    on<AddEditTemplateUsedInInspection>(_onAddEditTemplateUsedInInspection);
    on<AddEditTemplateUsedInAudit>(_onAddEditTemplateUsedInAudit);
    on<AddEditTemplateTemplateAddEdited>(_onAddEditTemplateTemplateAddEdited);
  }

  void _onAddEditTemplateDescriptionChanged(
    AddEditTemplateDescriptionChanged event,
    Emitter<AddEditTemplateState> emit,
  ) {
    emit(state.copyWith(
      templateDescription: event.description,
      templateDescriptionValidationMessage: '',
    ));
  }

  void _onAddEditTemplateDateChanged(
    AddEditTemplateDateChanged event,
    Emitter<AddEditTemplateState> emit,
  ) {
    emit(state.copyWith(
      date: event.date,
      dateValidationMesage: '',
    ));
  }

  void _onAddEditTemplateUsedInInspection(
    AddEditTemplateUsedInInspection event,
    Emitter<AddEditTemplateState> emit,
  ) {
    emit(state.copyWith(usedInInspection: event.usedInInspection));
  }

  void _onAddEditTemplateUsedInAudit(
    AddEditTemplateUsedInAudit event,
    Emitter<AddEditTemplateState> emit,
  ) {
    emit(state.copyWith(usedInAudit: event.usedInAudit));
  }

  Future<void> _onAddEditTemplateTemplateAddEdited(
    AddEditTemplateTemplateAddEdited event,
    Emitter<AddEditTemplateState> emit,
  ) async {
    bool success = true;
    if (Validation.isEmpty(state.templateDescription)) {
      emit(state.copyWith(
          templateDescriptionValidationMessage:
              'Description is required and cannot be blank.'));
      success = false;
    }

    if (Validation.isEmpty(state.date?.toIso8601String())) {
      emit(state.copyWith(dateValidationMesage: 'Date is required.'));
      success = false;
    }

    if (success) {
      emit(state.copyWith(templateAddEditStatus: EntityStatus.loading));

      try {
        final template = Template(
          name: state.templateDescription,
          revisionDate: state.date!.toIso8601String(),
        );
        EntityResponse response = event.templateId == null
            ? await templatesRepository.addTemplate(template)
            : await templatesRepository
                .editTemplate(template.copyWith(id: event.templateId!));

        if (response.isSuccess) {
          emit(state.copyWith(
            templateAddEditStatus: EntityStatus.success,
            createdTemplateId: response.data?.id,
            message: response.message,
          ));
          return;
        }

        if (response.statusCode == 409) {
          emit(state.copyWith(
            templateDescriptionValidationMessage: response.message,
            templateAddEditStatus: response.isSuccess.toEntityStatusCode(),
          ));
        } else {
          emit(state.copyWith(
            templateAddEditStatus: response.isSuccess.toEntityStatusCode(),
            message: response.message,
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          templateAddEditStatus: EntityStatus.failure,
          message: templateAddErrorMessage,
        ));
      }
    }
  }
}
