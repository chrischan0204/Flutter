part of 'template_designer_bloc.dart';

class TemplateDesignerState extends Equatable {
  final String newSection;
  final List<TemplateSectionListItem> templateSectionList;
  final EntityStatus templateSectionListLoadStatus;
  final EntityStatus templateSectionAddStatus;

  final List<ResponseScale> responseScaleList;
  final EntityStatus responseScaleListLoadStatus;

  final TemplateSectionListItem? selectedTemplateSection;

  final List<TemplateSectionQuestion> sectionItemQuestionList;
  final EntityStatus sectionItemQuestionListLoadStatus;

  final EntityStatus responseScaleItemListLoadStatus;

  final TemplateSectionItem? templateSectionItem;
  final TemplateSectionItem? initialTemplateSectionItem;
  final EntityStatus templateSectionItemCreateStatus;

  final String message;
  final String templateId;

  final bool showAddNewQuestionView;

  final String? currentLevel1TemplateSectionItemId;
  final String? currentLevel2TemplateSectionItemId;

  final int level;

  final EntityStatus questionDetailLoadStatus;

  // selected response scale id
  final String? selectedResponseScaleId;

  final List<TemplateQuestion> templateQuestionList;

  /// question id to edit question
  final String? selectedQuestionId;

  /// store the loaded id
  final List<String> loadedTemplateSectionItemIdList;

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
    this.initialTemplateSectionItem,
    this.message = '',
    this.showAddNewQuestionView = false,
    this.level = 0,
    this.currentLevel1TemplateSectionItemId,
    this.currentLevel2TemplateSectionItemId,
    this.questionDetailLoadStatus = EntityStatus.initial,
    this.selectedResponseScaleId,
    this.templateQuestionList = const [],
    this.selectedQuestionId,
    this.loadedTemplateSectionItemIdList = const [],
  });

  ResponseScale? get selectedResponseScaleItem => responseScaleList
              .indexWhere((element) => element.id == selectedResponseScaleId) ==
          -1
      ? null
      : responseScaleList
          .firstWhere((element) => element.id == selectedResponseScaleId);

  TemplateSectionItem? currentTemplateSectionItemByLevel(int level) {
    switch (level) {
      case 0:
        return templateSectionItem;
      case 1:
        for (final i in templateSectionItem!.children) {
          for (final j in i.children) {
            if (j.id == currentLevel1TemplateSectionItemId) {
              return j;
            }
          }
        }
        return TemplateSectionItem.empty;
      case 2:
        for (final i in templateSectionItem!.children) {
          for (final j in i.children) {
            for (final k in j.children) {
              for (final l in k.children) {
                if (l.id == currentLevel2TemplateSectionItemId) {
                  return l;
                }
              }
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
        initialTemplateSectionItem,
        templateSectionItemCreateStatus,
        message,
        showAddNewQuestionView,
        level,
        currentLevel1TemplateSectionItemId,
        currentLevel2TemplateSectionItemId,
        questionDetailLoadStatus,
        selectedResponseScaleId,
        selectedResponseScaleItem,
        templateQuestionList,
        selectedQuestionId,
      ];

  bool get formDirty {
    bool level0 = templateSectionItem?.question?.id == null &&
            templateSectionItem?.question?.name.isNotEmpty == true ||
        templateSectionItem?.question?.id != null &&
            initialTemplateSectionItem?.question?.name !=
                templateSectionItem?.question?.name;

    bool level1 = templateSectionItem?.children
            .where((e) => e.children.where((element) {
                  if (templateSectionItem != null) {
                    for (int i = 0;
                        i < templateSectionItem!.children.length;
                        i++) {
                      for (int j = 0;
                          j < templateSectionItem!.children[i].children.length;
                          j++) {
                        if (templateSectionItem!
                                .children[i].children[j].question?.id ==
                            null) {
                          if (templateSectionItem!.children[i].children[j]
                                  .question?.name.isNotEmpty ==
                              true) {
                            return true;
                          }
                        } else {
                          if (templateSectionItem!
                                  .children[i].children[j].question?.name !=
                              initialTemplateSectionItem!
                                  .children[i].children[j].question?.name) {
                            return true;
                          }
                        }
                      }
                    }
                    return false;
                  } else {
                    return false;
                  }
                }).isNotEmpty)
            .isNotEmpty ==
        true;

    bool level2 = templateSectionItem?.children
            .where((e) => e.children
                .where((element) =>
                    element.children
                        .where((x) =>
                            x.children.where((y) {
                              if (templateSectionItem != null) {
                                for (int i = 0;
                                    i < templateSectionItem!.children.length;
                                    i++) {
                                  for (int j = 0;
                                      j <
                                          templateSectionItem!
                                              .children[i].children.length;
                                      j++) {
                                    for (int k = 0;
                                        k <
                                            templateSectionItem!.children[i]
                                                .children[j].children.length;
                                        k++) {
                                      for (int l = 0;
                                          l <
                                              templateSectionItem!
                                                  .children[i]
                                                  .children[j]
                                                  .children[k]
                                                  .children
                                                  .length;
                                          l++) {
                                        if (templateSectionItem!
                                                .children[i]
                                                .children[j]
                                                .children[k]
                                                .children[l]
                                                .question
                                                ?.id ==
                                            null) {
                                          if (templateSectionItem!
                                                  .children[i]
                                                  .children[j]
                                                  .children[k]
                                                  .children[l]
                                                  .question
                                                  ?.name
                                                  .isNotEmpty ==
                                              true) {
                                            return true;
                                          }
                                        } else {
                                          if (templateSectionItem!
                                                  .children[i]
                                                  .children[j]
                                                  .children[k]
                                                  .children[l]
                                                  .question
                                                  ?.name !=
                                              initialTemplateSectionItem!
                                                  .children[i]
                                                  .children[j]
                                                  .children[k]
                                                  .children[l]
                                                  .question
                                                  ?.name) {
                                            return true;
                                          }
                                        }
                                      }
                                    }
                                  }
                                }
                                return false;
                              } else {
                                return false;
                              }
                            }).isNotEmpty ==
                            true)
                        .isNotEmpty ==
                    true)
                .isNotEmpty)
            .isNotEmpty ==
        true;

    return level0 || level1 || level2;
  }

  TemplateDesignerState copyWith({
    String? newSection,
    List<TemplateSectionListItem>? templateSectionList,
    EntityStatus? templateSectionListLoadStatus,
    EntityStatus? templateSectionAddStatus,
    List<ResponseScale>? responseScaleList,
    EntityStatus? responseScaleListLoadStatus,
    Nullable<TemplateSectionListItem?>? selectedTemplateSection,
    EntityStatus? sectionItemQuestionListLoadStatus,
    List<TemplateSectionQuestion>? sectionItemQuestionList,
    EntityStatus? responseScaleItemListLoadStatus,
    Nullable<TemplateSectionItem?>? templateSectionItem,
    Nullable<TemplateSectionItem?>? initialTemplateSectionItem,
    EntityStatus? templateSectionItemCreateStatus,
    String? message,
    String? templateId,
    bool? showAddNewQuestionView,
    int? level,
    String? currentLevel1TemplateSectionItemId,
    String? currentLevel2TemplateSectionItemId,
    EntityStatus? questionDetailLoadStatus,
    Nullable<String?>? selectedResponseScaleId,
    List<TemplateQuestion>? templateQuestionList,
    List<String>? loadedTemplateSectionItemIdList,
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
      initialTemplateSectionItem: initialTemplateSectionItem != null
          ? initialTemplateSectionItem.value
          : this.initialTemplateSectionItem,
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
      questionDetailLoadStatus:
          questionDetailLoadStatus ?? this.questionDetailLoadStatus,
      selectedResponseScaleId: selectedResponseScaleId != null
          ? selectedResponseScaleId.value
          : this.selectedResponseScaleId,
      templateQuestionList: templateQuestionList ?? this.templateQuestionList,
      loadedTemplateSectionItemIdList: loadedTemplateSectionItemIdList ??
          this.loadedTemplateSectionItemIdList,
    );
  }
}
