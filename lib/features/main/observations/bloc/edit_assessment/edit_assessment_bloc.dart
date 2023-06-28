import '/common_libraries.dart';

part 'edit_assessment_event.dart';
part 'edit_assessment_state.dart';

class EditAssessmentBloc
    extends Bloc<EditAssessmentEvent, EditAssessmentState> {
  final BuildContext context;
  final String observationId;
  late ObservationsRepository _observationsRepository;
  EditAssessmentBloc(
    this.context,
    this.observationId,
  ) : super(const EditAssessmentState()) {
    _observationsRepository = context.read();
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
    try {
      _observationsRepository.addAssessment(
          observationId,
          AssessmentCreate(
            notificationSent: state.notifySender,
            // observerId: observerId,
            // assessorId: assessorId,
            reportedVia: 'Web',
            // kioskId: kioskId,
            assessmentAwarenessCategoryId: state.category!.id!,
            assessmentObservationTypeId: state.observationType!.id!,
            assessmentPriorityLevelId: state.priorityLevel!.id!,
            assessmentFollowupComment: state.followUpCloseout,
            assessmentCompanyId: state.company!.id!,
            assessmentProjectId: state.project!.id!,
            assessmentSiteId: state.site!.id!,
            userReportedObservationTypeId: state.observationType!.id!,
          ));
    } catch (e) {}
  }

  void _onEditAssessmentCategoryChanged(
    EditAssessmentCategoryChanged event,
    Emitter<EditAssessmentState> emit,
  ) {
    emit(state.copyWith(category: event.category));
  }

  void _onEditAssessmentObservationTypeChanged(
    EditAssessmentObservationTypeChanged event,
    Emitter<EditAssessmentState> emit,
  ) {
    emit(state.copyWith(observationType: event.observationType));
  }

  void _onEditAssessmentPriorityLevelChanged(
    EditAssessmentPriorityLevelChanged event,
    Emitter<EditAssessmentState> emit,
  ) {
    emit(state.copyWith(priorityLevel: event.priorityLevel));
  }

  void _onEditAssessmentProjectChanged(
    EditAssessmentProjectChanged event,
    Emitter<EditAssessmentState> emit,
  ) {
    emit(state.copyWith(project: event.project));
  }

  void _onEditAssessmentCompanyChanged(
    EditAssessmentCompanyChanged event,
    Emitter<EditAssessmentState> emit,
  ) {
    emit(state.copyWith(company: event.company));
  }

  void _onEditAssessmentSiteChanged(
    EditAssessmentSiteChanged event,
    Emitter<EditAssessmentState> emit,
  ) {
    emit(state.copyWith(site: event.site));
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
    if (state.isEditing) {
      add(EditAssessmentAdded());
    }
    emit(state.copyWith(isEditing: !state.isEditing));
  }
}
