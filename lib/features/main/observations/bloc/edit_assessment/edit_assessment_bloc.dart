import 'dart:async';

import '/common_libraries.dart';

part 'edit_assessment_event.dart';
part 'edit_assessment_state.dart';

class EditAssessmentBloc
    extends Bloc<EditAssessmentEvent, EditAssessmentState> {
  final BuildContext context;
  final String observationId;
  late ObservationsRepository _observationsRepository;
  late ObservationDetailBloc _observationDetailBloc;
  late StreamSubscription subscription;
  EditAssessmentBloc(
    this.context,
    this.observationId,
  ) : super(const EditAssessmentState()) {
    _observationsRepository = context.read();
    _observationDetailBloc = context.read();

    _bindEvents();
  }

  void _bindEvents() {
    on<EditAssessmentCategoryChanged>(_onEditAssessmentCategoryChanged);
    on<EditAssessmentObservationTypeChanged>(
        _onEditAssessmentObservationTypeChanged);
    on<EditAssessmentPriorityLevelChanged>(
        _onEditAssessmentPriorityLevelChanged);
    on<EditAssessmentProjectChanged>(_onEditAssessmentProjectChanged);
    on<EditAssessmentCompanyChanged>(_onEditAssessmentCompanyChanged);
    on<EditAssessmentSiteChanged>(_onEditAssessmentSiteChanged);
    on<EditAssessmentObserverChanged>(_onEditAssessmentObserverChanged);
    on<EditAssessmentReportedViaChanged>(_onEditAssessmentReportedViaChanged);
    on<EditAssessmentFollowUpCloseoutChanged>(
        _onEditAssessmentFollowUpCloseoutChanged);
    on<EditAssessmentMarkAsClosedChanged>(_onEditAssessmentMarkAsClosedChanged);
    on<EditAssessmentNotifySenderChanged>(_onEditAssessmentNotifySenderChanged);
    on<EditAssessmentIsEditingChanged>(_onEditAssessmentIsEditingChanged);
    on<EditAssessmentAdded>(_onEditAssessmentAdded);
  }

  Future<void> _onEditAssessmentAdded(
    EditAssessmentAdded event,
    Emitter<EditAssessmentState> emit,
  ) async {
    if (_validate(emit)) {
      try {
        emit(state.copyWith(status: EntityStatus.loading));

        EntityResponse response = await _observationsRepository.addAssessment(
            observationId,
            AssessmentCreate(
              notificationSent: state.notifySender,
              isClosed: state.markAsClosed,
              assessmentAwarenessCategoryId: state.category!.id!,
              assessmentObservationTypeId: state.observationType!.id!,
              assessmentPriorityLevelId: state.priorityLevel!.id!,
              assessmentFollowupComment: state.followUpCloseout,
              assessmentCompanyId: state.company!.id!,
              assessmentProjectId: state.project!.id!,
              assessmentSiteId: state.site!.id!,
            ));
        if (response.isSuccess) {
          emit(state.copyWith(
            status: EntityStatus.success,
            message: response.message,
          ));

          add(EditAssessmentIsEditingChanged());
          _observationDetailBloc
              .add(ObservationDetailLoaded(observationId: observationId));
        }
      } catch (e) {
        emit(state.copyWith(status: EntityStatus.loading));
      }
    }
  }

  bool _validate(Emitter<EditAssessmentState> emit) {
    bool valid = true;

    if (state.category == null) {
      emit(state.copyWith(
          awarenessCategoryValidationMessage:
              FormValidationMessage(fieldName: 'Category').requiredMessage));

      valid = false;
    }

    if (state.observationType == null) {
      emit(state.copyWith(
          observationTypeValidationMessage:
              FormValidationMessage(fieldName: 'Observation type')
                  .requiredMessage));

      valid = false;
    }

    if (state.priorityLevel == null) {
      emit(state.copyWith(
          priorityLevelValidationMessage:
              FormValidationMessage(fieldName: 'Priority level')
                  .requiredMessage));

      valid = false;
    }

    if (state.site == null) {
      emit(state.copyWith(
          siteValidationMessage:
              FormValidationMessage(fieldName: 'Site').requiredMessage));

      valid = false;
    }

    if (state.project == null) {
      emit(state.copyWith(
          projectValidationMessage:
              FormValidationMessage(fieldName: 'Project').requiredMessage));

      valid = false;
    }

    if (state.company == null) {
      emit(state.copyWith(
          companyValidationMessage:
              FormValidationMessage(fieldName: 'Company').requiredMessage));

      valid = false;
    }

    return valid;
  }

  void _onEditAssessmentCategoryChanged(
    EditAssessmentCategoryChanged event,
    Emitter<EditAssessmentState> emit,
  ) {
    emit(state.copyWith(
      category: event.category,
      awarenessCategoryValidationMessage: '',
    ));
  }

  void _onEditAssessmentObservationTypeChanged(
    EditAssessmentObservationTypeChanged event,
    Emitter<EditAssessmentState> emit,
  ) {
    emit(state.copyWith(
      observationType: event.observationType,
      observationTypeValidationMessage: '',
    ));
  }

  void _onEditAssessmentPriorityLevelChanged(
    EditAssessmentPriorityLevelChanged event,
    Emitter<EditAssessmentState> emit,
  ) {
    emit(state.copyWith(
      priorityLevel: event.priorityLevel,
      priorityLevelValidationMessage: '',
    ));
  }

  void _onEditAssessmentProjectChanged(
    EditAssessmentProjectChanged event,
    Emitter<EditAssessmentState> emit,
  ) {
    emit(state.copyWith(
      project: Nullable.value(event.project),
      projectValidationMessage: '',
    ));
  }

  void _onEditAssessmentCompanyChanged(
    EditAssessmentCompanyChanged event,
    Emitter<EditAssessmentState> emit,
  ) {
    emit(state.copyWith(
      company: Nullable.value(event.company),
      companyValidationMessage: '',
    ));
  }

  void _onEditAssessmentSiteChanged(
    EditAssessmentSiteChanged event,
    Emitter<EditAssessmentState> emit,
  ) {
    emit(state.copyWith(
      site: event.site,
      siteValidationMessage: '',
    ));

    if (!event.isFirst) {
      emit(state.copyWith(
        project: const Nullable.value(null),
        company: const Nullable.value(null),
      ));
    }

    if (event.site.id != null) {
      _observationDetailBloc
          .add(ObservationDetailProjectListLoaded(siteId: event.site.id!));

      _observationDetailBloc
          .add(ObservationDetailCompanyListLoaded(siteId: event.site.id!));
    }
  }

  void _onEditAssessmentObserverChanged(
    EditAssessmentObserverChanged event,
    Emitter<EditAssessmentState> emit,
  ) {
    emit(state.copyWith(observer: event.observer));
  }

  void _onEditAssessmentReportedViaChanged(
    EditAssessmentReportedViaChanged event,
    Emitter<EditAssessmentState> emit,
  ) {
    emit(state.copyWith(reportedVia: event.reportedVia));
  }

  void _onEditAssessmentFollowUpCloseoutChanged(
    EditAssessmentFollowUpCloseoutChanged event,
    Emitter<EditAssessmentState> emit,
  ) {
    emit(state.copyWith(followUpCloseout: event.followUpCloseout));
  }

  void _onEditAssessmentMarkAsClosedChanged(
    EditAssessmentMarkAsClosedChanged event,
    Emitter<EditAssessmentState> emit,
  ) {
    emit(state.copyWith(markAsClosed: event.markAsClosed));
  }

  void _onEditAssessmentNotifySenderChanged(
    EditAssessmentNotifySenderChanged event,
    Emitter<EditAssessmentState> emit,
  ) {
    emit(state.copyWith(notifySender: event.notifySender));
  }

  void _onEditAssessmentIsEditingChanged(
    EditAssessmentIsEditingChanged event,
    Emitter<EditAssessmentState> emit,
  ) {
    emit(state.copyWith(isEditing: !state.isEditing));
  }
}
