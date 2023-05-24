import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '/common_libraries.dart';

part 'template_designer_event.dart';
part 'template_designer_state.dart';

class TemplateDesignerBloc
    extends Bloc<TemplateDesignerEvent, TemplateDesignerState> {
  final TemplatesRepository templatesRepository;
  final ResponseScalesRepository responseScalesRepository;
  final SectionsRepository sectionsRepository;
  TemplateDesignerBloc({
    required this.templatesRepository,
    required this.responseScalesRepository,
    required this.sectionsRepository,
  }) : super(const TemplateDesignerState()) {
    on<TemplateDesignerTemplateSectionListLoaded>(
        _onTemplateDesignerTemplateSectionListLoaded);
    on<TemplateDesignerTemplateSectionAdded>(
        _onTemplateDesignerTemplateSectionAdded);
    on<TemplateDesignerNewSectionChanged>(_onTemplateDesignerNewSectionChanged);
    on<TemplateDesignerResponseScaleListLoaded>(
        _onTemplateDesignerResponseScaleListLoaded);
    on<TemplateDesignerTemplateSectionSelected>(
        _onTemplateDesignerTemplateSectionSelected);
    on<TemplateDesignerTemplateSectionItemQuestionList>(
        _onTemplateDesignerTemplateSectionItemQuestionList);
    on<TemplateDesignerResponseScaleItemListLoaded>(
        _onTemplateDesignerResponseScaleItemListLoaded);
    on<TemplateDesignerQuestionChanged>(_onTemplateDesignerQuestionChanged);
    on<TemplateDesignerTemplateSectionItemCreated>(
        _onTemplateDesignerTemplateSectionItemCreated);
    on<TemplateDesignerCommentRequiredChanged>(
        _onTemplateDesignerCommentRequiredChanged);
    on<TemplateDesignerActionItemChanged>(_onTemplateDesignerActionItemChanged);
    on<TemplateDesignerFollowUpRequiredChanged>(
        _onTemplateDesignerFollowUpRequiredChanged);
    on<TemplateDesignerScoreChanged>(_onTemplateDesignerScoreChanged);
    on<TemplateDesignerNewQuestionButtonClicked>(
        _onTemplateDesignerNewQuestionButtonClicked);
    on<TemplateDesignerCancelCreateQuestionButtonClicked>(
        _onTemplateDesignerCancelCreateQuestionButtonClicked);
  }

  @override
  void onChange(Change<TemplateDesignerState> change) {
    final currentState = change.currentState;
    final nextState = change.nextState;
    if (currentState.templateSectionAddStatus !=
            nextState.templateSectionAddStatus &&
        nextState.templateSectionAddStatus.isSuccess) {
      add(TemplateDesignerTemplateSectionListLoaded(
          templateId: state.templateId));
    }

    if (currentState.selectedTemplateSection !=
            nextState.selectedTemplateSection &&
        nextState.selectedTemplateSection != null) {
      add(TemplateDesignerTemplateSectionItemQuestionList(
          templateSectionId: nextState.selectedTemplateSection!.id));
    }
    print('current');
    print(currentState.templateSectionItem);
    print('next');
    print(nextState.templateSectionItem);

    super.onChange(change);
  }

  Future<void> _onTemplateDesignerTemplateSectionListLoaded(
    TemplateDesignerTemplateSectionListLoaded event,
    Emitter<TemplateDesignerState> emit,
  ) async {
    emit(state.copyWith(
      templateSectionListLoadStatus: EntityStatus.loading,
      templateId: event.templateId,
    ));

    try {
      List<TemplateSection> templateSectionList =
          await templatesRepository.getTemplateSectionList(event.templateId);

      emit(state.copyWith(
        templateSectionListLoadStatus: EntityStatus.success,
        templateSectionList: templateSectionList,
      ));
    } catch (e) {
      emit(state.copyWith(templateSectionListLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onTemplateDesignerTemplateSectionAdded(
    TemplateDesignerTemplateSectionAdded event,
    Emitter<TemplateDesignerState> emit,
  ) async {
    emit(state.copyWith(templateSectionAddStatus: EntityStatus.loading));

    try {
      EntityResponse response = await templatesRepository.addTemplateSection(
          TemplateSection(
            templateId: event.templateId,
            name: state.newSection,
          ),
          event.templateId);
      if (response.statusCode == 200) {
        emit(state.copyWith(
          templateSectionAddStatus: EntityStatus.success,
          message: response.message,
          newSection: '',
        ));
      }
    } catch (e) {
      emit(state.copyWith(templateSectionAddStatus: EntityStatus.failure));
    }
  }

  void _onTemplateDesignerNewSectionChanged(
    TemplateDesignerNewSectionChanged event,
    Emitter<TemplateDesignerState> emit,
  ) {
    emit(state.copyWith(newSection: event.newSection));
  }

  Future<void> _onTemplateDesignerResponseScaleListLoaded(
    TemplateDesignerResponseScaleListLoaded event,
    Emitter<TemplateDesignerState> emit,
  ) async {
    emit(state.copyWith(responseScaleListLoadStatus: EntityStatus.loading));

    try {
      List<ResponseScale> responseScaleList =
          await responseScalesRepository.getResponseScaleList();
      emit(state.copyWith(
        responseScaleList: responseScaleList,
        responseScaleListLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(responseScaleListLoadStatus: EntityStatus.failure));
    }
  }

  void _onTemplateDesignerTemplateSectionSelected(
    TemplateDesignerTemplateSectionSelected event,
    Emitter<TemplateDesignerState> emit,
  ) {
    emit(state.copyWith(
      selectedTemplateSection: event.templateSection,
      templateSectionItem: const Nullable.value(null),
    ));
  }

  Future<void> _onTemplateDesignerTemplateSectionItemQuestionList(
    TemplateDesignerTemplateSectionItemQuestionList event,
    Emitter<TemplateDesignerState> emit,
  ) async {
    emit(state.copyWith(
        sectionItemQuestionListLoadStatus: EntityStatus.loading));

    try {
      List<ResponseScaleItem> sectionItemQuestionList =
          await responseScalesRepository
              .getResponseScaleItemList(event.templateSectionId);

      emit(state.copyWith(
        sectionItemQuestionList: sectionItemQuestionList,
        sectionItemQuestionListLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
          sectionItemQuestionListLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onTemplateDesignerResponseScaleItemListLoaded(
    TemplateDesignerResponseScaleItemListLoaded event,
    Emitter<TemplateDesignerState> emit,
  ) async {
    emit(state.copyWith(responseScaleItemListLoadStatus: EntityStatus.loading));

    try {
      List<ResponseScaleItem> responseScaleItemList =
          await responseScalesRepository
              .getResponseScaleItemList(event.responseScaleId);
      late TemplateSectionItem newTemplateSection;
      if (event.child) {
        final List<TemplateSectionItem> children =
            List.from(state.templateSectionItem!.children);
        final result = children
            .firstWhere((element) => element.id == event.templateSectionItemId);
        final index = children
            .indexWhere((element) => element.id == event.templateSectionItemId);

        children.removeAt(index);
        children.insert(
            index,
            result.copyWith(
                children: responseScaleItemList
                    .map((e) => TemplateSectionItem(
                          id: const Uuid().v1(),
                          templateSectionId: state.selectedTemplateSection!.id,
                          responseScaleId: event.responseScaleId,
                          response: e,
                        ))
                    .toList()));
        newTemplateSection =
            state.templateSectionItem!.copyWith(children: children);
      } else {
        newTemplateSection = state.templateSectionItem!.copyWith(
            responseScaleId: event.responseScaleId,
            children: responseScaleItemList
                .map((e) => TemplateSectionItem(
                      id: const Uuid().v1(),
                      templateSectionId: state.selectedTemplateSection!.id,
                      responseScaleId: event.responseScaleId,
                      response: e,
                    ))
                .toList());
      }

      emit(state.copyWith(
        templateSectionItem: Nullable.value(newTemplateSection),
        responseScaleItemListLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
          responseScaleItemListLoadStatus: EntityStatus.failure));
    }
  }

  void _onTemplateDesignerNewQuestionButtonClicked(
    TemplateDesignerNewQuestionButtonClicked event,
    Emitter<TemplateDesignerState> emit,
  ) {
    emit(state.copyWith(
      templateSectionItem: Nullable.value(TemplateSectionItem(
        templateSectionId: state.selectedTemplateSection!.id,
      )),
    ));
  }

  void _onTemplateDesignerCancelCreateQuestionButtonClicked(
    TemplateDesignerCancelCreateQuestionButtonClicked event,
    Emitter<TemplateDesignerState> emit,
  ) {
    emit(state.copyWith(
      templateSectionItem: const Nullable.value(null),
    ));
  }

  void _onTemplateDesignerQuestionChanged(
    TemplateDesignerQuestionChanged event,
    Emitter<TemplateDesignerState> emit,
  ) {
    late TemplateSectionItem newTemplateSection;
    if (event.child) {
      final List<TemplateSectionItem> children =
          List.from(state.templateSectionItem!.children);
      final result = children
          .firstWhere((element) => element.id == event.templateSectionItemId);
      final index = children
          .indexWhere((element) => element.id == event.templateSectionItemId);

      children.removeAt(index);
      children.insert(
          index,
          result.copyWith(
              question: Question(
            name: event.question,
            responseScaleId: event.responseScaleId,
          )));
      newTemplateSection =
          state.templateSectionItem!.copyWith(children: children);
    } else {
      newTemplateSection = state.templateSectionItem!.copyWith(
          question: Question(
        name: event.question,
        responseScaleId: event.responseScaleId,
        order: 0,
      ));
    }

    emit(state.copyWith(
      templateSectionItem: Nullable.value(newTemplateSection),
      responseScaleItemListLoadStatus: EntityStatus.success,
    ));
  }

  void _onTemplateDesignerCommentRequiredChanged(
    TemplateDesignerCommentRequiredChanged event,
    Emitter<TemplateDesignerState> emit,
  ) {
    late TemplateSectionItem newTemplateSection;
    if (event.child) {
      final List<TemplateSectionItem> children =
          List.from(state.templateSectionItem!.children);
      final result = children
          .firstWhere((element) => element.id == event.templateSectionItemId);
      final index = children
          .indexWhere((element) => element.id == event.templateSectionItemId);

      children.removeAt(index);
      children.insert(
          index,
          result.copyWith(
              response: result.response
                  ?.copyWith(commentRequiered: event.commentRequired)));
      newTemplateSection =
          state.templateSectionItem!.copyWith(children: children);
    } else {
      final List<TemplateSectionItem> children =
          List.from(state.templateSectionItem!.children);
      final result = children
          .firstWhere((element) => element.id == event.templateSectionItemId);
      final index = children
          .indexWhere((element) => element.id == event.templateSectionItemId);

      children.removeAt(index);
      children.insert(
          index,
          result.copyWith(
              response: result.response
                  ?.copyWith(commentRequiered: event.commentRequired)));
      newTemplateSection =
          state.templateSectionItem!.copyWith(children: children);
    }

    emit(state.copyWith(
      templateSectionItem: Nullable.value(newTemplateSection),
      responseScaleItemListLoadStatus: EntityStatus.success,
    ));
  }

  void _onTemplateDesignerActionItemChanged(
    TemplateDesignerActionItemChanged event,
    Emitter<TemplateDesignerState> emit,
  ) {
    late TemplateSectionItem newTemplateSection;
    if (event.child) {
      final List<TemplateSectionItem> children =
          List.from(state.templateSectionItem!.children);
      final result = children
          .firstWhere((element) => element.id == event.templateSectionItemId);
      final index = children
          .indexWhere((element) => element.id == event.templateSectionItemId);

      children.removeAt(index);
      children.insert(
          index,
          result.copyWith(
              response: result.response
                  ?.copyWith(actionItemRequired: event.actionItemRequired)));
      newTemplateSection =
          state.templateSectionItem!.copyWith(children: children);
    } else {
      final List<TemplateSectionItem> children =
          List.from(state.templateSectionItem!.children);
      final result = children
          .firstWhere((element) => element.id == event.templateSectionItemId);
      final index = children
          .indexWhere((element) => element.id == event.templateSectionItemId);

      children.removeAt(index);
      children.insert(
          index,
          result.copyWith(
              response: result.response
                  ?.copyWith(actionItemRequired: event.actionItemRequired)));
      newTemplateSection =
          state.templateSectionItem!.copyWith(children: children);
    }

    emit(state.copyWith(
      templateSectionItem: Nullable.value(newTemplateSection),
      responseScaleItemListLoadStatus: EntityStatus.success,
    ));
  }

  void _onTemplateDesignerFollowUpRequiredChanged(
    TemplateDesignerFollowUpRequiredChanged event,
    Emitter<TemplateDesignerState> emit,
  ) {
    late TemplateSectionItem newTemplateSection;
    if (event.child) {
      final List<TemplateSectionItem> children =
          List.from(state.templateSectionItem!.children);
      final result = children
          .firstWhere((element) => element.id == event.templateSectionItemId);
      final index = children
          .indexWhere((element) => element.id == event.templateSectionItemId);

      children.removeAt(index);
      children.insert(
          index,
          result.copyWith(
              response: result.response
                  ?.copyWith(followUpRequired: event.followUpRequired)));
      newTemplateSection =
          state.templateSectionItem!.copyWith(children: children);
    } else {
      final List<TemplateSectionItem> children =
          List.from(state.templateSectionItem!.children);
      final result = children
          .firstWhere((element) => element.id == event.templateSectionItemId);
      final index = children
          .indexWhere((element) => element.id == event.templateSectionItemId);

      children.removeAt(index);
      children.insert(
          index,
          result.copyWith(
              response: result.response
                  ?.copyWith(followUpRequired: event.followUpRequired)));
      newTemplateSection =
          state.templateSectionItem!.copyWith(children: children);
    }

    emit(state.copyWith(
      templateSectionItem: Nullable.value(newTemplateSection),
      responseScaleItemListLoadStatus: EntityStatus.success,
    ));
  }

  void _onTemplateDesignerScoreChanged(
    TemplateDesignerScoreChanged event,
    Emitter<TemplateDesignerState> emit,
  ) {
    late TemplateSectionItem newTemplateSection;
    if (event.child) {
      final List<TemplateSectionItem> children =
          List.from(state.templateSectionItem!.children);
      final result = children
          .firstWhere((element) => element.id == event.templateSectionItemId);
      final index = children
          .indexWhere((element) => element.id == event.templateSectionItemId);

      children.removeAt(index);
      children.insert(
          index,
          result.copyWith(
              response: result.response?.copyWith(score: event.score)));
      newTemplateSection =
          state.templateSectionItem!.copyWith(children: children);
    } else {
      final List<TemplateSectionItem> children =
          List.from(state.templateSectionItem!.children);
      final result = children
          .firstWhere((element) => element.id == event.templateSectionItemId);
      final index = children
          .indexWhere((element) => element.id == event.templateSectionItemId);

      children.removeAt(index);
      children.insert(
          index,
          result.copyWith(
              response: result.response?.copyWith(score: event.score)));
      newTemplateSection =
          state.templateSectionItem!.copyWith(children: children);
    }

    emit(state.copyWith(
      templateSectionItem: Nullable.value(newTemplateSection),
      responseScaleItemListLoadStatus: EntityStatus.success,
    ));
  }

  Future<void> _onTemplateDesignerTemplateSectionItemCreated(
    TemplateDesignerTemplateSectionItemCreated event,
    Emitter<TemplateDesignerState> emit,
  ) async {
    emit(state.copyWith(templateSectionItemCreateStatus: EntityStatus.loading));

    try {
      EntityResponse response = await sectionsRepository
          .createTemplateSectionItem(state.templateSectionItem!);
      emit(state.copyWith(
        templateSectionItemCreateStatus:
            response.isSuccess.toEntityStatusCode(),
        message: response.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        templateSectionItemCreateStatus: EntityStatus.failure,
        message: 'Something went wrong',
      ));
    }
  }
}
