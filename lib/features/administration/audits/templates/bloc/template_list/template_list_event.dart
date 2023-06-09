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
  final FilteredTableParameter option;
  const TemplateListFiltered({required this.option});

  @override
  List<Object?> get props => [option];
}
