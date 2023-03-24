import '/data/model/entity.dart';
import '/data/repository/repository.dart';
import '/features/administration/masters/priority_levels/data/model/priority_level.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'priority_levels_event.dart';
part 'priority_levels_state.dart';

class PriorityLevelsBloc
    extends Bloc<PriorityLevelsEvent, PriorityLevelsState> {
  final PriorityLevelsRepository priorityLevelsRepository;
  PriorityLevelsBloc({
    required this.priorityLevelsRepository,
  }) : super(const PriorityLevelsState()) {
    on<PriorityLevelsRetrieved>(_onPriorityLevelsRetrieved);
    on<PriorityLevelSelected>(_onPriorityLevelSelected);
    on<PriorityLevelSelectedById>(_onPriorityLevelSelectedById);
    on<PriorityLevelAdded>(_onPriorityLevelAdded);
    on<PriorityLevelEdited>(_onPriorityLevelEdited);
    on<PriorityLevelDeleted>(_onPriorityLevelDeleted);
    on<PriorityLevelsStatusInited>(_onPriorityLevelsStatusInited);
  }

  void _onPriorityLevelsRetrieved(
      PriorityLevelsRetrieved event, Emitter<PriorityLevelsState> emit) async {
    emit(state.copyWith(priorityLevelsRetrievedStatus: EntityStatus.loading));
    try {
      List<PriorityLevel> priorityLevels =
          await priorityLevelsRepository.getPriorityLevels();
      emit(state.copyWith(
        priorityLevels: priorityLevels,
        priorityLevelsRetrievedStatus: EntityStatus.succuess,
      ));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(priorityLevelsRetrievedStatus: EntityStatus.failure));
    }
  }

  Future<void> _onPriorityLevelSelected(
    PriorityLevelSelected event,
    Emitter<PriorityLevelsState> emit,
  ) async {
    emit(state.copyWith(
      priorityLevelSelectedStatus: EntityStatus.succuess,
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
          priorityLevelSelectedStatus: EntityStatus.succuess,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        selectedPriorityLevel: null,
        priorityLevelSelectedStatus: EntityStatus.failure,
      ));
    }
  }

  Future<void> _onPriorityLevelAdded(
    PriorityLevelAdded event,
    Emitter<PriorityLevelsState> emit,
  ) async {
    emit(state.copyWith(
      priorityLevelAddedStatus: EntityStatus.loading,
    ));
    try {
      EntityResponse response =
          await priorityLevelsRepository.addPriorityLevel(event.priorityLevel);
      if (response.isSuccess) {
        emit(state.copyWith(
          priorityLevelAddedStatus: EntityStatus.succuess,
        ));
      } else {
        emit(state.copyWith(
          priorityLevelAddedStatus: EntityStatus.failure,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        priorityLevelAddedStatus: EntityStatus.failure,
      ));
    }
  }

  Future<void> _onPriorityLevelEdited(
    PriorityLevelEdited event,
    Emitter<PriorityLevelsState> emit,
  ) async {
    emit(state.copyWith(
      priorityLevelEditedStatus: EntityStatus.loading,
    ));
    try {
      EntityResponse response =
          await priorityLevelsRepository.editPriorityLevel(event.priorityLevel);
      if (response.isSuccess) {
        emit(state.copyWith(
          priorityLevelEditedStatus: EntityStatus.succuess,
          selectedPriorityLevel: null,
        ));
      } else {
        emit(state.copyWith(
          priorityLevelEditedStatus: EntityStatus.failure,
          selectedPriorityLevel: null,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        priorityLevelEditedStatus: EntityStatus.failure,
        selectedPriorityLevel: null,
      ));
    }
  }

  Future<void> _onPriorityLevelDeleted(
    PriorityLevelDeleted event,
    Emitter<PriorityLevelsState> emit,
  ) async {
    emit(state.copyWith(
      priorityLevelDeletedStatus: EntityStatus.loading,
    ));
    try {
      EntityResponse response = await priorityLevelsRepository
          .deletePriorityLevel(event.priorityLevelId);
      if (response.isSuccess) {
        emit(state.copyWith(
          priorityLevelDeletedStatus: EntityStatus.succuess,
          selectedPriorityLevel: null,
        ));
      } else {
        emit(state.copyWith(
            priorityLevelDeletedStatus: EntityStatus.failure,
            selectedPriorityLevel: null));
      }
    } catch (e) {
      emit(state.copyWith(
        priorityLevelDeletedStatus: EntityStatus.failure,
        selectedPriorityLevel: null,
      ));
    }
  }

  void _onPriorityLevelsStatusInited(
      PriorityLevelsStatusInited event, Emitter<PriorityLevelsState> emit) {
    emit(
      state.copyWith(
        priorityLevelAddedStatus: EntityStatus.initial,
        priorityLevelEditedStatus: EntityStatus.initial,
        priorityLevelSelectedStatus: EntityStatus.initial,
        priorityLevelDeletedStatus: EntityStatus.initial,
        priorityLevelsRetrievedStatus: EntityStatus.initial,
      ),
    );
  }
}
