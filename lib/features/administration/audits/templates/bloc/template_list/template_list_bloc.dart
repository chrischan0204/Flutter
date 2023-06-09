import '/common_libraries.dart';

part 'template_list_event.dart';
part 'template_list_state.dart';

class TemplateListBloc extends Bloc<TemplateListEvent, TemplateListState> {
  final TemplatesRepository templatesRepository;
  TemplateListBloc({required this.templatesRepository})
      : super(const TemplateListState()) {
    on<TemplateListLoaded>(_onTemplateListLoaded);
    on<TemplateListSorted>(_onTemplateListSorted);
    on<TemplateListFiltered>(_onTemplateListFiltered);
  }

  Future<void> _onTemplateListLoaded(
    TemplateListLoaded event,
    Emitter<TemplateListState> emit,
  ) async {
    emit(state.copyWith(templateListLoadStatus: EntityStatus.loading));
    try {
      List<Template> templateList = await templatesRepository.getTemplateList();
      emit(state.copyWith(
        templateListLoadStatus: EntityStatus.success,
        templateList: templateList,
      ));
    } catch (e) {
      emit(state.copyWith(templateListLoadStatus: EntityStatus.failure));
    }
  }

  void _onTemplateListSorted(
    TemplateListSorted event,
    Emitter<TemplateListState> emit,
  ) {
    emit(state.copyWith(templateList: event.sortedTemplateList));
  }

  Future<void> _onTemplateListFiltered(
    TemplateListFiltered event,
    Emitter<TemplateListState> emit,
  ) async {
    emit(state.copyWith(templateListLoadStatus: EntityStatus.loading));

    try {
      final filteredTemplateData =
          await templatesRepository.getFilteredTemplateList(event.option);

      final List<String> columns = List.from(filteredTemplateData.headers
          .where((e) => !e.isHidden)
          .map((e) => e.title));

      emit(state.copyWith(
        templateList: filteredTemplateData.data
            .map((e) => e.template.copyWith(columns: columns))
            .toList(),
        templateListLoadStatus: EntityStatus.success,
        totalRows: filteredTemplateData.totalRows,
      ));
    } catch (e) {
      emit(state.copyWith(templateListLoadStatus: EntityStatus.failure));
    }
  }
}
