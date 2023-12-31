import '/common_libraries.dart';

part 'template_detail_event.dart';
part 'template_detail_state.dart';

class TemplateDetailBloc
    extends Bloc<TemplateDetailEvent, TemplateDetailState> {
  late TemplatesRepository _templatesRepository;
  final String templateId;
  final BuildContext context;

  static String deleteErrorMessage = ErrorMessage('site').add;
  TemplateDetailBloc({
    required this.context,
    required this.templateId,
  }) : super(const TemplateDetailState()) {
    _templatesRepository = context.read();

    on<TemplateDetailTemplateLoadedById>(_onTemplateDetailTemplateLoadedById);
    on<TemplateDetailTemplateDeleted>(_onTemplateDetailTemplateDeleted);
    on<TemplateDetailSnapshotLoaded>(_onTemplateDetailSnapshotLoaded);
    on<TemplateDetailSectionListLoaded>(_onTemplateDetailSectionListLoaded);
    on<TemplateDetailTemplateQuestionDetailLoaded>(
        _onTemplateDetailTemplateQuestionDetailLoaded);
    on<TemplateDetailSelectionSelected>(_onTemplateDetailSelectionSelected);
    on<TemplateDetailIsOpenChanged>(_onTemplateDetailIsOpenChanged);
    on<TemplateDetailAuditTemplateSnapshotLoaded>(
        _onTemplateDetailAuditTemplateSnapshotLoaded);
    on<TemplateDetailUsageSummaryLoaded>(_onTemplateDetailUsageSummaryLoaded);
  }

  Future<void> _onTemplateDetailTemplateLoadedById(
    TemplateDetailTemplateLoadedById event,
    Emitter<TemplateDetailState> emit,
  ) async {
    emit(state.copyWith(templateLoadStatus: EntityStatus.loading));
    try {
      Template template =
          await _templatesRepository.getTemplateById(event.templateId);
      emit(state.copyWith(
        template: template,
        templateLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        templateLoadStatus: EntityStatus.failure,
      ));
    }
  }

  Future<void> _onTemplateDetailTemplateDeleted(
    TemplateDetailTemplateDeleted event,
    Emitter<TemplateDetailState> emit,
  ) async {
    emit(state.copyWith(templateDeleteStatus: EntityStatus.loading));
    try {
      EntityResponse response =
          await _templatesRepository.deleteTemplate(event.templateId);
      emit(state.copyWith(
        templateDeleteStatus:
            response.isSuccess ? EntityStatus.success : EntityStatus.failure,
        message: response.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        templateDeleteStatus: EntityStatus.failure,
        message: deleteErrorMessage,
      ));
    }
  }

  Future<void> _onTemplateDetailSnapshotLoaded(
    TemplateDetailSnapshotLoaded event,
    Emitter<TemplateDetailState> emit,
  ) async {
    emit(state.copyWith(templateSnapshotListLoadStatus: EntityStatus.loading));

    try {
      List<TemplateSnapshot> templateSnapshotList =
          await _templatesRepository.getTemplateSnapshotList(templateId);
      emit(state.copyWith(
        templateSnapshotList: templateSnapshotList,
        templateSnapshotListLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(
          state.copyWith(templateSnapshotListLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onTemplateDetailTemplateQuestionDetailLoaded(
    TemplateDetailTemplateQuestionDetailLoaded event,
    Emitter<TemplateDetailState> emit,
  ) async {
    try {
      switch (event.level) {
        case 0:
          emit(state.copyWith(
              templateQuestionDetailListLoadStatus: EntityStatus.loading));
          try {
            List<TemplateSection> templateQuestionDetailList =
                await _templatesRepository.getTemplateQuestionDetailList(
                    event.id, event.itemType, event.templateSectionId);
            emit(state.copyWith(
              templateQuestionDetailList: templateQuestionDetailList,
              templateQuestionDetailListLoadStatus: EntityStatus.success,
            ));
          } catch (e) {
            emit(state.copyWith(
                templateQuestionDetailListLoadStatus: EntityStatus.failure));
          }
          break;
        case 1:
          if (event.isOpen == true) {
            List<TemplateSection> templateQuestionDetailList =
                await _templatesRepository.getTemplateQuestionDetailList(
                    event.id, event.itemType, event.templateSectionId);
            emit(state.copyWith(
              templateQuestionDetailList: state.templateQuestionDetailList
                  .map(
                    (x) => x.copyWith(
                      templateSectionItems: x.templateSectionItems
                          .map(
                            (y) => y.copyWith(
                              responseScaleItems: y.responseScaleItems.map((e) {
                                if (e.id == event.id) {
                                  return e.copyWith(
                                    isOpen: event.isOpen,
                                    followUpQuestionList:
                                        templateQuestionDetailList,
                                  );
                                }
                                return e;
                              }).toList(),
                            ),
                          )
                          .toList(),
                    ),
                  )
                  .toList(),
            ));
          } else {
            emit(state.copyWith(
              templateQuestionDetailList: state.templateQuestionDetailList
                  .map(
                    (x) => x.copyWith(
                      templateSectionItems: x.templateSectionItems
                          .map(
                            (y) => y.copyWith(
                              responseScaleItems: y.responseScaleItems.map((e) {
                                if (e.id == event.id) {
                                  return e.copyWith(isOpen: event.isOpen);
                                }
                                return e;
                              }).toList(),
                            ),
                          )
                          .toList(),
                    ),
                  )
                  .toList(),
            ));
          }

          break;
        case 2:
          if (event.isOpen == true) {
            List<TemplateSection> templateQuestionDetailList =
                await _templatesRepository.getTemplateQuestionDetailList(
                    event.id, event.itemType, event.templateSectionId);

            emit(state.copyWith(
                templateQuestionDetailList: state.templateQuestionDetailList
                    .map((x) => x.copyWith(
                        templateSectionItems: x.templateSectionItems
                            .map((y) => y.copyWith(
                                responseScaleItems: y.responseScaleItems
                                    .map((z) => z.copyWith(
                                        followUpQuestionList: z
                                            .followUpQuestionList
                                            .map((e) => e.copyWith(
                                                templateSectionItems: e
                                                    .templateSectionItems
                                                    .map((child) =>
                                                        child.copyWith(
                                                            responseScaleItems:
                                                                child
                                                                    .responseScaleItems
                                                                    .map((c) {
                                                          if (c.id ==
                                                              event.id) {
                                                            return c.copyWith(
                                                              isOpen:
                                                                  event.isOpen,
                                                              followUpQuestionList:
                                                                  templateQuestionDetailList,
                                                            );
                                                          }
                                                          return c;
                                                        }).toList()))
                                                    .toList()))
                                            .toList()))
                                    .toList()))
                            .toList()))
                    .toList()));
          } else {
            emit(state.copyWith(
                templateQuestionDetailList: state.templateQuestionDetailList
                    .map((x) => x.copyWith(
                        templateSectionItems: x.templateSectionItems
                            .map((y) => y.copyWith(
                                responseScaleItems: y.responseScaleItems
                                    .map((z) => z.copyWith(
                                        followUpQuestionList: z
                                            .followUpQuestionList
                                            .map((e) => e.copyWith(
                                                templateSectionItems: e
                                                    .templateSectionItems
                                                    .map((child) =>
                                                        child.copyWith(
                                                            responseScaleItems:
                                                                child
                                                                    .responseScaleItems
                                                                    .map((c) {
                                                          if (c.id ==
                                                              event.id) {
                                                            return c.copyWith(
                                                                isOpen: event
                                                                    .isOpen);
                                                          }
                                                          return c;
                                                        }).toList()))
                                                    .toList()))
                                            .toList()))
                                    .toList()))
                            .toList()))
                    .toList()));
          }

          break;
      }
    } catch (e) {}
  }

  Future<void> _onTemplateDetailSectionListLoaded(
    TemplateDetailSectionListLoaded event,
    Emitter<TemplateDetailState> emit,
  ) async {
    try {
      List<TemplateSectionListItemForDetail> templateSectionList =
          await _templatesRepository
              .getTemplateSectionListForDetail(templateId);
      emit(state.copyWith(templateSectionList: templateSectionList));
    } catch (e) {}
  }

  void _onTemplateDetailSelectionSelected(
    TemplateDetailSelectionSelected event,
    Emitter<TemplateDetailState> emit,
  ) {
    emit(state.copyWith(selectedTemplateSection: event.section));
  }

  void _onTemplateDetailIsOpenChanged(
    TemplateDetailIsOpenChanged event,
    Emitter<TemplateDetailState> emit,
  ) {
    switch (event.level) {
      case 1:
        emit(state.copyWith(
          templateQuestionDetailList: state.templateQuestionDetailList
              .map(
                (x) => x.copyWith(
                  templateSectionItems: x.templateSectionItems.map(
                    (y) {
                      if (y.id == event.id) {
                        return y.copyWith(isOpen: event.isOpen);
                      } else {
                        return y;
                      }
                    },
                  ).toList(),
                ),
              )
              .toList(),
        ));
        break;
      case 2:
        emit(state.copyWith(
            templateQuestionDetailList: state.templateQuestionDetailList
                .map((x) => x.copyWith(
                    templateSectionItems: x.templateSectionItems
                        .map((y) => y.copyWith(
                            responseScaleItems: y.responseScaleItems
                                .map((z) => z.copyWith(
                                    followUpQuestionList: z.followUpQuestionList
                                        .map((e) => e.copyWith(
                                                templateSectionItems: e
                                                    .templateSectionItems
                                                    .map((child) {
                                              if (child.id == event.id) {
                                                return child.copyWith(
                                                    isOpen: event.isOpen);
                                              } else {
                                                return child;
                                              }
                                            }).toList()))
                                        .toList()))
                                .toList()))
                        .toList()))
                .toList()));
        break;
      case 3:
        emit(state.copyWith(
            templateQuestionDetailList: state.templateQuestionDetailList
                .map((x) => x.copyWith(
                    templateSectionItems: x.templateSectionItems
                        .map((y) => y.copyWith(
                            responseScaleItems: y.responseScaleItems
                                .map((z) => z.copyWith(
                                    followUpQuestionList: z.followUpQuestionList
                                        .map((e) => e.copyWith(
                                            templateSectionItems: e
                                                .templateSectionItems
                                                .map((child) => child.copyWith(
                                                    responseScaleItems: child
                                                        .responseScaleItems
                                                        .map((c) => c.copyWith(
                                                            followUpQuestionList: c
                                                                .followUpQuestionList
                                                                .map((cc) =>
                                                                    cc.copyWith(
                                                                        templateSectionItems: cc
                                                                            .templateSectionItems
                                                                            .map(
                                                                              (ccc) => ccc.id == event.id ? ccc.copyWith(isOpen: event.isOpen) : ccc,
                                                                            )
                                                                            .toList()))
                                                                .toList()))
                                                        .toList()))
                                                .toList()))
                                        .toList()))
                                .toList()))
                        .toList()))
                .toList()));
        break;
    }
  }

  Future<void> _onTemplateDetailAuditTemplateSnapshotLoaded(
    TemplateDetailAuditTemplateSnapshotLoaded event,
    Emitter<TemplateDetailState> emit,
  ) async {
    try {
      AuditTemplateSnapshot auditTemplateSnapshot =
          await _templatesRepository.getTemplateAuditSnapshot(templateId);

      emit(state.copyWith(auditTemplateSnapshot: auditTemplateSnapshot));
    } catch (e) {}
  }

  Future<void> _onTemplateDetailUsageSummaryLoaded(
    TemplateDetailUsageSummaryLoaded event,
    Emitter<TemplateDetailState> emit,
  ) async {
    try {
      TemplateUsageSummary templateUsageSummary =
          await _templatesRepository.getTemplateUsageSummary(templateId);

      emit(state.copyWith(templateUsageSummary: templateUsageSummary));
    } catch (e) {}
  }
}
