part of 'template_designer_bloc.dart';

class TemplateDesignerState extends Equatable {
  final String newSection;
  final List<TemplateSection> templateSectionList;
  final EntityStatus templateSectionListLoadStatus;
  final EntityStatus templateSectionAddStatus;

  final List<ResponseScale> responseScaleList;
  final EntityStatus responseScaleListLoadStatus;

  final TemplateSection? selectedTemplateSection;

  final List<TemplateSectionQuestion> sectionItemQuestionList;
  final EntityStatus sectionItemQuestionListLoadStatus;

  final EntityStatus responseScaleItemListLoadStatus;

  final TemplateSectionItem? templateSectionItem;
  final EntityStatus templateSectionItemCreateStatus;

  final String message;
  final String templateId;
  const TemplateDesignerState({
    this.templateId = '',
    this.newSection = '',
    this.templateSectionList = const [],
    this.templateSectionListLoadStatus = EntityStatus.initial,
    this.templateSectionAddStatus = EntityStatus.initial,
    this.responseScaleList = const [],
    this.responseScaleListLoadStatus = EntityStatus.initial,
    this.selectedTemplateSection,
    this.sectionItemQuestionList = const [],
    this.sectionItemQuestionListLoadStatus = EntityStatus.initial,
    this.responseScaleItemListLoadStatus = EntityStatus.initial,
    this.templateSectionItemCreateStatus = EntityStatus.initial,
    this.templateSectionItem,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        templateId,
        newSection,
        templateSectionList,
        templateSectionListLoadStatus,
        templateSectionAddStatus,
        responseScaleList,
        responseScaleListLoadStatus,
        selectedTemplateSection,
        sectionItemQuestionList,
        sectionItemQuestionListLoadStatus,
        responseScaleItemListLoadStatus,
        templateSectionItem,
        templateSectionItemCreateStatus,
        message,
      ];

  TemplateDesignerState copyWith({
    String? newSection,
    List<TemplateSection>? templateSectionList,
    EntityStatus? templateSectionListLoadStatus,
    EntityStatus? templateSectionAddStatus,
    List<ResponseScale>? responseScaleList,
    EntityStatus? responseScaleListLoadStatus,
    TemplateSection? selectedTemplateSection,
    EntityStatus? sectionItemQuestionListLoadStatus,
    List<TemplateSectionQuestion>? sectionItemQuestionList,
    EntityStatus? responseScaleItemListLoadStatus,
    Nullable<TemplateSectionItem?>? templateSectionItem,
    EntityStatus? templateSectionItemCreateStatus,
    String? message,
    String? templateId,
  }) {
    return TemplateDesignerState(
      newSection: newSection ?? this.newSection,
      templateSectionList: templateSectionList ?? this.templateSectionList,
      templateSectionListLoadStatus:
          templateSectionListLoadStatus ?? this.templateSectionListLoadStatus,
      templateSectionAddStatus:
          templateSectionAddStatus ?? this.templateSectionAddStatus,
      responseScaleList: responseScaleList ?? this.responseScaleList,
      responseScaleListLoadStatus:
          responseScaleListLoadStatus ?? this.responseScaleListLoadStatus,
      selectedTemplateSection:
          selectedTemplateSection ?? this.selectedTemplateSection,
      sectionItemQuestionList:
          sectionItemQuestionList ?? this.sectionItemQuestionList,
      sectionItemQuestionListLoadStatus: sectionItemQuestionListLoadStatus ??
          this.sectionItemQuestionListLoadStatus,
      responseScaleItemListLoadStatus: responseScaleItemListLoadStatus ??
          this.responseScaleItemListLoadStatus,
      templateSectionItem: templateSectionItem != null
          ? templateSectionItem.value
          : this.templateSectionItem,
      templateSectionItemCreateStatus: templateSectionItemCreateStatus ??
          this.templateSectionItemCreateStatus,
      message: message ?? this.message,
      templateId: templateId ?? this.templateId,
    );
  }
}
