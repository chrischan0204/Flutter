import '/common_libraries.dart';

part 'observation_types_event.dart';
part 'observation_types_state.dart';

class ObservationTypesBloc
    extends Bloc<ObservationTypesEvent, ObservationTypesState> {
  final ObservationTypesRepository observationTypesRepository;

  static String deleteErrorMessage = ErrorMessage('observation type').delete;
  ObservationTypesBloc({
    required this.observationTypesRepository,
  }) : super(const ObservationTypesState()) {
    _triggerEvents();
  }

  // trigger events
  void _triggerEvents() {
    on<ObservationTypesLoaded>(_onObservationTypesLoaded);
    on<ObservationTypeSelected>(_onObservationTypeSelected);
    on<ObservationTypeSelectedById>(_onObservationTypeSelectedById);
    on<ObservationTypeDeleted>(_onObservationTypeDeleted);
    on<ObservationTypesStatusInited>(_onObservationTypesStatusInited);
  }

  // get observation types list
  Future<void> _onObservationTypesLoaded(
    ObservationTypesLoaded event,
    Emitter<ObservationTypesState> emit,
  ) async {
    emit(state.copyWith(
      observationTypesLoadedStatus: EntityStatus.loading,
    ));
    try {
      List<ObservationType> observationTypes =
          await observationTypesRepository.getObservationTypeList();
      emit(state.copyWith(
        observationTypes: observationTypes,
        observationTypesLoadedStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        observationTypesLoadedStatus: EntityStatus.failure,
      ));
    }
  }

  // select observation type
  Future<void> _onObservationTypeSelected(
    ObservationTypeSelected event,
    Emitter<ObservationTypesState> emit,
  ) async {
    emit(state.copyWith(
      observationTypeSelectedStatus: EntityStatus.success,
      selectedObservationType: event.observationType,
    ));
  }

  // select observation type by id
  Future<void> _onObservationTypeSelectedById(
    ObservationTypeSelectedById event,
    Emitter<ObservationTypesState> emit,
  ) async {
    emit(state.copyWith(
      observationTypeSelectedStatus: EntityStatus.loading,
      selectedObservationType: null,
    ));
    try {
      ObservationType? selectedObservationType =
          await observationTypesRepository
              .getObservationTypeById(event.observationTypeId);
      emit(
        state.copyWith(
          selectedObservationType: selectedObservationType,
          observationTypeSelectedStatus: EntityStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        selectedObservationType: null,
        observationTypeSelectedStatus: EntityStatus.failure,
      ));
    }
  }

  // delete observation type
  Future<void> _onObservationTypeDeleted(
    ObservationTypeDeleted event,
    Emitter<ObservationTypesState> emit,
  ) async {
    emit(state.copyWith(
      observationTypeCrudStatus: EntityStatus.loading,
    ));
    try {
      EntityResponse response = await observationTypesRepository
          .deleteObservationType(event.observationTypeId);
      if (response.isSuccess) {
        emit(state.copyWith(
          observationTypeCrudStatus: EntityStatus.success,
          selectedObservationType: null,
          message: response.message,
        ));
      } else {
        emit(state.copyWith(
          observationTypeCrudStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        observationTypeCrudStatus: EntityStatus.failure,
        message: deleteErrorMessage,
      ));
    }
  }

  // init status of bloc
  void _onObservationTypesStatusInited(
      ObservationTypesStatusInited event, Emitter<ObservationTypesState> emit) {
    emit(
      state.copyWith(
        observationTypeSelectedStatus: EntityStatus.initial,
        observationTypesLoadedStatus: EntityStatus.initial,
        observationTypeCrudStatus: EntityStatus.initial,
      ),
    );
  }
}
