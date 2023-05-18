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
    emit(state.copyWith(templateDescription: event.description));
  }

  void _onAddEditTemplateDateChanged(
    AddEditTemplateDateChanged event,
    Emitter<AddEditTemplateState> emit,
  ) {
    emit(state.copyWith(date: event.date));
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
    emit(state.copyWith(templateAddStatus: EntityStatus.loading));
    try {
      EntityResponse response = await templatesRepository.addTemplate(Template(
        name: state.templateDescription,
        usedInAudit: state.usedInAudit,
        usedInInspection: state.usedInInspection,
        revisionDate: state.date,
      ));

      emit(state.copyWith(
        templateAddStatus: response.isSuccess.toEntityStatusCode(),
        message: response.message,
      ));
    } catch (e) {
      emit(state.copyWith(templateAddStatus: EntityStatus.failure));
    }
  }
}
