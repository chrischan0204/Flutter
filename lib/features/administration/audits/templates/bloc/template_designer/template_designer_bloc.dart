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
    on<TemplateDesignerAddNewQuestionViewShowed>(
        _onTemplateDesignerAddNewQuestionViewShowed);
    on<TemplateDesignerIncludedChanged>(_onTemplateDesignerIncludedChanged);
    on<TemplateDesignerLevelChanged>(_onTemplateDesignerLevelChanged);
    on<TemplateDesignerCurrentTemplateSectionItemChanged>(
        _onTemplateDesignerCurrentTemplateSectionItemChanged);
    on<TemplateDesignerQuestionDetailLoaded>(
        _onTemplateDesignerQuestionDetailLoaded);
    on<TemplateDesignerFollowUpQuestionDetailLoaded>(
        _onTemplateDesignerFollowUpQuestionDetailLoaded);
    on<TemplateDesignerResponseScaleSelected>(
        _onTemplateDesignerResponseScaleSelected);
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

    // if (currentState.templateSectionItemCreateStatus !=
    //         nextState.templateSectionItemCreateStatus &&
    //     nextState.templateSectionItemCreateStatus.isSuccess) {
    //   add(TemplateDesignerTemplateSectionItemQuestionList(
    //       templateSectionId: nextState.selectedTemplateSection!.id));
    // }
    // print('current');
    // print(currentState.templateSectionItem?.toMap());
    // print('next');
    // print(nextState.templateSectionItem?.toMap());

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
      List<TemplateSectionListItem> templateSectionList =
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
          TemplateSectionListItem(
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
      } else if (response.statusCode == 409) {
        emit(state.copyWith(
          templateSectionAddStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        templateSectionAddStatus: EntityStatus.failure,
        message: 'Something went wrong!',
      ));
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
      selectedTemplateSection: Nullable.value(event.templateSection),
      templateSectionItem: const Nullable.value(null),
      showAddNewQuestionView: false,
      level: 0,
      selectedResponseScaleId: const Nullable.value(null),
    ));

    if (event.templateSection != null) {
      add(TemplateDesignerTemplateSectionItemQuestionList(
          templateId: event.templateId!,
          templateSectionId: event.templateSection!.id));
    }
  }

  Future<void> _onTemplateDesignerTemplateSectionItemQuestionList(
    TemplateDesignerTemplateSectionItemQuestionList event,
    Emitter<TemplateDesignerState> emit,
  ) async {
    emit(state.copyWith(
        sectionItemQuestionListLoadStatus: EntityStatus.loading));

    try {
      List<TemplateSection> templateQuestionDetailList =
          await templatesRepository.getTemplateQuestionDetailList(
              event.templateId, 1, event.templateSectionId);
      if (templateQuestionDetailList.isNotEmpty) {
        emit(state.copyWith(
          templateQuestionList:
              templateQuestionDetailList[0].templateSectionItems,
          sectionItemQuestionListLoadStatus: EntityStatus.success,
        ));
      } else {
        emit(state.copyWith(
          templateQuestionList: [],
          sectionItemQuestionListLoadStatus: EntityStatus.success,
        ));
      }
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
      List<TemplateResponseScaleItem> responseScaleItemList =
          await responseScalesRepository
              .getResponseScaleItemList(event.responseScaleId);
      late TemplateSectionItem newTemplateSection;

      switch (state.level) {
        case 0:
          newTemplateSection = state.templateSectionItem!.copyWith(
              responseScaleId: event.responseScaleId,
              question: Nullable.value(state.templateSectionItem!.question
                  ?.copyWith(responseScaleId: event.responseScaleId)),
              children: responseScaleItemList.map((e) {
                return TemplateSectionItem(
                  id: const Uuid().v1(),
                  itemTypeId: 2,
                  templateSectionId: state.selectedTemplateSection!.id,
                  responseScaleId: event.responseScaleId,
                  response: e,
                );
              }).toList());
          break;
        case 1:
          final List<TemplateSectionItem> children =
              List.from(state.templateSectionItem!.children);

          newTemplateSection = state.templateSectionItem!.copyWith(
              children: children
                  .map((child) => child.copyWith(
                      children: child.children
                          .map((e) => e.id ==
                                  state.currentLevel1TemplateSectionItemId
                              ? e.copyWith(
                                  responseScaleId: event.responseScaleId,
                                  question: Nullable.value(e.question?.copyWith(
                                      responseScaleId: event.responseScaleId)),
                                  children: responseScaleItemList
                                      .map((e) => TemplateSectionItem(
                                            id: const Uuid().v1(),
                                            itemTypeId: 2,
                                            templateSectionId: state
                                                .selectedTemplateSection!.id,
                                            responseScaleId:
                                                event.responseScaleId,
                                            response: e,
                                          ))
                                      .toList())
                              : e)
                          .toList()))
                  .toList());

          break;
        case 2:
          final List<TemplateSectionItem> children =
              List.from(state.templateSectionItem!.children);

          newTemplateSection = state.templateSectionItem!.copyWith(
              children: children
                  .map((child) => child.copyWith(
                      children: child.children
                          .map((x) => x.copyWith(
                              children: x.children
                                  .map((y) => y.copyWith(
                                      children: y.children
                                          .map((child) => child.id ==
                                                  state
                                                      .currentLevel2TemplateSectionItemId
                                              ? child.copyWith(
                                                  responseScaleId:
                                                      event.responseScaleId,
                                                  question: Nullable.value(
                                                      child.question?.copyWith(
                                                          responseScaleId: event
                                                              .responseScaleId)),
                                                  children:
                                                      responseScaleItemList
                                                          .map((e) =>
                                                              TemplateSectionItem(
                                                                id: const Uuid()
                                                                    .v1(),
                                                                itemTypeId: 2,
                                                                templateSectionId:
                                                                    state
                                                                        .selectedTemplateSection!
                                                                        .id,
                                                                responseScaleId:
                                                                    event
                                                                        .responseScaleId,
                                                                response: e,
                                                              ))
                                                          .toList())
                                              : child)
                                          .toList()))
                                  .toList()))
                          .toList()))
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
    if (state.templateSectionItem != null) {
      add(TemplateDesignerTemplateSectionItemCreated());
    } else {
      final newTemplateSectionItem = Nullable.value(TemplateSectionItem(
          templateSectionId: state.selectedTemplateSection!.id,
          itemTypeId: 1,
          question: const Question(
            name: '',
            order: 0,
          )));
      emit(state.copyWith(
        templateSectionItem: newTemplateSectionItem,
        level: 0,
      ));
    }
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

    switch (state.level) {
      case 0:
        newTemplateSection = state.templateSectionItem!.copyWith(
            question: Nullable.value(
          state.templateSectionItem!.question?.copyWith(name: event.question),
        ));
        break;
      case 1:
        final List<TemplateSectionItem> children =
            List.from(state.templateSectionItem!.children);

        newTemplateSection = state.templateSectionItem!.copyWith(
            children: children
                .map((child) => child.copyWith(
                    children: child.children
                        .map((e) =>
                            e.id == state.currentLevel1TemplateSectionItemId
                                ? e.copyWith(
                                    question: Nullable.value(
                                    e.question?.copyWith(name: event.question),
                                  ))
                                : e)
                        .toList()))
                .toList());

        break;
      case 2:
        final List<TemplateSectionItem> children =
            List.from(state.templateSectionItem!.children);

        newTemplateSection = state.templateSectionItem!.copyWith(
            children: children
                .map((child) => child.copyWith(
                    children: child.children
                        .map((x) => x.copyWith(
                            children: x.children
                                .map((y) => y.copyWith(
                                    children: y.children
                                        .map((e) => e.id ==
                                                state
                                                    .currentLevel2TemplateSectionItemId
                                            ? e.copyWith(
                                                question: Nullable.value(
                                                e.question?.copyWith(
                                                    name: event.question),
                                              ))
                                            : e)
                                        .toList()))
                                .toList()))
                        .toList()))
                .toList());
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

    final List<TemplateSectionItem> children =
        List.from(state.templateSectionItem!.children);

    switch (state.level) {
      case 0:
        newTemplateSection = state.templateSectionItem!.copyWith(
            children: children
                .map((e) => e.id == event.templateSectionItemId
                    ? e.copyWith(
                        response: Nullable.value(e.response
                            ?.copyWith(commentRequired: event.commentRequired)))
                    : e)
                .toList());
        break;
      case 1:
        newTemplateSection = state.templateSectionItem!.copyWith(
            children: children
                .map((x) => x.copyWith(
                    children: x.children
                        .map((y) => y.copyWith(
                            children: y.children
                                .map((e) => e.id == event.templateSectionItemId
                                    ? e.copyWith(
                                        response: Nullable.value(e.response
                                            ?.copyWith(
                                                commentRequired:
                                                    event.commentRequired)))
                                    : e)
                                .toList()))
                        .toList()))
                .toList());
        break;
      case 2:
        newTemplateSection = state.templateSectionItem!.copyWith(
            children: children
                .map((x) => x.copyWith(
                    children: x.children
                        .map((y) => y.copyWith(
                            children: y.children
                                .map((z) => z.copyWith(
                                    children: z.children
                                        .map((child) => child.copyWith(
                                            children: child.children
                                                .map((e) => e.id == event.templateSectionItemId
                                                    ? e.copyWith(
                                                        response:
                                                            Nullable.value(e.response?.copyWith(commentRequired: event.commentRequired)))
                                                    : e)
                                                .toList()))
                                        .toList()))
                                .toList()))
                        .toList()))
                .toList());
        break;
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

    final List<TemplateSectionItem> children =
        List.from(state.templateSectionItem!.children);

    switch (state.level) {
      case 0:
        newTemplateSection = state.templateSectionItem!.copyWith(
            children: children
                .map((e) => e.id == event.templateSectionItemId
                    ? e.copyWith(
                        response: Nullable.value(e.response?.copyWith(
                            actionItemRequired: event.actionItemRequired)))
                    : e)
                .toList());
        break;
      case 1:
        newTemplateSection = state.templateSectionItem!.copyWith(
            children: children
                .map((x) => x.copyWith(
                    children: x.children
                        .map((y) => y.copyWith(
                            children: y.children
                                .map((e) => e.id == event.templateSectionItemId
                                    ? e.copyWith(
                                        response: Nullable.value(e.response
                                            ?.copyWith(
                                                actionItemRequired:
                                                    event.actionItemRequired)))
                                    : e)
                                .toList()))
                        .toList()))
                .toList());
        break;
      case 2:
        newTemplateSection = state.templateSectionItem!.copyWith(
            children: children
                .map((x) => x.copyWith(
                    children: x.children
                        .map((y) => y.copyWith(
                            children: y.children
                                .map((z) => z.copyWith(
                                    children: z.children
                                        .map((child) => child.copyWith(
                                            children: child.children
                                                .map((e) => e.id == event.templateSectionItemId
                                                    ? e.copyWith(
                                                        response:
                                                            Nullable.value(e.response?.copyWith(actionItemRequired: event.actionItemRequired)))
                                                    : e)
                                                .toList()))
                                        .toList()))
                                .toList()))
                        .toList()))
                .toList());
        break;
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

    final List<TemplateSectionItem> children =
        List.from(state.templateSectionItem!.children);

    switch (state.level) {
      case 0:
        newTemplateSection = state.templateSectionItem!.copyWith(
            children: children
                .map((e) => e.id == event.templateSectionItemId
                    ? e.copyWith(
                        response: Nullable.value(e.response?.copyWith(
                            followUpRequired: event.followUpRequired)))
                    : e)
                .toList());
        break;
      case 1:
        newTemplateSection = state.templateSectionItem!.copyWith(
            children: children
                .map((x) => x.copyWith(
                    children: x.children
                        .map((y) => y.copyWith(
                            children: y.children
                                .map((e) => e.id == event.templateSectionItemId
                                    ? e.copyWith(
                                        response: Nullable.value(e.response
                                            ?.copyWith(
                                                followUpRequired:
                                                    event.followUpRequired)))
                                    : e)
                                .toList()))
                        .toList()))
                .toList());
        break;
      case 2:
        newTemplateSection = state.templateSectionItem!.copyWith(
            children: children
                .map((x) => x.copyWith(
                    children: x.children
                        .map((y) => y.copyWith(
                            children: y.children
                                .map((z) => z.copyWith(
                                    children: z.children
                                        .map((child) => child.copyWith(
                                            children: child.children
                                                .map((e) => e.id == event.templateSectionItemId
                                                    ? e.copyWith(
                                                        response:
                                                            Nullable.value(e.response?.copyWith(followUpRequired: event.followUpRequired)))
                                                    : e)
                                                .toList()))
                                        .toList()))
                                .toList()))
                        .toList()))
                .toList());
        break;
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

    final List<TemplateSectionItem> children =
        List.from(state.templateSectionItem!.children);

    switch (state.level) {
      case 0:
        newTemplateSection = state.templateSectionItem!.copyWith(
            children: children
                .map((e) => e.id == event.templateSectionItemId
                    ? e.copyWith(
                        response: Nullable.value(
                            e.response?.copyWith(score: event.score)))
                    : e)
                .toList());
        break;
      case 1:
        newTemplateSection = state.templateSectionItem!.copyWith(
            children: children
                .map((x) => x.copyWith(
                    children: x.children
                        .map((y) => y.copyWith(
                            children: y.children
                                .map((e) => e.id == event.templateSectionItemId
                                    ? e.copyWith(
                                        response: Nullable.value(e.response
                                            ?.copyWith(score: event.score)))
                                    : e)
                                .toList()))
                        .toList()))
                .toList());
        break;
      case 2:
        newTemplateSection = state.templateSectionItem!.copyWith(
            children: children
                .map((x) => x.copyWith(
                    children: x.children
                        .map((y) => y.copyWith(
                            children: y.children
                                .map((z) => z.copyWith(
                                    children: z.children
                                        .map((child) => child.copyWith(
                                            children: child.children
                                                .map((e) => e.id == event.templateSectionItemId
                                                    ? e.copyWith(
                                                        response:
                                                            Nullable.value(e.response?.copyWith(score: event.score)))
                                                    : e)
                                                .toList()))
                                        .toList()))
                                .toList()))
                        .toList()))
                .toList());
        break;
    }
    emit(state.copyWith(
      templateSectionItem: Nullable.value(newTemplateSection),
      responseScaleItemListLoadStatus: EntityStatus.success,
    ));
  }

  void _onTemplateDesignerIncludedChanged(
    TemplateDesignerIncludedChanged event,
    Emitter<TemplateDesignerState> emit,
  ) {
    late TemplateSectionItem newTemplateSection;

    final List<TemplateSectionItem> children =
        List.from(state.templateSectionItem!.children);

    switch (state.level) {
      case 0:
        newTemplateSection = state.templateSectionItem!.copyWith(
            children: children
                .map((e) => e.id == event.templateSectionItemId
                    ? e.copyWith(
                        response: Nullable.value(
                            e.response?.copyWith(included: event.include)))
                    : e)
                .toList());
        break;
      case 1:
        newTemplateSection = state.templateSectionItem!.copyWith(
            children: children
                .map((x) => x.copyWith(
                    children: x.children
                        .map((y) => y.copyWith(
                            children: y.children
                                .map((e) => e.id == event.templateSectionItemId
                                    ? e.copyWith(
                                        response: Nullable.value(e.response
                                            ?.copyWith(
                                                included: event.include)))
                                    : e)
                                .toList()))
                        .toList()))
                .toList());
        break;
      case 2:
        newTemplateSection = state.templateSectionItem!.copyWith(
            children: children
                .map((x) => x.copyWith(
                    children: x.children
                        .map((y) => y.copyWith(
                            children: y.children
                                .map((z) => z.copyWith(
                                    children: z.children
                                        .map((child) => child.copyWith(
                                            children: child.children
                                                .map((e) => e.id == event.templateSectionItemId
                                                    ? e.copyWith(
                                                        response:
                                                            Nullable.value(e.response?.copyWith(included: event.include)))
                                                    : e)
                                                .toList()))
                                        .toList()))
                                .toList()))
                        .toList()))
                .toList());
        break;
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
      late EntityResponse response;
      if (state.templateSectionItem?.templateSectionItemId == null) {
        response = await sectionsRepository
            .createTemplateSectionItem(state.templateSectionItem!.copyWith(
                children: state.templateSectionItem!.children
                    .map((a) => a.copyWith(
                        response: Nullable.value(a.response?.copyWith(
                          responseScaleItemId: a.response?.id,
                          id: Nullable.value(null),
                        )),
                        children: a.children
                            .map((b) => b.copyWith(
                                  response: Nullable.value(b.response?.copyWith(
                                    responseScaleItemId: b.response?.id,
                                    id: Nullable.value(null),
                                  )),
                                  children: b.children
                                      .map((c) => c.copyWith(
                                          response: Nullable.value(
                                              c.response?.copyWith(
                                            responseScaleItemId: c.response?.id,
                                            id: Nullable.value(null),
                                          )),
                                          children: c.children
                                              .map((d) => d.copyWith(
                                                  response: Nullable.value(
                                                      d.response?.copyWith(
                                                    responseScaleItemId:
                                                        d.response?.id,
                                                    id: Nullable.value(null),
                                                  )),
                                                  children: d.children
                                                      .map((e) => e.copyWith(
                                                          response:
                                                              Nullable.value(e
                                                                  .response
                                                                  ?.copyWith(
                                                            responseScaleItemId:
                                                                e.response?.id,
                                                            id: Nullable.value(
                                                                null),
                                                          )),
                                                          children: e.children
                                                              .map((f) =>
                                                                  f.copyWith())
                                                              .toList()))
                                                      .toList()))
                                              .toList()))
                                      .toList(),
                                ))
                            .toList()))
                    .toList()));
      } else {
        response = await sectionsRepository
            .editTemplateSectionItem(state.templateSectionItem!);
      }

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

  void _onTemplateDesignerAddNewQuestionViewShowed(
    TemplateDesignerAddNewQuestionViewShowed event,
    Emitter<TemplateDesignerState> emit,
  ) {
    emit(state.copyWith(showAddNewQuestionView: event.showAddNewQuestionView));
  }

  void _onTemplateDesignerLevelChanged(
    TemplateDesignerLevelChanged event,
    Emitter<TemplateDesignerState> emit,
  ) {
    emit(state.copyWith(level: event.level));
  }

  void _onTemplateDesignerCurrentTemplateSectionItemChanged(
    TemplateDesignerCurrentTemplateSectionItemChanged event,
    Emitter<TemplateDesignerState> emit,
  ) {
    String followUpQuestionId = const Uuid().v1();
    List<TemplateSectionItem> children =
        List.from(state.templateSectionItem!.children);

    if (state.level == 0) {
      final newTemplateSectionItem = state.templateSectionItem!.copyWith(
          children: children
              .map((child) => child.id == event.templateSectionItemId
                  ? child.copyWith(
                      children: child.children.isNotEmpty
                          ? child.children
                              .map((e) => e.copyWith(
                                    id: followUpQuestionId,
                                    templateSectionId:
                                        state.selectedTemplateSection!.id,
                                    itemTypeId: 3,
                                    response:
                                        Nullable.value(event.responseScaleItem),
                                  ))
                              .toList()
                          : [
                              TemplateSectionItem(
                                id: followUpQuestionId,
                                templateSectionId:
                                    state.selectedTemplateSection!.id,
                                itemTypeId: 3,
                                response: event.responseScaleItem,
                                question: const Question(name: '', order: 0),
                              )
                            ])
                  : child)
              .toList());

      emit(state.copyWith(
        templateSectionItem: Nullable.value(newTemplateSectionItem),
        level: state.level + 1,
        currentLevel1TemplateSectionItemId: followUpQuestionId,
      ));
    } else if (state.level == 1) {
      final newTemplateSectionItem = state.templateSectionItem!.copyWith(
          children: children
              .map((x) => x.copyWith(
                  children: x.children
                      .map((z) => z.copyWith(
                          children: z.children
                              .map((child) =>
                                  child.id == event.templateSectionItemId
                                      ? child.copyWith(
                                          children: child.children.isNotEmpty
                                              ? child.children
                                                  .map((e) => e.copyWith(
                                                        id: followUpQuestionId,
                                                        templateSectionId: state
                                                            .selectedTemplateSection!
                                                            .id,
                                                        itemTypeId: 3,
                                                        response:
                                                            Nullable.value(event
                                                                .responseScaleItem),
                                                      ))
                                                  .toList()
                                              : [
                                                  TemplateSectionItem(
                                                    id: followUpQuestionId,
                                                    templateSectionId: state
                                                        .selectedTemplateSection!
                                                        .id,
                                                    itemTypeId: 3,
                                                    response:
                                                        event.responseScaleItem,
                                                    question: const Question(
                                                        name: '', order: 0),
                                                  )
                                                ])
                                      : child)
                              .toList()))
                      .toList()))
              .toList());

      emit(state.copyWith(
        templateSectionItem: Nullable.value(newTemplateSectionItem),
        level: state.level + 1,
        currentLevel2TemplateSectionItemId: followUpQuestionId,
      ));
    }
  }

  Future<void> _onTemplateDesignerQuestionDetailLoaded(
    TemplateDesignerQuestionDetailLoaded event,
    Emitter<TemplateDesignerState> emit,
  ) async {
    emit(state.copyWith(questionDetailLoadStatus: EntityStatus.loading));
    try {
      final String responseScaleId = event.question.responseScaleId;

      List<TemplateResponseScaleItem> responseScaleItemList =
          await responseScalesRepository
              .getResponseScaleItemList(responseScaleId);

      for (final responseScaleItem in event.question.responseScaleItems) {
        int index = responseScaleItemList
            .indexWhere((element) => element.name == responseScaleItem.name);

        if (index != -1) {
          responseScaleItemList.removeAt(index);
          responseScaleItemList.insert(index, responseScaleItem);
        }
      }

      emit(
        state.copyWith(
          level: state.level,
          selectedResponseScaleId: Nullable.value(responseScaleId),
          templateSectionItem: Nullable.value(
            TemplateSectionItem(
              id: event.question.id,
              itemTypeId: 1,
              templateSectionItemId: event.question.id,
              templateSectionId: state.selectedTemplateSection!.id,
              responseScaleId: responseScaleId,
              question: Question(
                name: event.question.title,
                responseScaleId: responseScaleId,
              ),
              children: responseScaleItemList
                  .map((e) => TemplateSectionItem(
                        response: e,
                        id: e.id,
                        itemTypeId: 2,
                        templateSectionItemId: e.id,
                        parentId: event.question.id,
                        templateSectionId: state.selectedTemplateSection!.id,
                        responseScaleId: responseScaleId,
                      ))
                  .toList(),
            ),
          ),
          showAddNewQuestionView: true,
        ),
      );

      emit(state.copyWith(questionDetailLoadStatus: EntityStatus.success));
    } catch (e) {
      emit(state.copyWith(questionDetailLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onTemplateDesignerFollowUpQuestionDetailLoaded(
    TemplateDesignerFollowUpQuestionDetailLoaded event,
    Emitter<TemplateDesignerState> emit,
  ) async {
    try {
      List<TemplateSection> templateQuestionDetailList =
          await templatesRepository.getTemplateQuestionDetailList(
              event.id, 2, state.selectedTemplateSection!.id);

      final followUpQuestion =
          templateQuestionDetailList[0].templateSectionItems[0];

      List<TemplateResponseScaleItem> responseScaleItemList =
          await responseScalesRepository
              .getResponseScaleItemList(followUpQuestion.responseScaleId);

      for (final responseScaleItem in followUpQuestion.responseScaleItems) {
        int index = responseScaleItemList
            .indexWhere((element) => element.name == responseScaleItem.name);

        if (index != -1) {
          responseScaleItemList.removeAt(index);
          responseScaleItemList.insert(index, responseScaleItem);
        }
      }

      late TemplateSectionItem newTemplateSection;

      switch (state.level) {
        case 1:
          final List<TemplateSectionItem> children =
              List.from(state.templateSectionItem!.children);

          newTemplateSection = state.templateSectionItem!.copyWith(
              children: children
                  .map((child) => child.copyWith(
                      children: child.children
                          .map((e) => e.id ==
                                  state.currentLevel1TemplateSectionItemId
                              ? e.copyWith(
                                  id: followUpQuestion.id,
                                  itemTypeId: 3,
                                  templateSectionId:
                                      state.selectedTemplateSection!.id,
                                  templateSectionItemId: followUpQuestion.id,
                                  responseScaleId:
                                      followUpQuestion.responseScaleId,
                                  question: Nullable.value(
                                    e.question?.copyWith(
                                      name: followUpQuestion.title,
                                      responseScaleId:
                                          followUpQuestion.responseScaleId,
                                    ),
                                  ),
                                  parentId: templateQuestionDetailList[0].id,
                                  children: responseScaleItemList
                                      .map((e) => TemplateSectionItem(
                                            response: e,
                                            id: e.id,
                                            itemTypeId: 2,
                                            parentId: followUpQuestion.id,
                                            templateSectionItemId: e.id,
                                            templateSectionId: state
                                                .selectedTemplateSection!.id,
                                            responseScaleId: followUpQuestion
                                                .responseScaleId,
                                          ))
                                      .toList())
                              : e)
                          .toList()))
                  .toList());
          emit(state.copyWith(
            templateSectionItem: Nullable.value(newTemplateSection),
            currentLevel1TemplateSectionItemId: followUpQuestion.id,
          ));
          break;
        case 2:
          final List<TemplateSectionItem> children =
              List.from(state.templateSectionItem!.children);

          newTemplateSection = state.templateSectionItem!.copyWith(
              children: children
                  .map((child) => child.copyWith(
                      children: child.children
                          .map((x) => x.copyWith(
                              children: x.children
                                  .map((y) => y.copyWith(
                                      children: y.children
                                          .map((e) => e.id ==
                                                  state
                                                      .currentLevel2TemplateSectionItemId
                                              ? e.copyWith(
                                                  id: followUpQuestion.id,
                                                  itemTypeId: 3,
                                                  templateSectionId: state
                                                      .selectedTemplateSection!
                                                      .id,
                                                  templateSectionItemId:
                                                      followUpQuestion.id,
                                                  responseScaleId:
                                                      followUpQuestion
                                                          .responseScaleId,
                                                  question: Nullable.value(
                                                    e.question?.copyWith(
                                                      name: followUpQuestion
                                                          .title,
                                                      responseScaleId:
                                                          followUpQuestion
                                                              .responseScaleId,
                                                    ),
                                                  ),
                                                  parentId:
                                                      templateQuestionDetailList[
                                                              0]
                                                          .id,
                                                  children:
                                                      responseScaleItemList
                                                          .map((e) =>
                                                              TemplateSectionItem(
                                                                response: e,
                                                                id: e.id,
                                                                itemTypeId: 2,
                                                                parentId:
                                                                    followUpQuestion
                                                                        .id,
                                                                templateSectionItemId:
                                                                    e.id,
                                                                templateSectionId:
                                                                    state
                                                                        .selectedTemplateSection!
                                                                        .id,
                                                                responseScaleId:
                                                                    followUpQuestion
                                                                        .responseScaleId,
                                                              ))
                                                          .toList())
                                              : e)
                                          .toList()))
                                  .toList()))
                          .toList()))
                  .toList());
          emit(state.copyWith(
            templateSectionItem: Nullable.value(newTemplateSection),
            currentLevel2TemplateSectionItemId: followUpQuestion.id,
          ));
          break;
      }
    } catch (e) {
      print(e);
    }
  }

  void _onTemplateDesignerResponseScaleSelected(
    TemplateDesignerResponseScaleSelected event,
    Emitter<TemplateDesignerState> emit,
  ) {
    emit(state.copyWith(
        selectedResponseScaleId: Nullable.value(event.responseScaleId)));
  }
}
