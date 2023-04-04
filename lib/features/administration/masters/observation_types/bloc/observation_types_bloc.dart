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
    on<ObservationTypeSelectedById>(_onObservationTypeSelectedById);
    on<ObservationTypeAdded>(_onObservationTypeAdded);
    on<ObservationTypeEdited>(_onObservationTypeEdited);
    on<ObservationTypeDeleted>(_onObservationTypeDeleted);
    on<ObservationTypesStatusInited>(_onObservationTypesStatusInited);
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
        observationTypesRetrievedStatus: EntityStatus.success,
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
      observationTypeSelectedStatus: EntityStatus.success,
      selectedObservationType: event.observationType,
    ));
  }

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

  Future<void> _onObservationTypeAdded(
    ObservationTypeAdded event,
    Emitter<ObservationTypesState> emit,
  ) async {
    emit(state.copyWith(
      observationTypeCrudStatus: EntityStatus.loading,
    ));
    try {
      EntityResponse response = await observationTypesRepository
          .addObservationType(event.observationType);
      if (response.isSuccess) {
        emit(state.copyWith(
          observationTypeCrudStatus: EntityStatus.success,
          message: response.message,
          selectedObservationType: null,
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
        message:
            'There was an error while adding observation type. Our team has been notified. Please wait a few minutes and try again.',
      ));
    }
  }

  Future<void> _onObservationTypeEdited(
    ObservationTypeEdited event,
    Emitter<ObservationTypesState> emit,
  ) async {
    emit(state.copyWith(
      observationTypeCrudStatus: EntityStatus.loading,
    ));
    try {
      EntityResponse response = await observationTypesRepository
          .editObservationType(event.observationType);
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
        message:
            'There was an error while editing observation type. Our team has been notified. Please wait a few minutes and try again.',
      ));
    }
  }

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
        message:
            'There was an error while deleting observation type. Our team has been notified. Please wait a few minutes and try again.',
      ));
    }
  }

  void _onObservationTypesStatusInited(
      ObservationTypesStatusInited event, Emitter<ObservationTypesState> emit) {
    emit(
      state.copyWith(
        observationTypeSelectedStatus: EntityStatus.initial,
        observationTypesRetrievedStatus: EntityStatus.initial,
        observationTypeCrudStatus: EntityStatus.initial,
        
      ),
    );
  }
}
