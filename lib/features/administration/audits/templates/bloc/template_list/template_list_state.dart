part of 'template_list_bloc.dart';

class TemplateListState extends Equatable {
  final List<Template> templateList;
  final EntityStatus templateListLoadStatus;
  final int totalRows;
  const TemplateListState({
    this.templateList = const [],
    this.templateListLoadStatus = EntityStatus.initial,
    this.totalRows = 0,
  });

  @override
  List<Object> get props => [templateList, templateListLoadStatus, totalRows];

  TemplateListState copyWith({
    List<Template>? templateList,
    EntityStatus? templateListLoadStatus,
    int? totalRows,
  }) {
    return TemplateListState(
      templateList: templateList ?? this.templateList,
      templateListLoadStatus:
          templateListLoadStatus ?? this.templateListLoadStatus,
      totalRows: totalRows ?? this.totalRows,
    );
  }
}
