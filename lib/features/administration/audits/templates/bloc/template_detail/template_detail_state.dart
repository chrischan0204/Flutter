// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'template_detail_bloc.dart';

class TemplateDetailState extends Equatable {
  /// loaded template
  final Template? template;

  /// template snapshot list
  final List<TemplateSnapshot> templateSnapshotList;

  /// template section list to show detail
  final List<TemplateSectionListItemForDetail> templateSectionList;

  /// selected template section
  final TemplateSectionListItemForDetail? selectedTemplateSection;

  /// template question details
  final List<TemplateSection> templateQuestionDetailList;

  /// audit template snapshot
  final AuditTemplateSnapshot? auditTemplateSnapshot;

  /// template snapshot list load status
  final EntityStatus templateSnapshotListLoadStatus;

  /// template load status
  final EntityStatus templateLoadStatus;

  /// template delete status
  final EntityStatus templateDeleteStatus;

  /// response message
  final String message;

  const TemplateDetailState({
    this.template,
    this.templateSnapshotList = const [],
    this.templateSectionList = const [],
    this.templateQuestionDetailList = const [],
    this.selectedTemplateSection,
    this.auditTemplateSnapshot,
    this.templateLoadStatus = EntityStatus.initial,
    this.templateDeleteStatus = EntityStatus.initial,
    this.templateSnapshotListLoadStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        template,
        templateQuestionDetailList,
        selectedTemplateSection,
        auditTemplateSnapshot,
        templateSnapshotList,
        templateSectionList,
        templateSnapshotListLoadStatus,
        templateLoadStatus,
        templateDeleteStatus,
        message,
      ];

  int get totalQuestions => templateSnapshotList
      .map((e) => e.questions)
      .reduce((value, element) => value + element);

  double get totalMaxScore => templateSnapshotList
      .map((e) => e.maxScore)
      .reduce((value, element) => value + element);

  TemplateDetailState copyWith({
    Template? template,
    List<TemplateSnapshot>? templateSnapshotList,
    List<TemplateSectionListItemForDetail>? templateSectionList,
    TemplateSectionListItemForDetail? selectedTemplateSection,
    List<TemplateSection>? templateQuestionDetailList,
    AuditTemplateSnapshot? auditTemplateSnapshot,
    EntityStatus? templateSnapshotListLoadStatus,
    EntityStatus? templateLoadStatus,
    EntityStatus? templateDeleteStatus,
    String? message,
  }) {
    return TemplateDetailState(
      template: template ?? this.template,
      templateSnapshotList: templateSnapshotList ?? this.templateSnapshotList,
      templateSectionList: templateSectionList ?? this.templateSectionList,
      selectedTemplateSection:
          selectedTemplateSection ?? this.selectedTemplateSection,
      templateQuestionDetailList:
          templateQuestionDetailList ?? this.templateQuestionDetailList,
      auditTemplateSnapshot:
          auditTemplateSnapshot ?? this.auditTemplateSnapshot,
      templateSnapshotListLoadStatus:
          templateSnapshotListLoadStatus ?? this.templateSnapshotListLoadStatus,
      templateLoadStatus: templateLoadStatus ?? this.templateLoadStatus,
      templateDeleteStatus: templateDeleteStatus ?? this.templateDeleteStatus,
      message: message ?? this.message,
    );
  }
}
