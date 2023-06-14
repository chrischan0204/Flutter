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

    if (currentState.templateSectionItemCreateStatus !=
            nextState.templateSectionItemCreateStatus &&
        nextState.templateSectionItemCreateStatus.isSuccess) {
      add(TemplateDesignerTemplateSectionItemQuestionList(
          templateSectionId: nextState.selectedTemplateSection!.id));
    }
    print('current');
    print(currentState.templateSectionItem?.toMap());
    print('next');
    print(nextState.templateSectionItem?.toMap());

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
    ));

    if (event.templateSection != null) {
      add(TemplateDesignerTemplateSectionItemQuestionList(
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
      List<TemplateSectionQuestion> sectionItemQuestionList =
          await sectionsRepository.getSectionItemList(event.templateSectionId);

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

      switch (state.level) {
        case 0:
          newTemplateSection = state.templateSectionItem!.copyWith(
              responseScaleId: event.responseScaleId,
              question: Nullable.value(state.templateSectionItem!.question?.copyWith(responseScaleId: event.responseScaleId)),
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
                          .map((e) =>
                              e.id == state.currentLevel1TemplateSectionItemId
                                  ? e.copyWith(
                                      itemTypeId: 2,
                                      responseScaleId: event.responseScaleId,
                                       question: Nullable.value(child.question?.copyWith(responseScaleId: event.responseScaleId)),
                                      children: responseScaleItemList
                                          .map((e) => TemplateSectionItem(
                                                id: const Uuid().v1(),
                                                itemTypeId: 2,
                                                templateSectionId: state
                                                    .selectedTemplateSection!
                                                    .id,
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
                                                  itemTypeId: 2,
                                                  responseScaleId:
                                                      event.responseScaleId,
                                                      question: Nullable.value(child.question?.copyWith(responseScaleId: event.responseScaleId)),
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
      ));
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
          Question(
            name: event.question,
            order: 0,
          ),
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
                                    Question(
                                      name: event.question,
                                      order: 0,
                                    ),
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
                                                Question(
                                                  name: event.question,
                                                  order: 0,
                                                ),
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
                          ? child.children.map((e) => e.copyWith(id: followUpQuestionId,
                                templateSectionId:
                                    state.selectedTemplateSection!.id,
                                itemTypeId: 3,
                                response: Nullable.value(event.responseScaleItem),)).toList()
                          : [
                              TemplateSectionItem(
                                id: followUpQuestionId,
                                templateSectionId:
                                    state.selectedTemplateSection!.id,
                                itemTypeId: 3,
                                response: event.responseScaleItem,
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
                              children: z.children.map((child) => child.id == event.templateSectionItemId
                  ? child.copyWith(
                      children: child.children.isNotEmpty
                          ? child.children.map((e) => e.copyWith(id: followUpQuestionId,
                                templateSectionId:
                                    state.selectedTemplateSection!.id,
                                itemTypeId: 3,
                                response: Nullable.value(event.responseScaleItem),)).toList()
                          : [
                              TemplateSectionItem(
                                id: followUpQuestionId,
                                templateSectionId:
                                    state.selectedTemplateSection!.id,
                                itemTypeId: 3,
                                response: event.responseScaleItem,
                              )
                            ])
                  : child).toList()))
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
      QuestionDetail questionDetail =
          await sectionsRepository.getQuestionDetail(event.id, event.level + 1);
      switch (event.level) {
        case 0:
          emit(
            state.copyWith(
              level: event.level,
              templateSectionItem: Nullable.value(
                TemplateSectionItem(
                  id: questionDetail.id,
                  templateSectionId: state.selectedTemplateSection!.id,
                  responseScaleId: questionDetail.responseScaleId,
                  question: Question(
                    name: questionDetail.name,
                    responseScaleId: questionDetail.responseScaleId,
                  ),
                  children: questionDetail.responseScaleItems
                      .map((e) => TemplateSectionItem(response: e))
                      .toList(),
                ),
              ),
            ),
          );
          break;
        case 1:
          break;
        case 2:
          break;
      }

      emit(state.copyWith(questionDetailLoadStatus: EntityStatus.success));
    } catch (e) {
      emit(state.copyWith(questionDetailLoadStatus: EntityStatus.failure));
    }
  }
}
