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
  // final String templateSectionItemId;
  final String responseScaleId;
  final int level;
  // final bool child;
  const TemplateDesignerQuestionChanged({
    required this.question,
    // required this.child,
    // required this.templateSectionItemId,
    this.level = 0,
    required this.responseScaleId,
  });

  @override
  List<Object> get props => [
        question,
        // templateSectionItemId,
        responseScaleId,
        level,
        // child,
      ];
}

class TemplateDesignerCommentRequiredChanged extends TemplateDesignerEvent {
  final bool commentRequired;
  final int level;
  const TemplateDesignerCommentRequiredChanged({
    this.level = 0,
    required this.commentRequired,
  });

  @override
  List<Object> get props => [
        level,
        commentRequired,
      ];
}

class TemplateDesignerActionItemChanged extends TemplateDesignerEvent {
  final bool actionItemRequired;
  final int level;
  const TemplateDesignerActionItemChanged({
    this.level = 0,
    required this.actionItemRequired,
  });

  @override
  List<Object> get props => [
        level,
        actionItemRequired,
      ];
}

class TemplateDesignerFollowUpRequiredChanged extends TemplateDesignerEvent {
  final bool followUpRequired;
  final int level;
  const TemplateDesignerFollowUpRequiredChanged({
    this.level = 0,
    required this.followUpRequired,
  });

  @override
  List<Object> get props => [
        level,
        followUpRequired,
      ];
}

class TemplateDesignerScoreChanged extends TemplateDesignerEvent {
  final double score;
  final int level;
  // final String templateSectionItemId;
  // final bool child;
  const TemplateDesignerScoreChanged({
    // required this.child,
    // required this.templateSectionItemId,
    this.level = 0,
    required this.score,
  });

  @override
  List<Object> get props => [
        // templateSectionItemId,
        // child,
        level,
        score,
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
