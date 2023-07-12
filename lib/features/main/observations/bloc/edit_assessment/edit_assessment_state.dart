part of 'edit_assessment_bloc.dart';

class EditAssessmentState extends Equatable {
  /// category to edit assessment
  final AwarenessCategory? category;

  /// validation message for awareness category
  final String awarenessCategoryValidationMessage;

  /// observation type to edit assessment
  final ObservationType? observationType;

  /// validation message for observation type
  final String observationTypeValidationMessage;

  /// priority level to edit assessment
  final PriorityLevel? priorityLevel;

  /// validation messgae for priority level
  final String priorityLevelValidationMessage;

  /// company to edit assessment
  final Company? company;

  /// validation message for company
  final String companyValidationMessage;

  /// project to edit assessment
  final Project? project;

  /// validation message for project
  final String projectValidationMessage;

  /// site to edit assessment
  final Site? site;

  /// validation message for site
  final String siteValidationMessage;

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
    this.awarenessCategoryValidationMessage = '',
    this.observationType,
    this.observationTypeValidationMessage = '',
    this.priorityLevel,
    this.priorityLevelValidationMessage = '',
    this.company,
    this.companyValidationMessage = '',
    this.project,
    this.projectValidationMessage = '',
    this.site,
    this.siteValidationMessage = '',
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
        awarenessCategoryValidationMessage,
        observationType,
        observationTypeValidationMessage,
        priorityLevel,
        priorityLevelValidationMessage,
        company,
        companyValidationMessage,
        project,
        projectValidationMessage,
        site,
        siteValidationMessage,
        observer,
        reportedVia,
        followUpCloseout,
        markAsClosed,
        notifySender,
        isEditing,
      ];

  EditAssessmentState copyWith({
    AwarenessCategory? category,
    String? awarenessCategoryValidationMessage,
    ObservationType? observationType,
    String? observationTypeValidationMessage,
    PriorityLevel? priorityLevel,
    String? priorityLevelValidationMessage,
    Nullable<Company?>? company,
    String? companyValidationMessage,
    Nullable<Project?>? project,
    String? projectValidationMessage,
    Site? site,
    String? siteValidationMessage,
    String? observer,
    String? reportedVia,
    String? followUpCloseout,
    bool? markAsClosed,
    bool? notifySender,
    bool? isEditing,
  }) {
    return EditAssessmentState(
      category: category ?? this.category,
      awarenessCategoryValidationMessage: awarenessCategoryValidationMessage ??
          this.awarenessCategoryValidationMessage,
      observationType: observationType ?? this.observationType,
      observationTypeValidationMessage: observationTypeValidationMessage ??
          this.observationTypeValidationMessage,
      priorityLevel: priorityLevel ?? this.priorityLevel,
      priorityLevelValidationMessage:
          priorityLevelValidationMessage ?? this.priorityLevelValidationMessage,
      company: company != null ? company.value : this.company,
      companyValidationMessage:
          companyValidationMessage ?? this.companyValidationMessage,
      project: project != null ? project.value : this.project,
      projectValidationMessage:
          projectValidationMessage ?? this.projectValidationMessage,
      site: site ?? this.site,
      siteValidationMessage:
          siteValidationMessage ?? this.siteValidationMessage,
      observer: observer ?? this.observer,
      reportedVia: reportedVia ?? this.reportedVia,
      followUpCloseout: followUpCloseout ?? this.followUpCloseout,
      markAsClosed: markAsClosed ?? this.markAsClosed,
      notifySender: notifySender ?? this.notifySender,
      isEditing: isEditing ?? this.isEditing,
    );
  }
}
