part of 'assign_site_to_user_bloc.dart';

abstract class AssignSiteToUserEvent extends Equatable {
  const AssignSiteToUserEvent();

  @override
  List<Object?> get props => [];
}

/// event to load assigned site list to user
class AssignSiteToUserAssignedUserSiteListLoaded extends AssignSiteToUserEvent {
  final String userId;
  final String? name;
  const AssignSiteToUserAssignedUserSiteListLoaded({
    required this.userId,
    this.name,
  });

  @override
  List<Object?> get props => [userId];
}

/// event to load unassigned site list to user
class AssignSiteToUserUnassignedUserSiteListLoaded
    extends AssignSiteToUserEvent {
  final String userId;
  final String? name;
  const AssignSiteToUserUnassignedUserSiteListLoaded({
    required this.userId,
    this.name,
  });

  @override
  List<Object?> get props => [
        userId,
        name,
      ];
}

/// event to assign site to user
class AssignSiteToUserSiteAssigned extends AssignSiteToUserEvent {
  final UserSiteAssignment userSiteAssignment;
  const AssignSiteToUserSiteAssigned({
    required this.userSiteAssignment,
  });

  @override
  List<Object?> get props => [userSiteAssignment];
}


class AssignSiteToUserSiteUnassigned extends AssignSiteToUserEvent {
  final String userSiteAssignmentId;
  const AssignSiteToUserSiteUnassigned({
    required this.userSiteAssignmentId,
  });

  @override
  List<Object?> get props => [userSiteAssignmentId];
}

class AssignSiteToUserFilterTextForUnassignedChanged
    extends AssignSiteToUserEvent {
  final String filterText;
  const AssignSiteToUserFilterTextForUnassignedChanged(
      {required this.filterText});

  @override
  List<Object?> get props => [filterText];
}

class AssignSiteToUserFilterTextForAssignedChanged
    extends AssignSiteToUserEvent {
  final String filterText;
  const AssignSiteToUserFilterTextForAssignedChanged(
      {required this.filterText});

  @override
  List<Object?> get props => [filterText];
}
