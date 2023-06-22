// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_assessment_bloc.dart';

class EditAssessmentState extends Equatable {
  /// category to edit assessment
  final AwarenessCategory? category;

  /// observation type to edit assessment
  final ObservationType? observationType;

  /// priority level to edit assessment
  final PriorityLevel? priorityLevel;

  /// company to edit assessment
  final Company? company;

  /// project to edit assessment
  final Project? project;

  /// category to edit assessment
  final Site? site;

  /// observer to edit assessment
  final String observer;

  /// report via to edit assessment
  final String reportedVia;

  /// follow up closeout to edit assessment
  final String followUpCloseout;

  /// mark as closed to edit assessment
  final bool markAsClosed;

  /// notify sender to edit assessment
  final bool notifySender;

  /// check if it is editing
  final bool isEditing;

  const EditAssessmentState({
    this.category,
    this.observationType,
    this.priorityLevel,
    this.company,
    this.project,
    this.site,
    this.observer = '',
    this.reportedVia = '',
    this.followUpCloseout = '',
    this.markAsClosed = false,
    this.notifySender = false,
    this.isEditing = false,
  });

  @override
  List<Object?> get props => [
        category,
        observationType,
        priorityLevel,
        company,
        project,
        site,
        observer,
        reportedVia,
        followUpCloseout,
        markAsClosed,
        notifySender,
        isEditing,
      ];

  EditAssessmentState copyWith({
    AwarenessCategory? category,
    ObservationType? observationType,
    PriorityLevel? priorityLevel,
    Company? company,
    Project? project,
    Site? site,
    String? observer,
    String? reportedVia,
    String? followUpCloseout,
    bool? markAsClosed,
    bool? notifySender,
    bool? isEditing,
  }) {
    return EditAssessmentState(
      category: category ?? this.category,
      observationType: observationType ?? this.observationType,
      priorityLevel: priorityLevel ?? this.priorityLevel,
      company: company ?? this.company,
      project: project ?? this.project,
      site: site ?? this.site,
      observer: observer ?? this.observer,
      reportedVia: reportedVia ?? this.reportedVia,
      followUpCloseout: followUpCloseout ?? this.followUpCloseout,
      markAsClosed: markAsClosed ?? this.markAsClosed,
      notifySender: notifySender ?? this.notifySender,
      isEditing: isEditing ?? this.isEditing,
    );
  }
}
