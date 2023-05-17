part of 'template_detail_bloc.dart';

abstract class TemplateDetailEvent extends Equatable {
  const TemplateDetailEvent();

  @override
  List<Object> get props => [];
}

class TemplateDetailTemplateLoadedById extends TemplateDetailEvent {
  final String templateId;
  const TemplateDetailTemplateLoadedById({required this.templateId});

  @override
  List<Object> get props => [templateId];
}

class TemplateDetailTemplateDeleted extends TemplateDetailEvent {
  final String templateId;
  const TemplateDetailTemplateDeleted({
    required this.templateId,
  });
  @override
  List<Object> get props => [templateId];
}
