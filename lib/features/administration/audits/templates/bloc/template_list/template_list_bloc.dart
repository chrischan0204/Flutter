import 'package:equatable/equatable.dart';

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
      List<Template> filteredTemplateList = await templatesRepository
          .getFilteredTemplateList(event.filterId, event.includeDeleted);
      emit(state.copyWith(
        templateList: filteredTemplateList,
        templateListLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(templateListLoadStatus: EntityStatus.failure));
    }
  }
}
