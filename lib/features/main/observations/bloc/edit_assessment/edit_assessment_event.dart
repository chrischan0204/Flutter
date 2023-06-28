// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_assessment_bloc.dart';

abstract class EditAssessmentEvent extends Equatable {
  const EditAssessmentEvent();

  @override
  List<Object> get props => [];
}

class EditAssessmentCategoryChanged extends EditAssessmentEvent {
  final AwarenessCategory category;
  const EditAssessmentCategoryChanged({required this.category});

  @override
  List<Object> get props => [category];
}

class EditAssessmentObservationTypeChanged extends EditAssessmentEvent {
  final ObservationType observationType;
  const EditAssessmentObservationTypeChanged({required this.observationType});

  @override
  List<Object> get props => [observationType];
}

class EditAssessmentPriorityLevelChanged extends EditAssessmentEvent {
  final PriorityLevel priorityLevel;
  const EditAssessmentPriorityLevelChanged({required this.priorityLevel});

  @override
  List<Object> get props => [priorityLevel];
}

class EditAssessmentCompanyChanged extends EditAssessmentEvent {
  final Company company;
  const EditAssessmentCompanyChanged({required this.company});

  @override
  List<Object> get props => [company];
}

class EditAssessmentProjectChanged extends EditAssessmentEvent {
  final Project project;
  const EditAssessmentProjectChanged({required this.project});

  @override
  List<Object> get props => [project];
}

class EditAssessmentSiteChanged extends EditAssessmentEvent {
  final Site site;
  const EditAssessmentSiteChanged({required this.site});

  @override
  List<Object> get props => [site];
}

class EditAssessmentObserverChanged extends EditAssessmentEvent {
  final String observer;
  const EditAssessmentObserverChanged({required this.observer});

  @override
  List<Object> get props => [observer];
}

class EditAssessmentReportedViaChanged extends EditAssessmentEvent {
  final String reportedVia;
  const EditAssessmentReportedViaChanged({required this.reportedVia});

  @override
  List<Object> get props => [reportedVia];
}

class EditAssessmentFollowUpCloseoutChanged extends EditAssessmentEvent {
  final String followUpCloseout;
  const EditAssessmentFollowUpCloseoutChanged({required this.followUpCloseout});

  @override
  List<Object> get props => [followUpCloseout];
}

class EditAssessmentMarkAsClosedChanged extends EditAssessmentEvent {
  final bool markAsClosed;
  const EditAssessmentMarkAsClosedChanged({required this.markAsClosed});

  @override
  List<Object> get props => [markAsClosed];
}

class EditAssessmentNotifySenderChanged extends EditAssessmentEvent {
  final bool notifySender;
  const EditAssessmentNotifySenderChanged({required this.notifySender});

  @override
  List<Object> get props => [notifySender];
}

class EditAssessmentIsEditingChanged extends EditAssessmentEvent {}

class EditAssessmentAdded extends EditAssessmentEvent {}
