import 'package:safety_eta/features/administration/audits/audits/data/repository/audits_repository.dart';

import '/common_libraries.dart';

part 'add_edit_audit_event.dart';
part 'add_edit_audit_state.dart';

class AddEditAuditBloc extends Bloc<AddEditAuditEvent, AddEditAuditState> {
  late FormDirtyBloc formDirtyBloc;
  late AuditsRepository auditsRepository;
  late AuditsRepository sitesRepository;
  late TemplatesRepository templatesRepository;
  late ProjectsRepository projectsRepository;
  final BuildContext context;
  AddEditAuditBloc(this.context) : super(const AddEditAuditState()) {
    formDirtyBloc = context.read();
    auditsRepository = RepositoryProvider.of(context);
    sitesRepository = RepositoryProvider.of(context);
    templatesRepository = RepositoryProvider.of(context);
    projectsRepository = RepositoryProvider.of(context);

    _bindEvents();
  }

  void _bindEvents() {
    on<AddEditAuditAdded>(_onAddEditAuditAdded);
    on<AddEditAuditEdited>(_onAddEditAuditEdited);
    on<AddEditAuditLoaded>(_onAddEditAuditLoaded);
  }

  Future<void> _onAddEditAuditAdded(
    AddEditAuditAdded event,
    Emitter<AddEditAuditState> emit,
  ) async {
    if (_checkValidation(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));

      try {
        EntityResponse response = await auditsRepository.addAudit(state.audit);

        if (response.isSuccess) {
          emit(state.copyWith(
            createdAuditId: response.data?.id,
            message: response.message,
            status: EntityStatus.success,
          ));
        } else {}
      } catch (e) {
        emit(state.copyWith(
          status: EntityStatus.failure,
          // message: addErrorMessage,
        ));
      }
    }
  }

  Future<void> _onAddEditAuditEdited(
    AddEditAuditEdited event,
    Emitter<AddEditAuditState> emit,
  ) async {
    if (_checkValidation(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));

      try {
        EntityResponse response = await auditsRepository
            .editAudit(state.audit.copyWith(id: event.id));

        if (response.isSuccess) {
          emit(state.copyWith(
            initialAuditName: state.auditName,
            message: response.message,
            status: EntityStatus.success,
          ));

          formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
        } else {
          // _checkMessage(emit, response.message);
        }
      } catch (e) {
        // emit(state.copyWith(
        //   status: EntityStatus.failure,
        //   message: editErrorMessage,
        // ));
      }
    }
  }

  Future<void> _onAddEditAuditLoaded(
    AddEditAuditLoaded event,
    Emitter<AddEditAuditState> emit,
  ) async {
    try {
      Audit audit = await auditsRepository.getAuditById(event.id);

      emit(state.copyWith(
        loadedAudit: audit,
        initialAuditName: audit.name,
        auditName: audit.name,
        auditDate: DateTime.parse(audit.auditDate),
        initialAuditDate: DateTime.parse(audit.auditDate),
      ));
    } catch (e) {}
  }

  bool _checkValidation(Emitter<AddEditAuditState> emit) {
    bool success = true;

    if (Validation.isEmpty(state.auditName)) {
      emit(state.copyWith(
          auditNameValidationMessage:
              FormValidationMessage(fieldName: 'Audit name').requiredMessage));
      success = false;
    }

    if (state.auditDate == null) {
      emit(state.copyWith(
          auditDateValidationMessage:
              FormValidationMessage(fieldName: 'Audit date').requiredMessage));
      success = false;
    }

    if (state.site == null) {
      emit(state.copyWith(
          siteValidationMessage:
              FormValidationMessage(fieldName: 'Site').requiredMessage));
      success = false;
    }

    if (state.template == null) {
      emit(state.copyWith(
          templateValidationMessage:
              FormValidationMessage(fieldName: 'Template').requiredMessage));
      success = false;
    }

    if (state.auditTime == null) {
      emit(state.copyWith(
          templateValidationMessage:
              FormValidationMessage(fieldName: 'Audit time').requiredMessage));
      success = false;
    }

    return success;
  }
}
