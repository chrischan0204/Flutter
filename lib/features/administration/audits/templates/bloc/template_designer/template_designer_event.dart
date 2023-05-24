// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'template_designer_bloc.dart';

abstract class TemplateDesignerEvent extends Equatable {
  const TemplateDesignerEvent();

  @override
  List<Object> get props => [];
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
  final TemplateSection templateSection;
  const TemplateDesignerTemplateSectionSelected({
    required this.templateSection,
  });

  @override
  List<Object> get props => [templateSection];
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

class TemplateDesignerTemplateSectionItemCreated
    extends TemplateDesignerEvent {}
