part of 'template_list_bloc.dart';

class TemplateListState extends Equatable {
  final List<Template> templateList;
  final EntityStatus templateListLoadStatus;
  const TemplateListState({
    this.templateList = const [],
    this.templateListLoadStatus = EntityStatus.initial,
  });

  @override
  List<Object> get props => [
        templateList,
        templateListLoadStatus,
      ];

  TemplateListState copyWith({
    List<Template>? templateList,
    EntityStatus? templateListLoadStatus,
  }) {
    return TemplateListState(
      templateList: templateList ?? this.templateList,
      templateListLoadStatus:
          templateListLoadStatus ?? this.templateListLoadStatus,
    );
  }
}
