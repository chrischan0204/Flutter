part of 'users_bloc.dart';

class UsersState extends Equatable {
  final List<User> users;
  final EntityStatus usersRetrievedStatus;
  final List<AuditTrail> auditTrails;
  final User? selectedUser;
  final EntityStatus userSelectedStatus;
  final EntityStatus userCrudStatus;
  final String filterText;
  final String filterSiteId;
  final String message;
  const UsersState({
    this.users = const [],
    this.auditTrails = const [],
    this.selectedUser,
    this.usersRetrievedStatus = EntityStatus.initial,
    this.userCrudStatus = EntityStatus.initial,
    this.userSelectedStatus = EntityStatus.initial,
    this.filterText = '',
    this.filterSiteId = '',
    this.message = '',
  });

  @override
  List<Object?> get props => [
        users,
        auditTrails,
        selectedUser,
        usersRetrievedStatus,
        userCrudStatus,
        userSelectedStatus,
        message,
        filterText,
        filterSiteId,
      ];

  UsersState copyWith({
    List<User>? users,
    User? selectedUser,
    EntityStatus? usersRetrievedStatus,
    EntityStatus? userSelectedStatus,
    EntityStatus? userCrudStatus,
    String? message,
    String? filterText,
    String? filterSiteId,
  }) {
    return UsersState(
      users: users ?? this.users,
      selectedUser: selectedUser ?? this.selectedUser,
      usersRetrievedStatus:
          usersRetrievedStatus ?? this.usersRetrievedStatus,
      userSelectedStatus:
          userSelectedStatus ?? this.userSelectedStatus,
      userCrudStatus: userCrudStatus ?? this.userCrudStatus,
      message: message ?? this.message,
      filterText: filterText ?? this.filterText,
      filterSiteId: filterSiteId ?? this.filterSiteId,
    );
  }
}
