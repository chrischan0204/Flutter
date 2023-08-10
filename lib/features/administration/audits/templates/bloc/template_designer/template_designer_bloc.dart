import 'package:uuid/uuid.dart';

import '/common_libraries.dart';

part 'template_designer_event.dart';
part 'template_designer_state.dart';

class TemplateDesignerBloc
    extends Bloc<TemplateDesignerEvent, TemplateDesignerState> {
  final BuildContext context;
  final String templateId;

  late TemplatesRepository _templatesRepository;
  late ResponseScalesRepository _responseScalesRepository;
  late SectionsRepository _sectionsRepository;
  late FormDirtyBloc _formDirtyBloc;
  late List<String> _loadedTemplateSectionItemIdList;

  TemplateDesignerBloc({
    required this.context,
    required this.templateId,
  }) : super(const TemplateDesignerState()) {
    _templatesRepository = context.read();
    _responseScalesRepository = context.read();
    _sectionsRepository = context.read();
    _formDirtyBloc = context.read();

    _loadedTemplateSectionItemIdList = [];

    on<TemplateDesignerTemplateSectionListLoaded>(
        _onTemplateDesignerTemplateSectionListLoaded);
    on<TemplateDesignerTemplateSectionListSorted>(
        _onTemplateDesignerTemplateSectionListSorted);
    on<TemplateDesignerTemplateSectionAdded>(
        _onTemplateDesignerTemplateSectionAdded);
    on<TemplateDesignerNewSectionChanged>(_onTemplateDesignerNewSectionChanged);
    on<TemplateDesignerSectionUpdated>(_onTemplateDesignerSectionUpdated);
    on<TemplateDesignerSectionDeleted>(_onTemplateDesignerSectionDeleted);
    on<TemplateDesignerResponseScaleListLoaded>(
        _onTemplateDesignerResponseScaleListLoaded);
    on<TemplateDesignerTemplateSectionSelected>(
        _onTemplateDesignerTemplateSectionSelected);
    on<TemplateDesignerTemplateSectionItemQuestionListLoaded>(
        _onTemplateDesignerTemplateSectionItemQuestionListLoaded);
    on<TemplateDesignerTemplateSectionItemQuestionListSorted>(
        _onTemplateDesignerTemplateSectionItemQuestionListSorted);
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
  }

  @override
  void onChange(Change<TemplateDesignerState> change) {
    final currentState = change.currentState;
    final nextState = change.nextState;
    if (currentState.templateSectionAddStatus !=
            nextState.templateSectionAddStatus &&
        nextState.templateSectionAddStatus.isSuccess) {
      add(TemplateDesignerTemplateSectionListLoaded());
    }

    if (currentState.templateSectionItem != nextState.templateSectionItem) {
      _formDirtyBloc.add(FormDirtyChanged(isDirty: nextState.dirty));
    }

    // if (currentState.templateSectionItemCreateStatus !=
    //         nextState.templateSectionItemCreateStatus &&
    //     nextState.templateSectionItemCreateStatus.isSuccess) {
    //   add(TemplateDesignerTemplateSectionItemQuestionListLoaded(
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
      templateId: templateId,
    ));

    try {
      List<TemplateSectionListItem> templateSectionList =
          await _templatesRepository.getTemplateSectionList(templateId);

      emit(state.copyWith(
        templateSectionListLoadStatus: EntityStatus.success,
        templateSectionList: templateSectionList,
      ));
    } catch (e) {
      emit(state.copyWith(templateSectionListLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onTemplateDesignerTemplateSectionListSorted(
    TemplateDesignerTemplateSectionListSorted event,
    Emitter<TemplateDesignerState> emit,
  ) async {
    final List<TemplateSectionListItem> templateSectionList =
        List.from(state.templateSectionList);
    final List<TemplateSectionListItem> savedTemplateSectionList =
        List.from(state.templateSectionList);

    int draggingIndex = templateSectionList.indexWhere(
        (element) => ValueKey(element.id) == event.currentQuestionId);
    int newIndex = templateSectionList
        .indexWhere((element) => ValueKey(element.id) == event.newIndex);

    final draggedItem = templateSectionList[draggingIndex];

    templateSectionList.removeAt(draggingIndex);
    templateSectionList.insert(newIndex, draggedItem);

    List<SortOrder> sortOrderList = [];

    for (int i = 0; i < templateSectionList.length; i++) {
      sortOrderList.add(SortOrder(id: templateSectionList[i].id, order: i));
    }

    try {
      await _templatesRepository.sortTemplateSectionList(sortOrderList);
      emit(state.copyWith(templateSectionList: templateSectionList));
    } catch (e) {
      print(e);
      emit(state.copyWith(templateSectionList: savedTemplateSectionList));
    }
  }

  Future<void> _onTemplateDesignerTemplateSectionAdded(
    TemplateDesignerTemplateSectionAdded event,
    Emitter<TemplateDesignerState> emit,
  ) async {
    emit(state.copyWith(templateSectionAddStatus: EntityStatus.loading));

    try {
      EntityResponse response = await _templatesRepository.addTemplateSection(
          TemplateSectionListItem(
            templateId: templateId,
            name: state.newSection,
          ),
          templateId);
      if (response.statusCode == 200) {
        emit(state.copyWith(
          templateSectionAddStatus: EntityStatus.success,
          message: response.message,
          newSection: '',
        ));
        add(const TemplateDesignerNewSectionChanged(newSection: ''));
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
    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.dirty));
  }

  Future<void> _onTemplateDesignerSectionUpdated(
    TemplateDesignerSectionUpdated event,
    Emitter<TemplateDesignerState> emit,
  ) async {
    emit(state.copyWith(templateSectionAddStatus: EntityStatus.loading));

    try {
      EntityResponse response = await _templatesRepository
          .updateTemplateSection(TemplateSectionListItem(
        id: event.sectionId,
        templateId: templateId,
        name: event.section,
      ));
      if (response.isSuccess) {
        emit(state.copyWith(
          templateSectionAddStatus: EntityStatus.success,
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

  Future<void> _onTemplateDesignerSectionDeleted(
    TemplateDesignerSectionDeleted event,
    Emitter<TemplateDesignerState> emit,
  ) async {
    emit(state.copyWith(templateSectionAddStatus: EntityStatus.loading));

    try {
      EntityResponse response =
          await _templatesRepository.deleteTemplateSection(event.sectionId);
      if (response.isSuccess) {
        emit(state.copyWith(
          templateSectionAddStatus: EntityStatus.success,
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

  Future<void> _onTemplateDesignerResponseScaleListLoaded(
    TemplateDesignerResponseScaleListLoaded event,
    Emitter<TemplateDesignerState> emit,
  ) async {
    emit(state.copyWith(responseScaleListLoadStatus: EntityStatus.loading));

    try {
      List<ResponseScale> responseScaleList =
          await _responseScalesRepository.getResponseScaleList();
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
    ));

    _loadedTemplateSectionItemIdList = [];

    if (event.templateSection != null) {
      add(TemplateDesignerTemplateSectionItemQuestionListLoaded(
        templateSectionId: event.templateSection!.id,
      ));
    }
  }

  Future<void> _onTemplateDesignerTemplateSectionItemQuestionListLoaded(
    TemplateDesignerTemplateSectionItemQuestionListLoaded event,
    Emitter<TemplateDesignerState> emit,
  ) async {
    emit(state.copyWith(
        sectionItemQuestionListLoadStatus: EntityStatus.loading));

    try {
      List<TemplateSection> templateQuestionDetailList =
          await _templatesRepository.getTemplateQuestionDetailList(
              templateId, 1, event.templateSectionId);
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

  Future<void> _onTemplateDesignerTemplateSectionItemQuestionListSorted(
    TemplateDesignerTemplateSectionItemQuestionListSorted event,
    Emitter<TemplateDesignerState> emit,
  ) async {
    final List<TemplateQuestion> templateQuestionList =
        List.from(state.templateQuestionList);

    final List<TemplateQuestion> savedTemplateQuestionList =
        List.from(state.templateQuestionList);

    int draggingIndex = templateQuestionList.indexWhere(
        (element) => ValueKey(element.id) == event.currentQuestionId);
    int newIndex = templateQuestionList
        .indexWhere((element) => ValueKey(element.id) == event.newIndex);

    final draggedItem = templateQuestionList[draggingIndex];

    templateQuestionList.removeAt(draggingIndex);
    templateQuestionList.insert(newIndex, draggedItem);

    List<SortOrder> sortOrderList = [];

    for (int i = 0; i < templateQuestionList.length; i++) {
      sortOrderList
          .add(SortOrder(id: templateQuestionList[i].questionId, order: i));
    }

    try {
      await _templatesRepository.sortTemplateSectionQuestionList(sortOrderList);
      emit(state.copyWith(templateQuestionList: templateQuestionList));
    } catch (e) {
      emit(state.copyWith(templateQuestionList: savedTemplateQuestionList));
    }

    // emit(state.copyWith(templateQuestionList: templateQuestionList));
  }

  Future<void> _onTemplateDesignerResponseScaleItemListLoaded(
    TemplateDesignerResponseScaleItemListLoaded event,
    Emitter<TemplateDesignerState> emit,
  ) async {
    emit(state.copyWith(responseScaleItemListLoadStatus: EntityStatus.loading));

    try {
      List<TemplateResponseScaleItem> responseScaleItemList =
          await _responseScalesRepository
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
                  response: e.copyWith(
                    responseScaleItemId: e.id,
                    id: const Nullable.value(null),
                  ),
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
                                            response: e.copyWith(
                                              responseScaleItemId: e.id,
                                              id: const Nullable.value(null),
                                            ),
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
                                                                response:
                                                                    e.copyWith(
                                                                  responseScaleItemId:
                                                                      e.id,
                                                                  id: const Nullable
                                                                          .value(
                                                                      null),
                                                                ),
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
      if (Validation.isNotEmpty(state.templateSectionItem?.question?.name) ||
          state.templateSectionItem == null) {
        if (state.templateSectionItem?.includedChildren.isEmpty == true) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.info,
            content: FormValidationMessage(fieldName: 'Response scale')
                .requiredMessage,
          ).showNotification();
        } else {
          if (state.currentTemplateSectionItemByLevel(1) ==
              TemplateSectionItem.empty) {
            add(TemplateDesignerTemplateSectionItemCreated());
          } else {
            if (Validation.isNotEmpty(
                state.currentTemplateSectionItemByLevel(1)?.question?.name)) {
              if (state
                      .currentTemplateSectionItemByLevel(1)
                      ?.includedChildren
                      .isEmpty ==
                  true) {
                CustomNotification(
                  context: context,
                  notifyType: NotifyType.info,
                  content:
                      FormValidationMessage(fieldName: 'Level 1 response scale')
                          .requiredMessage,
                ).showNotification();
              } else {
                if (state.currentTemplateSectionItemByLevel(2) ==
                    TemplateSectionItem.empty) {
                  add(TemplateDesignerTemplateSectionItemCreated());
                } else {
                  if (Validation.isNotEmpty(state
                      .currentTemplateSectionItemByLevel(2)
                      ?.question
                      ?.name)) {
                    if (state
                            .currentTemplateSectionItemByLevel(2)
                            ?.includedChildren
                            .isEmpty ==
                        true) {
                      CustomNotification(
                        context: context,
                        notifyType: NotifyType.info,
                        content: FormValidationMessage(
                                fieldName: 'Level 2 response scale')
                            .requiredMessage,
                      ).showNotification();
                    } else {
                      add(TemplateDesignerTemplateSectionItemCreated());
                    }
                  } else {
                    CustomNotification(
                      context: context,
                      notifyType: NotifyType.info,
                      content:
                          FormValidationMessage(fieldName: 'Level 2 question')
                              .requiredMessage,
                    ).showNotification();
                  }
                }
              }
            } else {
              CustomNotification(
                context: context,
                notifyType: NotifyType.info,
                content: FormValidationMessage(fieldName: 'Level 1 question')
                    .requiredMessage,
              ).showNotification();
            }
          }
        }
      } else {
        CustomNotification(
          context: context,
          notifyType: NotifyType.info,
          content: FormValidationMessage(fieldName: 'Question').requiredMessage,
        ).showNotification();
      }
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
                .map((e) => e.response?.responseScaleItemId ==
                        event.responseScaleItemId
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
                                .map((e) => e.response?.responseScaleItemId ==
                                        event.responseScaleItemId
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
                                                .map((e) => e.response
                                                            ?.responseScaleItemId ==
                                                        event.responseScaleItemId
                                                    ? e.copyWith(response: Nullable.value(e.response?.copyWith(commentRequired: event.commentRequired)))
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
                .map((e) =>
                    e.response?.responseScaleItemId == event.responseScaleItemId
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
                                .map((e) => e.response?.responseScaleItemId ==
                                        event.responseScaleItemId
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
                                                .map((e) => e.response
                                                            ?.responseScaleItemId ==
                                                        event.responseScaleItemId
                                                    ? e.copyWith(response: Nullable.value(e.response?.copyWith(actionItemRequired: event.actionItemRequired)))
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
                .map((e) =>
                    e.response?.responseScaleItemId == event.responseScaleItemId
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
                                .map((e) => e.response?.responseScaleItemId ==
                                        event.responseScaleItemId
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
                                                .map((e) => e.response
                                                            ?.responseScaleItemId ==
                                                        event.responseScaleItemId
                                                    ? e.copyWith(response: Nullable.value(e.response?.copyWith(followUpRequired: event.followUpRequired)))
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
                .map((e) =>
                    e.response?.responseScaleItemId == event.responseScaleItemId
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
                                .map((e) => e.response?.responseScaleItemId ==
                                        event.responseScaleItemId
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
                                                .map((e) => e.response
                                                            ?.responseScaleItemId ==
                                                        event.responseScaleItemId
                                                    ? e.copyWith(response: Nullable.value(e.response?.copyWith(score: event.score)))
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
                .map((e) =>
                    e.response?.responseScaleItemId == event.responseScaleItemId
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
                                .map((e) => e.response?.responseScaleItemId ==
                                        event.responseScaleItemId
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
                                                .map((e) => e.response
                                                            ?.responseScaleItemId ==
                                                        event.responseScaleItemId
                                                    ? e.copyWith(response: Nullable.value(e.response?.copyWith(included: event.include)))
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
      if (state.templateSectionItem?.question?.id == null) {
        response = await _sectionsRepository
            .createTemplateSectionItem(state.templateSectionItem!.copyWith(
                children: state.templateSectionItem!.children
                    .map((a) => a.copyWith(
                        response: Nullable.value(a.response?.copyWith(
                          responseScaleItemId: a.response?.id,
                          id: const Nullable.value(null),
                        )),
                        children: a.children
                            .map((b) => b.copyWith(
                                  response: Nullable.value(b.response?.copyWith(
                                    responseScaleItemId: b.response?.id,
                                    id: const Nullable.value(null),
                                  )),
                                  children: b.children
                                      .map((c) => c.copyWith(
                                          response: Nullable.value(
                                              c.response?.copyWith(
                                            responseScaleItemId: c.response?.id,
                                            id: const Nullable.value(null),
                                          )),
                                          children: c.children
                                              .map((d) => d.copyWith(
                                                  response: Nullable.value(
                                                      d.response?.copyWith(
                                                    responseScaleItemId:
                                                        d.response?.id,
                                                    id: const Nullable.value(
                                                        null),
                                                  )),
                                                  children: d.children
                                                      .map((e) => e.copyWith(
                                                          response:
                                                              Nullable.value(e
                                                                  .response
                                                                  ?.copyWith(
                                                            responseScaleItemId:
                                                                e.response?.id,
                                                            id: const Nullable
                                                                .value(null),
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
        response = await _sectionsRepository
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
          children: children.map((child) {
        if (child.id == event.templateSectionItemId) {
          return child.copyWith(
              children: !event.followUp
                  ? []
                  : child.children.isNotEmpty
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
                        ]);
        } else {
          return child;
        }
      }).toList());

      emit(state.copyWith(
        templateSectionItem: Nullable.value(newTemplateSectionItem),
      ));

      if (event.followUp) {
        emit(state.copyWith(
          level: state.level + 1,
          currentLevel1TemplateSectionItemId: followUpQuestionId,
        ));
      }
    } else if (state.level == 1) {
      final newTemplateSectionItem = state.templateSectionItem!.copyWith(
          children: children
              .map((x) => x.copyWith(
                  children: x.children
                      .map((z) => z.copyWith(
                              children: z.children.map((child) {
                            if (child.id == event.templateSectionItemId) {
                              return child.copyWith(
                                  children: !event.followUp
                                      ? []
                                      : child.children.isNotEmpty
                                          ? child.children
                                              .map((e) => e.copyWith(
                                                    id: followUpQuestionId,
                                                    templateSectionId: state
                                                        .selectedTemplateSection!
                                                        .id,
                                                    itemTypeId: 3,
                                                    response: Nullable.value(
                                                        event
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
                                            ]);
                            }
                            return child;
                          }).toList()))
                      .toList()))
              .toList());

      emit(state.copyWith(
        templateSectionItem: Nullable.value(newTemplateSectionItem),
      ));

      if (event.followUp) {
        emit(state.copyWith(
          level: state.level + 1,
          currentLevel2TemplateSectionItemId: followUpQuestionId,
        ));
      }
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
          await _responseScalesRepository
              .getResponseScaleItemList(responseScaleId);

      responseScaleItemList = responseScaleItemList
          .map((e) => e.copyWith(
                id: const Nullable.value(null),
                responseScaleItemId: e.id,
              ))
          .toList();

      for (final responseScaleItem in event.question.responseScaleItems) {
        int index = responseScaleItemList
            .indexWhere((element) => element.name == responseScaleItem.name);

        if (index != -1) {
          responseScaleItemList.removeAt(index);
          responseScaleItemList.insert(index, responseScaleItem);
        }
      }

      final newTemplateSection = TemplateSectionItem(
        id: event.question.id,
        itemTypeId: 1,
        templateSectionItemId: event.question.id,
        templateSectionId: state.selectedTemplateSection!.id,
        responseScaleId: responseScaleId,
        question: Question(
          id: event.question.questionId,
          name: event.question.title,
          responseScaleId: responseScaleId,
        ),
        children: responseScaleItemList
            .map((e) => TemplateSectionItem(
                  response: e,
                  id: e.id ?? e.responseScaleItemId,
                  itemTypeId: 2,
                  templateSectionItemId: e.id,
                  parentId: event.question.id,
                  templateSectionId: state.selectedTemplateSection!.id,
                  responseScaleId: responseScaleId,
                ))
            .toList(),
      );

      emit(
        state.copyWith(
          level: state.level,
          templateSectionItem: Nullable.value(newTemplateSection),
          initialTemplateSectionItem: Nullable.value(newTemplateSection),
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
      if (_loadedTemplateSectionItemIdList.contains(event.id)) {
        return;
      }
      emit(state.copyWith(questionDetailLoadStatus: EntityStatus.loading));
      List<TemplateSection> templateQuestionDetailList =
          await _templatesRepository.getTemplateQuestionDetailList(
              event.id, 2, state.selectedTemplateSection!.id);

      final followUpQuestion =
          templateQuestionDetailList[0].templateSectionItems[0];

      _loadedTemplateSectionItemIdList.add(event.id);

      List<TemplateResponseScaleItem> responseScaleItemList =
          await _responseScalesRepository
              .getResponseScaleItemList(followUpQuestion.responseScaleId);

      responseScaleItemList = responseScaleItemList
          .map((e) => e.copyWith(
              id: const Nullable.value(null), responseScaleItemId: e.id))
          .toList();

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
                                      id: followUpQuestion.questionId,
                                      name: followUpQuestion.title,
                                      responseScaleId:
                                          followUpQuestion.responseScaleId,
                                    ),
                                  ),
                                  parentId: templateQuestionDetailList[0].id,
                                  children: responseScaleItemList
                                      .map((e) => TemplateSectionItem(
                                            response: e,
                                            id: e.id ?? e.responseScaleItemId,
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
            initialTemplateSectionItem: Nullable.value(newTemplateSection),
            currentLevel1TemplateSectionItemId: followUpQuestion.id,
            questionDetailLoadStatus: EntityStatus.success,
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
                                                      id: followUpQuestion
                                                          .questionId,
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
                                                                id: e.id ??
                                                                    e.responseScaleItemId,
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
            initialTemplateSectionItem: Nullable.value(newTemplateSection),
            currentLevel2TemplateSectionItemId: followUpQuestion.id,
            questionDetailLoadStatus: EntityStatus.success,
          ));
          break;
      }
    } catch (e) {
      emit(state.copyWith(questionDetailLoadStatus: EntityStatus.failure));
    }
  }
}
