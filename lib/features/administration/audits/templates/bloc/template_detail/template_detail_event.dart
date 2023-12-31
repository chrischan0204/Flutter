// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'template_detail_bloc.dart';

abstract class TemplateDetailEvent extends Equatable {
  const TemplateDetailEvent();

  @override
  List<Object?> get props => [];
}

/// event to load template detail by id
class TemplateDetailTemplateLoadedById extends TemplateDetailEvent {
  final String templateId;
  const TemplateDetailTemplateLoadedById({
    required this.templateId,
  });
  @override
  List<Object> get props => [templateId];
}

/// event to delete template by id
class TemplateDetailTemplateDeleted extends TemplateDetailEvent {
  final String templateId;
  const TemplateDetailTemplateDeleted({required this.templateId});

  @override
  List<Object> get props => [templateId];
}

/// event to load template snapshot for detail
class TemplateDetailSnapshotLoaded extends TemplateDetailEvent {}

/// event to load question detail
class TemplateDetailTemplateQuestionDetailLoaded extends TemplateDetailEvent {
  final String id;
  final int itemType;
  final String? templateSectionId;
  final int level;
  final bool? isOpen;
  const TemplateDetailTemplateQuestionDetailLoaded({
    required this.id,
    required this.itemType,
    this.templateSectionId,
    required this.level,
    this.isOpen,
  });
  @override
  List<Object?> get props => [
        id,
        itemType,
        templateSectionId,
        level,
        isOpen,
      ];
}

/// event to load template section list
class TemplateDetailSectionListLoaded extends TemplateDetailEvent {}

/// event to  select template section
class TemplateDetailSelectionSelected extends TemplateDetailEvent {
  final TemplateSectionListItemForDetail section;
  const TemplateDetailSelectionSelected({
    required this.section,
  });

  @override
  List<Object> get props => [section];
}

/// event to change the expanded or collapsed of expandable list
class TemplateDetailIsOpenChanged extends TemplateDetailEvent {
  final bool isOpen;
  final int level;
  final String id;
  const TemplateDetailIsOpenChanged({
    required this.isOpen,
    required this.level,
    required this.id,
  });

  @override
  List<Object> get props => [
        isOpen,
        level,
        id,
      ];
}

/// event to load the audit template snapshot
class TemplateDetailAuditTemplateSnapshotLoaded extends TemplateDetailEvent {}

/// event to load the usage summary of template
class TemplateDetailUsageSummaryLoaded extends TemplateDetailEvent {}
