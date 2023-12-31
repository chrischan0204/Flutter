import '/common_libraries.dart';

part 'awareness_groups_event.dart';
part 'awareness_groups_state.dart';

class AwarenessGroupsBloc
    extends Bloc<AwarenessGroupsEvent, AwarenessGroupsState> {
  final AwarenessGroupsRepository awarenessGroupsRepository;

  static String deleteErrorMessage = ErrorMessage('awareness group').delete;

  AwarenessGroupsBloc({
    required this.awarenessGroupsRepository,
  }) : super(const AwarenessGroupsState()) {
    _triggerEvents();
  }

  void _triggerEvents() {
    on<AwarenessGroupsLoaded>(_onAwarenessGroupsLoaded);
    on<AwarenessGroupSelected>(_onAwarenessGroupSelected);
    on<AwarenessGroupSelectedById>(_onAwarenessGroupSelectedById);
    on<AwarenessGroupDeleted>(_onAwarenessGroupDeleted);
    on<AwarenessGroupsStatusInited>(_onAwarenessGroupsStatusInited);
  }

  // get awareness groups list
  void _onAwarenessGroupsLoaded(
      AwarenessGroupsLoaded event, Emitter<AwarenessGroupsState> emit) async {
    emit(state.copyWith(awarenessGroupsLoadedStatus: EntityStatus.loading));
    try {
      List<AwarenessGroup> awarenessGroups =
          await awarenessGroupsRepository.getAwarenessGroups();
      emit(state.copyWith(
        awarenessGroupsLoadedStatus: EntityStatus.success,
        awarenessGroups: awarenessGroups,
      ));
    } catch (e) {
      emit(state.copyWith(awarenessGroupsLoadedStatus: EntityStatus.failure));
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
        awarenessGroupsLoadedStatus: EntityStatus.initial,
      ),
    );
  }
}
