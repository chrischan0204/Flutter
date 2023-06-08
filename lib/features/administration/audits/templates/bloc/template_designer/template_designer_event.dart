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
  final bool child;
  final String templateSectionItemId;

  const TemplateDesignerResponseScaleItemListLoaded({
    required this.responseScaleId,
    required this.child,
    required this.templateSectionItemId,
  });

  @override
  List<Object> get props => [
        responseScaleId,
        child,
        templateSectionItemId,
      ];
}

class TemplateDesignerNewQuestionButtonClicked extends TemplateDesignerEvent {}

class TemplateDesignerCancelCreateQuestionButtonClicked
    extends TemplateDesignerEvent {}

class TemplateDesignerQuestionChanged extends TemplateDesignerEvent {
  final String question;
  final String templateSectionItemId;
  final String responseScaleId;
  final bool child;
  const TemplateDesignerQuestionChanged({
    required this.question,
    required this.child,
    required this.templateSectionItemId,
    required this.responseScaleId,
  });

  @override
  List<Object> get props => [
        question,
        templateSectionItemId,
        responseScaleId,
        child,
      ];
}

class TemplateDesignerCommentRequiredChanged extends TemplateDesignerEvent {
  final bool commentRequired;
  final String templateSectionItemId;
  final bool child;
  const TemplateDesignerCommentRequiredChanged({
    required this.child,
    required this.templateSectionItemId,
    required this.commentRequired,
  });

  @override
  List<Object> get props => [
        templateSectionItemId,
        child,
        commentRequired,
      ];
}

class TemplateDesignerActionItemChanged extends TemplateDesignerEvent {
  final bool actionItemRequired;
  final String templateSectionItemId;
  final bool child;
  const TemplateDesignerActionItemChanged({
    required this.child,
    required this.templateSectionItemId,
    required this.actionItemRequired,
  });

  @override
  List<Object> get props => [
        templateSectionItemId,
        child,
        actionItemRequired,
      ];
}

class TemplateDesignerFollowUpRequiredChanged extends TemplateDesignerEvent {
  final bool followUpRequired;
  final String templateSectionItemId;
  final bool child;
  const TemplateDesignerFollowUpRequiredChanged({
    required this.child,
    required this.templateSectionItemId,
    required this.followUpRequired,
  });

  @override
  List<Object> get props => [
        templateSectionItemId,
        child,
        followUpRequired,
      ];
}

class TemplateDesignerScoreChanged extends TemplateDesignerEvent {
  final double score;
  final String templateSectionItemId;
  final bool child;
  const TemplateDesignerScoreChanged({
    required this.child,
    required this.templateSectionItemId,
    required this.score,
  });

  @override
  List<Object> get props => [
        templateSectionItemId,
        child,
        score,
      ];
}

class TemplateDesignerTemplateSectionItemCreated
    extends TemplateDesignerEvent {}
