// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'template_designer_bloc.dart';

abstract class TemplateDesignerEvent extends Equatable {
  const TemplateDesignerEvent();

  @override
  List<Object?> get props => [];
}

/// event to load template section list
class TemplateDesignerTemplateSectionListLoaded extends TemplateDesignerEvent {}

class TemplateDesignerTemplateSectionListSorted extends TemplateDesignerEvent {
  final Key currentQuestionId;
  final Key newIndex;

  const TemplateDesignerTemplateSectionListSorted({
    required this.currentQuestionId,
    required this.newIndex,
  });

  @override
  List<Object> get props => [
        currentQuestionId,
        newIndex,
      ];
}

/// event to add new template section
class TemplateDesignerTemplateSectionAdded extends TemplateDesignerEvent {}

class TemplateDesignerNewSectionChanged extends TemplateDesignerEvent {
  final String newSection;
  const TemplateDesignerNewSectionChanged({
    required this.newSection,
  });

  @override
  List<Object> get props => [newSection];
}

/// event to update template section
class TemplateDesignerSectionUpdated extends TemplateDesignerEvent {
  final String section;
  final String sectionId;
  const TemplateDesignerSectionUpdated({
    required this.section,
    required this.sectionId,
  });

  @override
  List<Object> get props => [
        section,
        sectionId,
      ];
}

/// event to delete template section
class TemplateDesignerSectionDeleted extends TemplateDesignerEvent {
  final String sectionId;
  const TemplateDesignerSectionDeleted({required this.sectionId});

  @override
  List<Object> get props => [sectionId];
}

/// event to load response scale list
class TemplateDesignerResponseScaleListLoaded extends TemplateDesignerEvent {}

/// event to selected template section
class TemplateDesignerTemplateSectionSelected extends TemplateDesignerEvent {
  final TemplateSectionListItem? templateSection;
  const TemplateDesignerTemplateSectionSelected({
    this.templateSection,
  });

  @override
  List<Object?> get props => [
        templateSection,
      ];
}

/// event to load question list for section
class TemplateDesignerTemplateSectionItemQuestionListLoaded
    extends TemplateDesignerEvent {
  final String templateSectionId;

  const TemplateDesignerTemplateSectionItemQuestionListLoaded({
    required this.templateSectionId,
  });

  @override
  List<Object> get props => [
        templateSectionId,
      ];
}

/// event to  sort question list for section
class TemplateDesignerTemplateSectionItemQuestionListSorted
    extends TemplateDesignerEvent {
  final Key currentQuestionId;
  final Key newIndex;

  const TemplateDesignerTemplateSectionItemQuestionListSorted({
    required this.currentQuestionId,
    required this.newIndex,
  });

  @override
  List<Object> get props => [
        currentQuestionId,
        newIndex,
      ];
}

// event to get response scale item list by response scale id
class TemplateDesignerResponseScaleItemListLoaded
    extends TemplateDesignerEvent {
  final String responseScaleId;

  const TemplateDesignerResponseScaleItemListLoaded({
    required this.responseScaleId,
  });

  @override
  List<Object> get props => [responseScaleId];
}

/// event to click new question button
class TemplateDesignerNewQuestionButtonClicked extends TemplateDesignerEvent {}

/// event to click cancel button to create question
class TemplateDesignerCancelCreateQuestionButtonClicked
    extends TemplateDesignerEvent {}

/// event to change question
class TemplateDesignerQuestionChanged extends TemplateDesignerEvent {
  final String question;
  final String templateSectionItemId;
  const TemplateDesignerQuestionChanged({
    required this.question,
    required this.templateSectionItemId,
  });

  @override
  List<Object> get props => [
        question,
        templateSectionItemId,
      ];
}

/// event to change comment required
class TemplateDesignerCommentRequiredChanged extends TemplateDesignerEvent {
  final bool commentRequired;
  final String responseScaleItemId;
  const TemplateDesignerCommentRequiredChanged({
    required this.commentRequired,
    required this.responseScaleItemId,
  });

  @override
  List<Object> get props => [
        commentRequired,
        responseScaleItemId,
      ];
}

/// event to change action item
class TemplateDesignerActionItemChanged extends TemplateDesignerEvent {
  final bool actionItemRequired;
  final String responseScaleItemId;
  const TemplateDesignerActionItemChanged({
    required this.actionItemRequired,
    required this.responseScaleItemId,
  });

  @override
  List<Object> get props => [
        actionItemRequired,
        responseScaleItemId,
      ];
}

/// event to change follow up required
class TemplateDesignerFollowUpRequiredChanged extends TemplateDesignerEvent {
  final bool followUpRequired;
  final String responseScaleItemId;
  const TemplateDesignerFollowUpRequiredChanged({
    required this.followUpRequired,
    required this.responseScaleItemId,
  });

  @override
  List<Object> get props => [
        followUpRequired,
        responseScaleItemId,
      ];
}

/// event to change score
class TemplateDesignerScoreChanged extends TemplateDesignerEvent {
  final double score;
  final String responseScaleItemId;
  const TemplateDesignerScoreChanged({
    required this.score,
    required this.responseScaleItemId,
  });

  @override
  List<Object> get props => [
        score,
        responseScaleItemId,
      ];
}

/// event to change included
class TemplateDesignerIncludedChanged extends TemplateDesignerEvent {
  final bool include;
  final String responseScaleItemId;
  const TemplateDesignerIncludedChanged({
    required this.include,
    required this.responseScaleItemId,
  });

  @override
  List<Object> get props => [
        include,
        responseScaleItemId,
      ];
}

/// event to created section item
class TemplateDesignerTemplateSectionItemCreated
    extends TemplateDesignerEvent {}

class TemplateDesignerAddNewQuestionViewShowed extends TemplateDesignerEvent {
  final bool showAddNewQuestionView;
  const TemplateDesignerAddNewQuestionViewShowed({
    required this.showAddNewQuestionView,
  });

  @override
  List<Object> get props => [showAddNewQuestionView];
}

/// event to change level of question
class TemplateDesignerLevelChanged extends TemplateDesignerEvent {
  final int level;
  const TemplateDesignerLevelChanged({
    required this.level,
  });

  @override
  List<Object> get props => [level];
}

/// event to change current template section item
class TemplateDesignerCurrentTemplateSectionItemChanged
    extends TemplateDesignerEvent {
  final TemplateResponseScaleItem responseScaleItem;
  final String templateSectionItemId;
  final bool followUp;
  const TemplateDesignerCurrentTemplateSectionItemChanged({
    required this.templateSectionItemId,
    required this.responseScaleItem,
    this.followUp = true,
  });

  @override
  List<Object> get props => [
        followUp,
        templateSectionItemId,
        responseScaleItem,
      ];
}

// event to load question detail by id
class TemplateDesignerQuestionDetailLoaded extends TemplateDesignerEvent {
  final TemplateQuestion question;
  const TemplateDesignerQuestionDetailLoaded({required this.question});

  @override
  List<Object> get props => [question];
}

// event to change the selected response scale id
class TemplateDesignerResponseScaleSelected extends TemplateDesignerEvent {
  // selected response scale id
  final String? responseScaleId;

  const TemplateDesignerResponseScaleSelected({
    this.responseScaleId,
  });

  @override
  List<Object?> get props => [responseScaleId];
}

/// event to load the follow up question detail
class TemplateDesignerFollowUpQuestionDetailLoaded
    extends TemplateDesignerEvent {
  final String id;
  const TemplateDesignerFollowUpQuestionDetailLoaded({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}

/// event to delete question by id
class TemplateDesignerQuestionDeleted extends TemplateDesignerEvent {
  final String questionId;
  const TemplateDesignerQuestionDeleted({
    required this.questionId,
  });

  @override
  List<Object?> get props => [questionId];
}
