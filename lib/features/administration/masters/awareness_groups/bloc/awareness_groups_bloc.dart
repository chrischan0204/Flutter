import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/data/model/entity.dart';
import '../data/model/awareness_group.dart';
import '/data/repository/repository.dart';

part 'awareness_groups_event.dart';
part 'awareness_groups_state.dart';

class AwarenessGroupsBloc
    extends Bloc<AwarenessGroupsEvent, AwarenessGroupsState> {
  final AwarenessGroupsRepository awarenessGroupsRepository;

  static String addErrorMessage =
      'There was an error while adding awareness group. Our team has been notified. Please wait a few minutes and try again.';
  static String editErrorMessage =
      'There was an error while editing awareness group. Our team has been notified. Please wait a few minutes and try again.';
  static String deleteErrorMessage =
      'There was an error while deleting awareness group. Our team has been notified. Please wait a few minutes and try again.';

  AwarenessGroupsBloc({
    required this.awarenessGroupsRepository,
  }) : super(const AwarenessGroupsState()) {
    _triggerEvents();
  }

  void _triggerEvents() {
    on<AwarenessGroupsRetrieved>(_onAwarenessGroupsRetrieved);
    on<AwarenessGroupSelected>(_onAwarenessGroupSelected);
    on<AwarenessGroupSelectedById>(_onAwarenessGroupSelectedById);
    on<AwarenessGroupAdded>(_onAwarenessGroupAdded);
    on<AwarenessGroupEdited>(_onAwarenessGroupEdited);
    on<AwarenessGroupDeleted>(_onAwarenessGroupDeleted);
    on<AwarenessGroupsStatusInited>(_onAwarenessGroupsStatusInited);
  }

  // get awareness groups list
  void _onAwarenessGroupsRetrieved(AwarenessGroupsRetrieved event,
      Emitter<AwarenessGroupsState> emit) async {
    emit(state.copyWith(awarenessGroupsRetrievedStatus: EntityStatus.loading));
    try {
      List<AwarenessGroup> awarenessGroups =
          await awarenessGroupsRepository.getAwarenessGroups();
      emit(state.copyWith(
        awarenessGroupsRetrievedStatus: EntityStatus.success,
        awarenessGroups: awarenessGroups,
      ));
    } catch (e) {
      emit(
          state.copyWith(awarenessGroupsRetrievedStatus: EntityStatus.failure));
    }
  }

  // select awareness group
  Future<void> _onAwarenessGroupSelected(
    AwarenessGroupSelected event,
    Emitter<AwarenessGroupsState> emit,
  ) async {
    emit(state.copyWith(
      awarenessGroupSelectedStatus: EntityStatus.success,
      selectedAwarenessGroup: event.awarenessGroup,
    ));
  }

  // get awareness group by id
  Future<void> _onAwarenessGroupSelectedById(
    AwarenessGroupSelectedById event,
    Emitter<AwarenessGroupsState> emit,
  ) async {
    emit(state.copyWith(
      awarenessGroupSelectedStatus: EntityStatus.loading,
      selectedAwarenessGroup: null,
    ));
    try {
      AwarenessGroup? selectedAwarenessGroup = await awarenessGroupsRepository
          .getAwarenessGroupById(event.awarenessGroupId);
      emit(
        state.copyWith(
          selectedAwarenessGroup: selectedAwarenessGroup,
          awarenessGroupSelectedStatus: EntityStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        selectedAwarenessGroup: null,
        awarenessGroupSelectedStatus: EntityStatus.failure,
      ));
    }
  }

  // add awareness group
  Future<void> _onAwarenessGroupAdded(
    AwarenessGroupAdded event,
    Emitter<AwarenessGroupsState> emit,
  ) async {
    emit(state.copyWith(
      awarenessGroupCrudStatus: EntityStatus.loading,
    ));
    try {
      EntityResponse response = await awarenessGroupsRepository
          .addAwarenessGroup(event.awarenessGroup);
      if (response.isSuccess) {
        emit(state.copyWith(
          awarenessGroupCrudStatus: EntityStatus.success,
          message: response.message,
          selectedAwarenessGroup: null,
        ));
      } else {
        emit(state.copyWith(
          awarenessGroupCrudStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        awarenessGroupCrudStatus: EntityStatus.failure,
        message: addErrorMessage,
      ));
    }
  }

  // edit awareness group
  Future<void> _onAwarenessGroupEdited(
    AwarenessGroupEdited event,
    Emitter<AwarenessGroupsState> emit,
  ) async {
    emit(state.copyWith(
      awarenessGroupCrudStatus: EntityStatus.loading,
    ));
    try {
      EntityResponse response = await awarenessGroupsRepository
          .editAwarenessGroup(event.awarenessGroup);
      if (response.isSuccess) {
        emit(state.copyWith(
          awarenessGroupCrudStatus: EntityStatus.success,
          selectedAwarenessGroup: null,
          message: response.message,
        ));
      } else {
        emit(state.copyWith(
          awarenessGroupCrudStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        awarenessGroupCrudStatus: EntityStatus.failure,
        message: editErrorMessage,
      ));
    }
  }

  // delete awareness group by id
  Future<void> _onAwarenessGroupDeleted(
    AwarenessGroupDeleted event,
    Emitter<AwarenessGroupsState> emit,
  ) async {
    emit(state.copyWith(
      awarenessGroupCrudStatus: EntityStatus.loading,
    ));
    try {
      EntityResponse response = await awarenessGroupsRepository
          .deleteAwarenessGroup(event.awarenessGroupId);
      if (response.isSuccess) {
        emit(state.copyWith(
          awarenessGroupCrudStatus: EntityStatus.success,
          selectedAwarenessGroup: null,
          message: response.message,
        ));
      } else {
        emit(state.copyWith(
          awarenessGroupCrudStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        awarenessGroupCrudStatus: EntityStatus.failure,
        message: deleteErrorMessage,
      ));
    }
  }

  // init awareness group status
  void _onAwarenessGroupsStatusInited(
      AwarenessGroupsStatusInited event, Emitter<AwarenessGroupsState> emit) {
    emit(
      state.copyWith(
        awarenessGroupCrudStatus: EntityStatus.initial,
        awarenessGroupSelectedStatus: EntityStatus.initial,
        awarenessGroupsRetrievedStatus: EntityStatus.initial,
      ),
    );
  }
}
