import '/common_libraries.dart';

part 'priority_levels_event.dart';
part 'priority_levels_state.dart';

class PriorityLevelsBloc
    extends Bloc<PriorityLevelsEvent, PriorityLevelsState> {
  final PriorityLevelsRepository priorityLevelsRepository;

  static String deleteErrorMessage = ErrorMessage('priority level').delete;
  PriorityLevelsBloc({
    required this.priorityLevelsRepository,
  }) : super(const PriorityLevelsState()) {
    _triggerEvents();
  }

  void _triggerEvents() {
    on<PriorityLevelsRetrieved>(_onPriorityLevelsRetrieved);
    on<PriorityLevelSelected>(_onPriorityLevelSelected);
    on<PriorityLevelSelectedById>(_onPriorityLevelSelectedById);
    on<PriorityLevelDeleted>(_onPriorityLevelDeleted);
    on<PriorityLevelsStatusInited>(_onPriorityLevelsStatusInited);
  }

  void _onPriorityLevelsRetrieved(
      PriorityLevelsRetrieved event, Emitter<PriorityLevelsState> emit) async {
    emit(state.copyWith(priorityLevelsRetrievedStatus: EntityStatus.loading));
    try {
      List<PriorityLevel> priorityLevels =
          await priorityLevelsRepository.getPriorityLevelList();
      emit(state.copyWith(
        priorityLevels: priorityLevels,
        priorityLevelsRetrievedStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(priorityLevelsRetrievedStatus: EntityStatus.failure));
    }
  }

  Future<void> _onPriorityLevelSelected(
    PriorityLevelSelected event,
    Emitter<PriorityLevelsState> emit,
  ) async {
    emit(state.copyWith(
      priorityLevelSelectedStatus: EntityStatus.success,
      selectedPriorityLevel: event.priorityLevel,
    ));
  }

  Future<void> _onPriorityLevelSelectedById(
    PriorityLevelSelectedById event,
    Emitter<PriorityLevelsState> emit,
  ) async {
    emit(state.copyWith(
      priorityLevelSelectedStatus: EntityStatus.loading,
      selectedPriorityLevel: null,
    ));
    try {
      PriorityLevel? selectedPriorityLevel = await priorityLevelsRepository
          .getPriorityLevelById(event.priorityLevelId);
      emit(
        state.copyWith(
          selectedPriorityLevel: selectedPriorityLevel,
          priorityLevelSelectedStatus: EntityStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        selectedPriorityLevel: null,
        priorityLevelSelectedStatus: EntityStatus.failure,
      ));
    }
  }

  Future<void> _onPriorityLevelDeleted(
    PriorityLevelDeleted event,
    Emitter<PriorityLevelsState> emit,
  ) async {
    emit(state.copyWith(
      priorityLevelCrudStatus: EntityStatus.loading,
    ));
    try {
      EntityResponse response = await priorityLevelsRepository
          .deletePriorityLevel(event.priorityLevelId);
      if (response.isSuccess) {
        emit(state.copyWith(
          priorityLevelCrudStatus: EntityStatus.success,
          selectedPriorityLevel: null,
          message: response.message,
        ));
      } else {
        emit(state.copyWith(
          priorityLevelCrudStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        priorityLevelCrudStatus: EntityStatus.failure,
        message: deleteErrorMessage,
      ));
    }
  }

  void _onPriorityLevelsStatusInited(
      PriorityLevelsStatusInited event, Emitter<PriorityLevelsState> emit) {
    emit(
      state.copyWith(
        priorityLevelCrudStatus: EntityStatus.initial,
        priorityLevelSelectedStatus: EntityStatus.initial,
        priorityLevelsRetrievedStatus: EntityStatus.initial,
      ),
    );
  }
}
