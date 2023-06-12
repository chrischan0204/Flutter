import '/common_libraries.dart';

part 'assign_site_to_user_event.dart';
part 'assign_site_to_user_state.dart';

class AssignSiteToUserBloc
    extends Bloc<AssignSiteToUserEvent, AssignSiteToUserState> {
  final UsersRepository usersRepository;
  AssignSiteToUserBloc({required this.usersRepository})
      : super(const AssignSiteToUserState()) {
    on<AssignSiteToUserAssignedUserSiteListLoaded>(
        _onAssignSiteToUserAssignedUserSiteListLoaded);
    on<AssignSiteToUserUnassignedUserSiteListLoaded>(
        _onAssignSiteToUserUnassignedUserSiteListLoaded);
    on<AssignSiteToUserSiteAssigned>(_onAssignSiteToUserSiteAssigned);
    on<AssignSiteToUserSiteUnassigned>(_onAssignSiteToUserSiteUnassigned);
    on<AssignSiteToUserFilterTextForUnassignedChanged>(
        _onAssignSiteToUserFilterTextForUnassignedChanged);
    on<AssignSiteToUserFilterTextForAssignedChanged>(
        _onAssignSiteToUserFilterTextForAssignedChanged);
  }

  Future<void> _onAssignSiteToUserAssignedUserSiteListLoaded(
    AssignSiteToUserAssignedUserSiteListLoaded event,
    Emitter<AssignSiteToUserState> emit,
  ) async {
    emit(state.copyWith(assignedUserSiteListLoadStatus: EntityStatus.loading));
    try {
      List<UserSite> assignedUserSiteList = await usersRepository
          .getUserSitesByUserId(event.userId, assigned: true, name: event.name);
      emit(state.copyWith(
        assignedUserSiteList: assignedUserSiteList,
        assignedUserSiteListLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(
          state.copyWith(assignedUserSiteListLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onAssignSiteToUserUnassignedUserSiteListLoaded(
    AssignSiteToUserUnassignedUserSiteListLoaded event,
    Emitter<AssignSiteToUserState> emit,
  ) async {
    emit(
        state.copyWith(unassignedUserSiteListLoadStatus: EntityStatus.loading));
    try {
      List<UserSite> unassignedUserSiteList =
          await usersRepository.getUserSitesByUserId(
        event.userId,
        assigned: false,
        name: event.name,
      );
      emit(state.copyWith(
        unassignedUserSiteList: unassignedUserSiteList,
        unassignedUserSiteListLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
          unassignedUserSiteListLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onAssignSiteToUserSiteAssigned(
    AssignSiteToUserSiteAssigned event,
    Emitter<AssignSiteToUserState> emit,
  ) async {
    emit(state.copyWith(assignStatus: EntityStatus.loading));

    final result = state.unassignedUserSiteList.firstWhere(
        (unassignedUserSite) =>
            unassignedUserSite.siteId == event.userSiteAssignment.siteId);

    try {
      result.isAssigned = true;
      EntityResponse response =
          await usersRepository.assignSiteToUser(event.userSiteAssignment);
      emit(state.copyWith(
        assignStatus: response.isSuccess.toEntityStatusCode(),
        message: response.message,
      ));
      if (!response.isSuccess) {
        result.isAssigned = false;
      }
    } catch (e) {
      emit(state.copyWith(assignStatus: EntityStatus.failure));
      result.isAssigned = true;
    }
  }

  Future<void> _onAssignSiteToUserSiteUnassigned(
    AssignSiteToUserSiteUnassigned event,
    Emitter<AssignSiteToUserState> emit,
  ) async {
    emit(state.copyWith(unassignStatus: EntityStatus.loading));
    final result = state.assignedUserSiteList.firstWhere((assignedUserSite) =>
        assignedUserSite.id == event.userSiteAssignmentId);
    try {
      result.isAssigned = false;
      EntityResponse response = await usersRepository
          .unassignSiteFromUser(event.userSiteAssignmentId);

      emit(state.copyWith(
        unassignStatus: response.isSuccess.toEntityStatusCode(),
        message: response.message,
      ));
      if (!response.isSuccess) {
        result.isAssigned = true;
      }
    } catch (e) {
      emit(state.copyWith(unassignStatus: EntityStatus.failure));
      result.isAssigned = true;
    }
  }

  void _onAssignSiteToUserFilterTextForUnassignedChanged(
    AssignSiteToUserFilterTextForUnassignedChanged event,
    Emitter<AssignSiteToUserState> emit,
  ) {
    emit(state.copyWith(filterTextForUnassigned: event.filterText));
  }

  void _onAssignSiteToUserFilterTextForAssignedChanged(
    AssignSiteToUserFilterTextForAssignedChanged event,
    Emitter<AssignSiteToUserState> emit,
  ) {
    emit(state.copyWith(filterTextForAssigned: event.filterText));
  }
}
