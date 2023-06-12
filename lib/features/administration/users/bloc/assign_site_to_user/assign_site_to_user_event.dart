part of 'assign_site_to_user_bloc.dart';

abstract class AssignSiteToUserEvent extends Equatable {
  const AssignSiteToUserEvent();

  @override
  List<Object?> get props => [];
}

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
