import '/common_libraries.dart';

part 'template_detail_event.dart';
part 'template_detail_state.dart';

class TemplateDetailBloc
    extends Bloc<TemplateDetailEvent, TemplateDetailState> {
  final TemplatesRepository templatesRepository;

  static String deleteErrorMessage =
      'There was an error while deleting site. Our team has been notified. Please wait a few minutes and try again.';
  TemplateDetailBloc({required this.templatesRepository})
      : super(const TemplateDetailState()) {
    on<TemplateDetailTemplateLoadedById>(_onTemplateDetailTemplateLoadedById);
    on<TemplateDetailTemplateDeleted>(_onTemplateDetailTemplateDeleted);
    on<TemplateDetailSnapshotLoaded>(_onTemplateDetailSnapshotLoaded);
    on<TemplateDetailSectionListLoaded>(_onTemplateDetailSectionListLoaded);
    on<TemplateDetailTemplateQuestionDetailLoaded>(
        _onTemplateDetailTemplateQuestionDetailLoaded);
    on<TemplateDetailSelectionSelected>(_onTemplateDetailSelectionSelected);
  }

  Future<void> _onTemplateDetailTemplateLoadedById(
    TemplateDetailTemplateLoadedById event,
    Emitter<TemplateDetailState> emit,
  ) async {
    emit(state.copyWith(templateLoadStatus: EntityStatus.loading));
    try {
      Template template =
          await templatesRepository.getTemplateById(event.templateId);
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
          await templatesRepository.deleteTemplate(event.templateId);
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
          await templatesRepository.getTemplateSnapshotList(event.templateId);
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
      TemplateSection templateQuestionDetails =
          await templatesRepository.getTemplateQuestionDetails(
              event.id, event.itemType, event.templateSectionId);
      emit(state.copyWith(
        templateQuestionDetails: templateQuestionDetails,
      ));
    } catch (e) {}
  }

  Future<void> _onTemplateDetailSectionListLoaded(
    TemplateDetailSectionListLoaded event,
    Emitter<TemplateDetailState> emit,
  ) async {
    try {
      List<TemplateSectionListItemForDetail> templateSectionList =
          await templatesRepository
              .getTemplateSectionListForDetail(event.templateId);
      emit(state.copyWith(templateSectionList: templateSectionList));
    } catch (e) {
      emit(
          state.copyWith(templateSnapshotListLoadStatus: EntityStatus.failure));
    }
  }

  void _onTemplateDetailSelectionSelected(
    TemplateDetailSelectionSelected event,
    Emitter<TemplateDetailState> emit,
  ) {
    emit(state.copyWith(selectedTemplateSection: event.section));
  }
}
