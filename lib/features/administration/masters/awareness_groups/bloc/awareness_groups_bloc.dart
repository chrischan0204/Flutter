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
  AwarenessGroupsBloc({
    required this.awarenessGroupsRepository,
  }) : super(const AwarenessGroupsState()) {
    on<AwarenessGroupsRetrieved>(_onAwarenessGroupsRetrieved);
    on<AwarenessGroupSelected>(_onAwarenessGroupSelected);
    on<AwarenessGroupSelectedById>(_onAwarenessGroupSelectedById);
    on<AwarenessGroupAdded>(_onAwarenessGroupAdded);
    on<AwarenessGroupEdited>(_onAwarenessGroupEdited);
    on<AwarenessGroupDeleted>(_onAwarenessGroupDeleted);
    on<AwarenessGroupsStatusInited>(_onAwarenessGroupsStatusInited);
  }

  void _onAwarenessGroupsRetrieved(AwarenessGroupsRetrieved event,
      Emitter<AwarenessGroupsState> emit) async {
    emit(state.copyWith(awarenessGroupsRetrievedStatus: EntityStatus.loading));
    try {
      List<AwarenessGroup> awarenessGroups =
          await awarenessGroupsRepository.getAwarenessGroups();
      emit(state.copyWith(
          awarenessGroupsRetrievedStatus: EntityStatus.succuess,
          awarenessGroups: awarenessGroups));
    } catch (e) {
      emit(
          state.copyWith(awarenessGroupsRetrievedStatus: EntityStatus.failure));
    }
  }

  Future<void> _onAwarenessGroupSelected(
    AwarenessGroupSelected event,
    Emitter<AwarenessGroupsState> emit,
  ) async {
    emit(state.copyWith(
      awarenessGroupSelectedStatus: EntityStatus.succuess,
      selectedAwarenessGroup: event.awarenessGroup,
    ));
  }

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
          awarenessGroupSelectedStatus: EntityStatus.succuess,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        selectedAwarenessGroup: null,
        awarenessGroupSelectedStatus: EntityStatus.failure,
      ));
    }
  }

  Future<void> _onAwarenessGroupAdded(
    AwarenessGroupAdded event,
    Emitter<AwarenessGroupsState> emit,
  ) async {
    emit(state.copyWith(
      awarenessGroupAddedStatus: EntityStatus.loading,
    ));
    try {
      EntityResponse response = await awarenessGroupsRepository
          .addAwarenessGroup(event.awarenessGroup);
      if (response.isSuccess) {
        emit(state.copyWith(
          awarenessGroupAddedStatus: EntityStatus.succuess,
        ));
      } else {
        emit(state.copyWith(
          awarenessGroupAddedStatus: EntityStatus.failure,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        awarenessGroupAddedStatus: EntityStatus.failure,
      ));
    }
  }

  Future<void> _onAwarenessGroupEdited(
    AwarenessGroupEdited event,
    Emitter<AwarenessGroupsState> emit,
  ) async {
    emit(state.copyWith(
      awarenessGroupEditedStatus: EntityStatus.loading,
    ));
    try {
      EntityResponse response = await awarenessGroupsRepository
          .editAwarenessGroup(event.awarenessGroup);
      if (response.isSuccess) {
        emit(state.copyWith(
          awarenessGroupEditedStatus: EntityStatus.succuess,
          selectedAwarenessGroup: null,
        ));
      } else {
        emit(state.copyWith(
          awarenessGroupEditedStatus: EntityStatus.failure,
          selectedAwarenessGroup: null,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        awarenessGroupEditedStatus: EntityStatus.failure,
        selectedAwarenessGroup: null,
      ));
    }
  }

  Future<void> _onAwarenessGroupDeleted(
    AwarenessGroupDeleted event,
    Emitter<AwarenessGroupsState> emit,
  ) async {
    emit(state.copyWith(
      awarenessGroupDeletedStatus: EntityStatus.loading,
    ));
    try {
      EntityResponse response = await awarenessGroupsRepository
          .deleteAwarenessGroup(event.awarenessGroupId);
      if (response.isSuccess) {
        emit(state.copyWith(
          awarenessGroupDeletedStatus: EntityStatus.succuess,
          selectedAwarenessGroup: null,
        ));
      } else {
        emit(state.copyWith(
            awarenessGroupDeletedStatus: EntityStatus.failure,
            selectedAwarenessGroup: null));
      }
    } catch (e) {
      emit(state.copyWith(
        awarenessGroupDeletedStatus: EntityStatus.failure,
        selectedAwarenessGroup: null,
      ));
    }
  }

  void _onAwarenessGroupsStatusInited(
      AwarenessGroupsStatusInited event, Emitter<AwarenessGroupsState> emit) {
    emit(
      state.copyWith(
        awarenessGroupAddedStatus: EntityStatus.initial,
        awarenessGroupEditedStatus: EntityStatus.initial,
        awarenessGroupSelectedStatus: EntityStatus.initial,
        awarenessGroupDeletedStatus: EntityStatus.initial,
        awarenessGroupsRetrievedStatus: EntityStatus.initial,
      ),
    );
  }
}
