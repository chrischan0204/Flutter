import 'package:equatable/equatable.dart';
import '/common_libraries.dart';

part 'add_edit_template_event.dart';
part 'add_edit_template_state.dart';

class AddEditTemplateBloc
    extends Bloc<AddEditTemplateEvent, AddEditTemplateState> {
  final TemplatesRepository templatesRepository;
  AddEditTemplateBloc({required this.templatesRepository})
      : super(const AddEditTemplateState()) {
    on<AddEditTemplateDescriptionChanged>(_onAddEditTemplateDescriptionChanged);
    on<AddEditTemplateDateChanged>(_onAddEditTemplateDateChanged);
    on<AddEditTemplateUsedInInspection>(_onAddEditTemplateUsedInInspection);
    on<AddEditTemplateUsedInAudit>(_onAddEditTemplateUsedInAudit);
    on<AddEditTemplateTemplateAdded>(_onAddEditTemplateTemplateAdded);
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

  Future<void> _onAddEditTemplateTemplateAdded(
    AddEditTemplateTemplateAdded event,
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
      emit(state.copyWith(templateAddStatus: EntityStatus.loading));

      try {
        EntityResponse response =
            await templatesRepository.addTemplate(Template(
          name: state.templateDescription,
          usedInAudit: state.usedInAudit,
          usedInInspection: state.usedInInspection,
          revisionDate: state.date!.toIso8601String(),
        ));

        if (response.statusCode == 409) {
          emit(state.copyWith(
            templateDescriptionValidationMessage: response.message,
            templateAddStatus: response.isSuccess.toEntityStatusCode(),
          ));
        } else {
          emit(state.copyWith(
            templateAddStatus: response.isSuccess.toEntityStatusCode(),
            message: response.message,
          ));
        }
      } catch (e) {
        emit(state.copyWith(templateAddStatus: EntityStatus.failure));
      }
    }
  }
}
