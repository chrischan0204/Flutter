import 'package:file_picker/file_picker.dart';

import '/common_libraries.dart';

part 'observation_image_dock_event.dart';
part 'observation_image_dock_state.dart';

class ObservationImageDockBloc
    extends Bloc<ObservationImageDockEvent, ObservationImageDockState> {
  final String observationId;
  final BuildContext context;

  late DocumentsRepository _documentsRepository;
  ObservationImageDockBloc({
    required this.observationId,
    required this.context,
  }) : super(const ObservationImageDockState()) {
    _documentsRepository = context.read();

    on<ObservationImageDockImageListLoaded>(
        _onObservationImageDockImageListLoaded);
    on<ObservationImageDockImageUpLoaded>(_onObservationImageDockImageUpLoaded);
    on<ObservationImageDockViewChanged>(_onObservationImageDockViewChanged);
    on<ObservatioinImageDockFileListChanged>(
        _onObservatioinImageDockFileListChanged);
  }

  Future<void> _onObservationImageDockImageListLoaded(
    ObservationImageDockImageListLoaded event,
    Emitter<ObservationImageDockState> emit,
  ) async {
    emit(state.copyWith(imageListLoadStatus: EntityStatus.loading));

    try {
      List<Document> imageList = await _documentsRepository.getDocumentList(
        ownerId: observationId,
        ownerType: 'observation',
      );

      emit(state.copyWith(
        imageList: imageList,
        imageListLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(imageListLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onObservationImageDockImageUpLoaded(
    ObservationImageDockImageUpLoaded event,
    Emitter<ObservationImageDockState> emit,
  ) async {
    if (state.fileList.isNotEmpty) {
      emit(state.copyWith(imageUploadStatus: EntityStatus.loading));
      try {
        EntityResponse response = await _documentsRepository.uploadDocuments(
          ownerId: observationId,
          ownerType: 'observation',
          documentList: state.fileList,
        );

        emit(state.copyWith(
          imageUploadStatus: EntityStatus.success,
          isUploadView: false,
          message: response.message,
        ));
      } catch (e) {
        emit(state.copyWith(imageUploadStatus: EntityStatus.failure));
      }
    }
  }

  void _onObservationImageDockViewChanged(
    ObservationImageDockViewChanged event,
    Emitter<ObservationImageDockState> emit,
  ) {
    emit(state.copyWith(isUploadView: event.view));
  }

  void _onObservatioinImageDockFileListChanged(
    ObservatioinImageDockFileListChanged event,
    Emitter<ObservationImageDockState> emit,
  ) {
    emit(state.copyWith(fileList: event.fileList));
  }
}
