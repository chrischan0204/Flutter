part of 'assign_site_to_user_bloc.dart';

class AssignSiteToUserState extends Equatable {
  final List<UserSite> assignedUserSiteList;
  final EntityStatus assignedUserSiteListLoadStatus;
  final List<UserSite> unassignedUserSiteList;
  final EntityStatus unassignedUserSiteListLoadStatus;
  final EntityStatus assignStatus;
  final EntityStatus unassignStatus;
  final String filterTextForAssigned;
  final String filterTextForUnassigned;
  final String message;
  const AssignSiteToUserState({
    this.assignedUserSiteList = const [],
    this.assignedUserSiteListLoadStatus = EntityStatus.initial,
    this.unassignedUserSiteList = const [],
    this.unassignedUserSiteListLoadStatus = EntityStatus.initial,
    this.assignStatus = EntityStatus.initial,
    this.unassignStatus = EntityStatus.initial,
    this.filterTextForAssigned = '',
    this.filterTextForUnassigned = '',
    this.message = '',
  });

  @override
  List<Object> get props => [
        assignedUserSiteList,
        assignedUserSiteListLoadStatus,
        unassignedUserSiteList,
        unassignedUserSiteListLoadStatus,
        assignStatus,
        unassignStatus,
        filterTextForAssigned,
        filterTextForUnassigned,
        message,
      ];

  AssignSiteToUserState copyWith({
    List<UserSite>? assignedUserSiteList,
    EntityStatus? assignedUserSiteListLoadStatus,
    List<UserSite>? unassignedUserSiteList,
    EntityStatus? unassignedUserSiteListLoadStatus,
    EntityStatus? assignStatus,
    EntityStatus? unassignStatus,
    String? filterTextForAssigned,
    String? filterTextForUnassigned,
    String? message,
  }) {
    return AssignSiteToUserState(
      assignedUserSiteList: assignedUserSiteList ?? this.assignedUserSiteList,
      assignedUserSiteListLoadStatus:
          assignedUserSiteListLoadStatus ?? this.assignedUserSiteListLoadStatus,
      unassignedUserSiteList:
          unassignedUserSiteList ?? this.unassignedUserSiteList,
      unassignedUserSiteListLoadStatus: unassignedUserSiteListLoadStatus ??
          this.unassignedUserSiteListLoadStatus,
      assignStatus: assignStatus ?? this.assignStatus,
      unassignStatus: unassignStatus ?? this.unassignStatus,
      filterTextForAssigned:
          filterTextForAssigned ?? this.filterTextForAssigned,
      filterTextForUnassigned:
          filterTextForUnassigned ?? this.filterTextForUnassigned,
      message: message ?? this.message,
    );
  }
}
