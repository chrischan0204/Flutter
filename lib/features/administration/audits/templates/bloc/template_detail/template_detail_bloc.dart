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
}
