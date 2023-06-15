// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_edit_project_bloc.dart';

class AddEditProjectState extends Equatable {
  /// created project id
  final String? createdProjectId;

  /// loaded project
  final Project? loadedProject;

  /// site list
  final List<Site> siteList;

  /// project name
  final String projectName;

  /// site
  final Site? site;

  /// refernece number
  final String referenceNumber;

  /// reference name
  final String referenceName;

  /// initial project name for check dirty
  final String initialProjectName;

  /// initial site for check dirty
  final Site? initialSite;

  /// initial reference number for check dirty
  final String initialReferenceNumber;

  /// initial reference name for check dirty
  final String initialReferenceName;

  /// validation message for project name
  final String projectNameValidationMessage;

  /// validation message for site
  final String siteValidationMessage;

  /// validation message for reference number
  final String refereneceNumberValidationMessage;

  /// validation message for reference name
  final String referenceNameValidationMessage;

  /// creation & edition project status
  final EntityStatus status;

  /// response message from server
  final String message;

  const AddEditProjectState({
    this.createdProjectId,
    this.loadedProject,
    this.siteList = const [],
    this.projectName = '',
    this.site,
    this.referenceNumber = '',
    this.referenceName = '',
    this.initialProjectName = '',
    this.initialSite,
    this.initialReferenceNumber = '',
    this.initialReferenceName = '',
    this.projectNameValidationMessage = '',
    this.siteValidationMessage = '',
    this.refereneceNumberValidationMessage = '',
    this.referenceNameValidationMessage = '',
    this.status = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        createdProjectId,
        loadedProject,
        siteList,
        projectName,
        site,
        referenceNumber,
        referenceName,
        initialProjectName,
        initialSite,
        initialReferenceNumber,
        initialReferenceName,
        projectNameValidationMessage,
        siteValidationMessage,
        refereneceNumberValidationMessage,
        referenceNameValidationMessage,
        status,
        message,
      ];

  /// check if the form is dirty
  bool get formDirty =>
      (!Validation.isEmpty(projectName) && initialProjectName != projectName) ||
      (!Validation.isEmpty(referenceName) &&
          initialReferenceName != referenceName) ||
      (site != null && initialSite?.id != site?.id) ||
      (!Validation.isEmpty(referenceNumber) &&
          initialReferenceNumber != referenceNumber);

  AddEditProjectState copyWith({
    String? createdProjectId,
    Project? loadedProject,
    List<Site>? siteList,
    String? projectName,
    Site? site,
    String? referenceNumber,
    String? referenceName,
    String? initialProjectName,
    Site? initialSite,
    String? initialReferenceNumber,
    String? initialReferenceName,
    String? projectNameValidationMessage,
    String? siteValidationMessage,
    String? refereneceNumberValidationMessage,
    String? referenceNameValidationMessage,
    EntityStatus? status,
    String? message,
  }) {
    return AddEditProjectState(
      createdProjectId: createdProjectId ?? this.createdProjectId,
      loadedProject: loadedProject ?? this.loadedProject,
      siteList: siteList ?? this.siteList,
      projectName: projectName ?? this.projectName,
      site: site ?? this.site,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      referenceName: referenceName ?? this.referenceName,
      initialProjectName: initialProjectName ?? this.initialProjectName,
      initialSite: initialSite ?? this.initialSite,
      initialReferenceNumber:
          initialReferenceNumber ?? this.initialReferenceNumber,
      initialReferenceName: initialReferenceName ?? this.initialReferenceName,
      projectNameValidationMessage:
          projectNameValidationMessage ?? this.projectNameValidationMessage,
      siteValidationMessage:
          siteValidationMessage ?? this.siteValidationMessage,
      refereneceNumberValidationMessage: refereneceNumberValidationMessage ??
          this.refereneceNumberValidationMessage,
      referenceNameValidationMessage:
          referenceNameValidationMessage ?? this.referenceNameValidationMessage,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
