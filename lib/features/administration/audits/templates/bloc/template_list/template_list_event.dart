part of 'template_list_bloc.dart';

abstract class TemplateListEvent extends Equatable {
  const TemplateListEvent();

  @override
  List<Object?> get props => [];
}

/// event to load template list
class TemplateListLoaded extends TemplateListEvent {}

/// event to sort template list
class TemplateListSorted extends TemplateListEvent {
  final List<Template> sortedTemplateList;

  const TemplateListSorted({required this.sortedTemplateList});
}

/// event to filer template list
class TemplateListFiltered extends TemplateListEvent {
  final FilteredTableParameter option;
  const TemplateListFiltered({required this.option});

  @override
  List<Object?> get props => [option];
}
