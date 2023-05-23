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
