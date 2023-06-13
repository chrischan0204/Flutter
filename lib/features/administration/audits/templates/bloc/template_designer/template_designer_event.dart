// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'template_designer_bloc.dart';

abstract class TemplateDesignerEvent extends Equatable {
  const TemplateDesignerEvent();

  @override
  List<Object?> get props => [];
}

class TemplateDesignerTemplateSectionListLoaded extends TemplateDesignerEvent {
  final String templateId;
  const TemplateDesignerTemplateSectionListLoaded({
    required this.templateId,
  });

  @override
  List<Object> get props => [templateId];
}

class TemplateDesignerTemplateSectionAdded extends TemplateDesignerEvent {
  final String templateId;
  const TemplateDesignerTemplateSectionAdded({
    required this.templateId,
  });

  @override
  List<Object> get props => [templateId];
}

class TemplateDesignerNewSectionChanged extends TemplateDesignerEvent {
  final String newSection;
  const TemplateDesignerNewSectionChanged({
    required this.newSection,
  });

  @override
  List<Object> get props => [newSection];
}

class TemplateDesignerResponseScaleListLoaded extends TemplateDesignerEvent {}

class TemplateDesignerTemplateSectionSelected extends TemplateDesignerEvent {
  final TemplateSection? templateSection;
  const TemplateDesignerTemplateSectionSelected({
    this.templateSection,
  });

  @override
  List<Object?> get props => [templateSection];
}

class TemplateDesignerTemplateSectionItemQuestionList
    extends TemplateDesignerEvent {
  final String templateSectionId;

  const TemplateDesignerTemplateSectionItemQuestionList({
    required this.templateSectionId,
  });

  @override
  List<Object> get props => [templateSectionId];
}

class TemplateDesignerResponseScaleItemListLoaded
    extends TemplateDesignerEvent {
  final String responseScaleId;
  final int level;
  // final bool child;
  // final String templateSectionItemId;

  const TemplateDesignerResponseScaleItemListLoaded({
    required this.responseScaleId,
    this.level = 0,
    // required this.child,
    // required this.templateSectionItemId,
  });

  @override
  List<Object> get props => [
        responseScaleId,
        level,
        // child,
        // templateSectionItemId,
      ];
}

class TemplateDesignerNewQuestionButtonClicked extends TemplateDesignerEvent {}

class TemplateDesignerCancelCreateQuestionButtonClicked
    extends TemplateDesignerEvent {}

class TemplateDesignerQuestionChanged extends TemplateDesignerEvent {
  final String question;
  final String templateSectionItemId;
  final String responseScaleId;
  const TemplateDesignerQuestionChanged({
    required this.question,
    required this.templateSectionItemId,
    required this.responseScaleId,
  });

  @override
  List<Object> get props => [
        question,
        templateSectionItemId,
        responseScaleId,
      ];
}

class TemplateDesignerCommentRequiredChanged extends TemplateDesignerEvent {
  final bool commentRequired;
  final int level;
  final String templateSectionItemId;
  const TemplateDesignerCommentRequiredChanged({
    this.level = 0,
    required this.commentRequired,
    required this.templateSectionItemId,
  });

  @override
  List<Object> get props => [
        level,
        commentRequired,
        templateSectionItemId,
      ];
}

class TemplateDesignerActionItemChanged extends TemplateDesignerEvent {
  final bool actionItemRequired;
  final int level;
  final String templateSectionItemId;
  const TemplateDesignerActionItemChanged({
    this.level = 0,
    required this.actionItemRequired,
    required this.templateSectionItemId,
  });

  @override
  List<Object> get props => [
        level,
        actionItemRequired,
        templateSectionItemId,
      ];
}

class TemplateDesignerFollowUpRequiredChanged extends TemplateDesignerEvent {
  final bool followUpRequired;
  final int level;
  final String templateSectionItemId;
  const TemplateDesignerFollowUpRequiredChanged({
    this.level = 0,
    required this.followUpRequired,
    required this.templateSectionItemId,
  });

  @override
  List<Object> get props => [
        level,
        followUpRequired,
        templateSectionItemId,
      ];
}

class TemplateDesignerScoreChanged extends TemplateDesignerEvent {
  final double score;
  final int level;
  final String templateSectionItemId;
  const TemplateDesignerScoreChanged({
    this.level = 0,
    required this.score,
    required this.templateSectionItemId,
  });

  @override
  List<Object> get props => [
        level,
        score,
        templateSectionItemId,
      ];
}

class TemplateDesignerIncludedChanged extends TemplateDesignerEvent {
  final bool include;
  final int level;
  final String templateSectionItemId;
  const TemplateDesignerIncludedChanged({
    this.level = 0,
    required this.include,
    required this.templateSectionItemId,
  });

  @override
  List<Object> get props => [
        level,
        include,
        templateSectionItemId,
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
  final String templateSectionItemId;
  const TemplateDesignerCurrentTemplateSectionItemChanged({
    required this.templateSectionItemId,
  });

  @override
  List<Object> get props => [templateSectionItemId];
}

class TemplateDesignerQuestionDetailLoaded extends TemplateDesignerEvent {
  final String id;
  final int level;
  const TemplateDesignerQuestionDetailLoaded({
    required this.id,
    required this.level,
  });

  @override
  List<Object> get props => [id, level];
}
