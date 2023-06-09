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

  final bool showAddNewQuestionView;

  final String? currentLevel1TemplateSectionItemId;
  final String? currentLevel2TemplateSectionItemId;

  final int level;
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
    this.showAddNewQuestionView = false,
    this.level = 0,
    this.currentLevel1TemplateSectionItemId,
    this.currentLevel2TemplateSectionItemId,
  });

  TemplateSectionItem currentTemplateSectionItemByLevel(int level) {
    switch (level) {
      case 0:
        return templateSectionItem!;
      case 1:
        return templateSectionItem!.children.firstWhere(
            (element) => element.id == currentLevel1TemplateSectionItemId);
      case 2:
        for (final i in templateSectionItem!.children) {
          for (final j in i.children) {
            if (j.id == currentLevel2TemplateSectionItemId) {
              return j;
            }
          }
        }
        return TemplateSectionItem.empty;
      default:
        return TemplateSectionItem.empty;
    }
  }

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
        showAddNewQuestionView,
        level,
        currentLevel1TemplateSectionItemId,
        currentLevel2TemplateSectionItemId,
      ];

  TemplateDesignerState copyWith({
    String? newSection,
    List<TemplateSection>? templateSectionList,
    EntityStatus? templateSectionListLoadStatus,
    EntityStatus? templateSectionAddStatus,
    List<ResponseScale>? responseScaleList,
    EntityStatus? responseScaleListLoadStatus,
    Nullable<TemplateSection?>? selectedTemplateSection,
    EntityStatus? sectionItemQuestionListLoadStatus,
    List<TemplateSectionQuestion>? sectionItemQuestionList,
    EntityStatus? responseScaleItemListLoadStatus,
    Nullable<TemplateSectionItem?>? templateSectionItem,
    EntityStatus? templateSectionItemCreateStatus,
    String? message,
    String? templateId,
    bool? showAddNewQuestionView,
    int? level,
    String? currentLevel1TemplateSectionItemId,
    String? currentLevel2TemplateSectionItemId,
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
      selectedTemplateSection: selectedTemplateSection != null
          ? selectedTemplateSection.value
          : this.selectedTemplateSection,
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
      showAddNewQuestionView:
          showAddNewQuestionView ?? this.showAddNewQuestionView,
      level: level ?? this.level,
      currentLevel1TemplateSectionItemId: currentLevel1TemplateSectionItemId ??
          this.currentLevel1TemplateSectionItemId,
      currentLevel2TemplateSectionItemId: currentLevel2TemplateSectionItemId ??
          this.currentLevel2TemplateSectionItemId,
    );
  }
}
