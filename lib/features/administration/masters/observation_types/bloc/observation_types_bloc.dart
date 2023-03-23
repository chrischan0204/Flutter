import '/data/model/entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/data/repository/repository.dart';
import '../data/model/observation_type.dart';

part 'observation_types_event.dart';
part 'observation_types_state.dart';

class ObservationTypesBloc
    extends Bloc<ObservationTypesEvent, ObservationTypesState> {
  final ObservationTypesRepository observationTypesRepository;
  ObservationTypesBloc({
    required this.observationTypesRepository,
  }) : super(const ObservationTypesState()) {
    on<ObservationTypesRetrieved>(_onObservationTypesRetrieved);
    on<ObservationTypeSelected>(_onObservationTypeSelected);
    on<ObservationTypeAdded>(_onObservationTypeAdded);
    on<ObservationTypeEdited>(_onObservationTypeEdited);
    on<ObservationTypeDeleted>(_onObservationTypeDeleted);
  }

  Future<void> _onObservationTypesRetrieved(
    ObservationTypesRetrieved event,
    Emitter<ObservationTypesState> emit,
  ) async {
    emit(state.copyWith(
      observationTypesRetrievedStatus: EntityStatus.loading,
    ));
    try {
      List<ObservationType> observationTypes =
          await observationTypesRepository.getObservationTypes();
      emit(state.copyWith(
        observationTypes: observationTypes,
        observationTypesRetrievedStatus: EntityStatus.succuess,
      ));
    } catch (e) {
      emit(state.copyWith(
        observationTypesRetrievedStatus: EntityStatus.failure,
      ));
    }
  }

  Future<void> _onObservationTypeSelected(
    ObservationTypeSelected event,
    Emitter<ObservationTypesState> emit,
  ) async {
    emit(state.copyWith(
      observationTypeSelectedStatus: EntityStatus.loading,
    ));
    try {
      ObservationType? selectedObservationType =
          await observationTypesRepository
              .getObervationTypeById(event.observationTypeId);
      emit(
        state.copyWith(
          selectedObservationType: selectedObservationType,
          observationTypeSelectedStatus: EntityStatus.succuess,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        selectedObservationType: null,
        observationTypeSelectedStatus: EntityStatus.failure,
      ));
    }
  }

  Future<void> _onObservationTypeAdded(
    ObservationTypeAdded event,
    Emitter<ObservationTypesState> emit,
  ) async {
    emit(state.copyWith(
      observationTypeAddedStatus: EntityStatus.loading,
    ));
    try {
      EntityResponse response = await observationTypesRepository
          .addObservationType(event.observationType);
      if (response.isSuccess) {
        emit(state.copyWith(
          observationTypeAddedStatus: EntityStatus.succuess,
        ));
      } else {
        emit(state.copyWith(
          observationTypeAddedStatus: EntityStatus.failure,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        observationTypeAddedStatus: EntityStatus.failure,
      ));
    }
  }

  Future<void> _onObservationTypeEdited(
    ObservationTypeEdited event,
    Emitter<ObservationTypesState> emit,
  ) async {
    emit(state.copyWith(
      observationTypeEditedStatus: EntityStatus.loading,
    ));
    try {
      EntityResponse response = await observationTypesRepository
          .addObservationType(event.observationType);
      if (response.isSuccess) {
        emit(state.copyWith(
          observationTypeEditedStatus: EntityStatus.succuess,
        ));
      } else {
        emit(state.copyWith(
          observationTypeEditedStatus: EntityStatus.failure,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        observationTypeEditedStatus: EntityStatus.failure,
      ));
    }
  }

  Future<void> _onObservationTypeDeleted(
    ObservationTypeDeleted event,
    Emitter<ObservationTypesState> emit,
  ) async {
    emit(state.copyWith(
      observationTypeDeletedStatus: EntityStatus.loading,
    ));
    try {
      EntityResponse response = await observationTypesRepository
          .deleteObservationType(event.observationTypeId);
      if (response.isSuccess) {
        emit(state.copyWith(
          observationTypeDeletedStatus: EntityStatus.succuess,
        ));
      } else {
        emit(state.copyWith(
          observationTypeDeletedStatus: EntityStatus.failure,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        observationTypeDeletedStatus: EntityStatus.failure,
      ));
    }
  }
}
