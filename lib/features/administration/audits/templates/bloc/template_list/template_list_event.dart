part of 'template_list_bloc.dart';

abstract class TemplateListEvent extends Equatable {
  const TemplateListEvent();

  @override
  List<Object?> get props => [];
}

class TemplateListLoaded extends TemplateListEvent {}

class TemplateListSorted extends TemplateListEvent {
  final List<Template> sortedTemplateList;

  const TemplateListSorted({required this.sortedTemplateList});
}

class TemplateListFiltered extends TemplateListEvent {
  final String filterId;
  final bool includeDeleted;
  final int? pageNum;
  final int? pageSize;
  const TemplateListFiltered({
    required this.filterId,
    this.includeDeleted = false,
    this.pageNum,
    this.pageSize,
  });

  @override
  List<Object?> get props => [
        filterId,
        includeDeleted,
        pageNum,
        pageSize,
      ];
}
