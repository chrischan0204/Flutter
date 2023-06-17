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
  final TemplateSectionListItem? templateSection;
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
  final String templateSectionItemId;
  const TemplateDesignerCommentRequiredChanged({
    required this.commentRequired,
    required this.templateSectionItemId,
  });

  @override
  List<Object> get props => [
        commentRequired,
        templateSectionItemId,
      ];
}

class TemplateDesignerActionItemChanged extends TemplateDesignerEvent {
  final bool actionItemRequired;
  final String templateSectionItemId;
  const TemplateDesignerActionItemChanged({
    required this.actionItemRequired,
    required this.templateSectionItemId,
  });

  @override
  List<Object> get props => [
        actionItemRequired,
        templateSectionItemId,
      ];
}

class TemplateDesignerFollowUpRequiredChanged extends TemplateDesignerEvent {
  final bool followUpRequired;
  final String templateSectionItemId;
  const TemplateDesignerFollowUpRequiredChanged({
    required this.followUpRequired,
    required this.templateSectionItemId,
  });

  @override
  List<Object> get props => [
        followUpRequired,
        templateSectionItemId,
      ];
}

class TemplateDesignerScoreChanged extends TemplateDesignerEvent {
  final double score;
  final String templateSectionItemId;
  const TemplateDesignerScoreChanged({
    required this.score,
    required this.templateSectionItemId,
  });

  @override
  List<Object> get props => [
        score,
        templateSectionItemId,
      ];
}

class TemplateDesignerIncludedChanged extends TemplateDesignerEvent {
  final bool include;
  final String templateSectionItemId;
  const TemplateDesignerIncludedChanged({
    required this.include,
    required this.templateSectionItemId,
  });

  @override
  List<Object> get props => [
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
  final TemplateResponseScaleItem responseScaleItem;
  final String templateSectionItemId;
  const TemplateDesignerCurrentTemplateSectionItemChanged({
    required this.templateSectionItemId,
    required this.responseScaleItem,
  });

  @override
  List<Object> get props => [
        templateSectionItemId,
        responseScaleItem,
      ];
}

// event to load question detail by id
class TemplateDesignerQuestionDetailLoaded extends TemplateDesignerEvent {
  final String id;
  final int itemTypeId;
  const TemplateDesignerQuestionDetailLoaded({
    required this.id,
    required this.itemTypeId,
  });

  @override
  List<Object> get props => [id, itemTypeId];
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
