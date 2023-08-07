// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'template_designer_bloc.dart';

abstract class TemplateDesignerEvent extends Equatable {
  const TemplateDesignerEvent();

  @override
  List<Object?> get props => [];
}

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

class TemplateDesignerTemplateSectionAdded extends TemplateDesignerEvent {}

class TemplateDesignerNewSectionChanged extends TemplateDesignerEvent {
  final String newSection;
  const TemplateDesignerNewSectionChanged({
    required this.newSection,
  });

  @override
  List<Object> get props => [newSection];
}

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

class TemplateDesignerSectionDeleted extends TemplateDesignerEvent {
  final String sectionId;
  const TemplateDesignerSectionDeleted({required this.sectionId});

  @override
  List<Object> get props => [sectionId];
}

class TemplateDesignerResponseScaleListLoaded extends TemplateDesignerEvent {}

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

class TemplateDesignerNewQuestionButtonClicked extends TemplateDesignerEvent {}

class TemplateDesignerCancelCreateQuestionButtonClicked
    extends TemplateDesignerEvent {}

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

class TemplateDesignerLevelChanged extends TemplateDesignerEvent {
  final int level;
  const TemplateDesignerLevelChanged({
    required this.level,
  });

  @override
  List<Object> get props => [level];
}

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
