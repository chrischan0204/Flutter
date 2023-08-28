// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_assessment_bloc.dart';

abstract class EditAssessmentEvent extends Equatable {
  const EditAssessmentEvent();

  @override
  List<Object?> get props => [];
}

/// event to change category to edit assessment
class EditAssessmentCategoryChanged extends EditAssessmentEvent {
  final AwarenessCategory category;
  const EditAssessmentCategoryChanged({required this.category});

  @override
  List<Object> get props => [category];
}

/// event to change observation type to edit assessment
class EditAssessmentObservationTypeChanged extends EditAssessmentEvent {
  final ObservationType observationType;
  const EditAssessmentObservationTypeChanged({required this.observationType});

  @override
  List<Object> get props => [observationType];
}

/// event to change priority level to edit assessment
class EditAssessmentPriorityLevelChanged extends EditAssessmentEvent {
  final PriorityLevel priorityLevel;
  const EditAssessmentPriorityLevelChanged({required this.priorityLevel});

  @override
  List<Object> get props => [priorityLevel];
}

/// event to change company to edit assessment
class EditAssessmentCompanyChanged extends EditAssessmentEvent {
  final Company? company;
  const EditAssessmentCompanyChanged({required this.company});

  @override
  List<Object?> get props => [company];
}

/// event to change project to edit assessment
class EditAssessmentProjectChanged extends EditAssessmentEvent {
  final Project? project;
  const EditAssessmentProjectChanged({required this.project});

  @override
  List<Object?> get props => [project];
}

/// event to change site to edit assessment
class EditAssessmentSiteChanged extends EditAssessmentEvent {
  final Site site;
  final bool isFirst;
  const EditAssessmentSiteChanged({
    required this.site,
    this.isFirst = false,
  });

  @override
  List<Object> get props => [
        site,
        isFirst,
      ];
}

/// event to change observer to edit assessment
class EditAssessmentObserverChanged extends EditAssessmentEvent {
  final String observer;
  const EditAssessmentObserverChanged({required this.observer});

  @override
  List<Object> get props => [observer];
}

/// event to change reported via to edit assessment
class EditAssessmentReportedViaChanged extends EditAssessmentEvent {
  final String reportedVia;
  const EditAssessmentReportedViaChanged({required this.reportedVia});

  @override
  List<Object> get props => [reportedVia];
}

/// event to change follow up close out to edit assessment
class EditAssessmentFollowUpCloseoutChanged extends EditAssessmentEvent {
  final String followUpCloseout;
  const EditAssessmentFollowUpCloseoutChanged({required this.followUpCloseout});

  @override
  List<Object> get props => [followUpCloseout];
}

/// event to change mark as closed to edit assessment
class EditAssessmentMarkAsClosedChanged extends EditAssessmentEvent {
  final bool markAsClosed;
  const EditAssessmentMarkAsClosedChanged({required this.markAsClosed});

  @override
  List<Object> get props => [markAsClosed];
}

/// event to change notify sender to edit assessment
class EditAssessmentNotifySenderChanged extends EditAssessmentEvent {
  final bool notifySender;
  const EditAssessmentNotifySenderChanged({required this.notifySender});

  @override
  List<Object> get props => [notifySender];
}

/// event to change editing status
class EditAssessmentIsEditingChanged extends EditAssessmentEvent {}

/// event to to edit assessment
class EditAssessmentAdded extends EditAssessmentEvent {}
