// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  final String message;
  const UsersState({
    this.message = '',
  });

  @override
  List<Object?> get props => [message];
}

class UserInitial extends UsersState {}

class UserAddInProgress extends UsersState {}

class UserAddSuccess extends UsersState {
  final User? addedUser;
  const UserAddSuccess({
    this.addedUser,
    super.message,
  });
  @override
  List<Object?> get props => [addedUser];
}

class UserAddFailure extends UsersState {
  const UserAddFailure({super.message});
}

class UserEditInProgress extends UsersState {}

class UserEditSuccess extends UsersState {
  final User? editedUser;
  const UserEditSuccess({
    this.editedUser,
    super.message,
  });
  @override
  List<Object?> get props => [
        editedUser,
        message,
      ];
}

class UserEditFailure extends UsersState {
  const UserEditFailure({super.message});
}

class UserDeleteInProgress extends UsersState {}

class UserDeleteSuccess extends UsersState {
  const UserDeleteSuccess({super.message});
}

class UserDeleteFailure extends UsersState {
  const UserDeleteFailure({super.message});
}

class UserLoadByIdInProgress extends UsersState {}

class UserLoadByIdSuccess extends UsersState {
  final User user;
  const UserLoadByIdSuccess({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class UserLoadByIdFailure extends UsersState {}

class UserListLoadInProgress extends UsersState {}

class UserListLoadSuccess extends UsersState {
  final List<User> users;
  const UserListLoadSuccess({
    required this.users,
  });

  @override
  List<Object?> get props => [users];
}

class UserListLoadFailure extends UsersState {}



// class UsersState extends Equatable {
//   final List<User> users;
//   final EntityStatus usersRetrievedStatus;
//   final List<AuditTrail> auditTrails;
//   final User? selectedUser;
//   final EntityStatus userSelectedStatus;
//   final EntityStatus userCrudStatus;
//   final String filterText;
//   final String filterSiteId;
//   final String message;
//   const UsersState({
//     this.users = const [],
//     this.auditTrails = const [],
//     this.selectedUser,
//     this.usersRetrievedStatus = EntityStatus.initial,
//     this.userCrudStatus = EntityStatus.initial,
//     this.userSelectedStatus = EntityStatus.initial,
//     this.filterText = '',
//     this.filterSiteId = '',
//     this.message = '',
//   });

//   @override
//   List<Object?> get props => [
//         users,
//         auditTrails,
//         selectedUser,
//         usersRetrievedStatus,
//         userCrudStatus,
//         userSelectedStatus,
//         message,
//         filterText,
//         filterSiteId,
//       ];

//   UsersState copyWith({
//     List<User>? users,
//     User? selectedUser,
//     EntityStatus? usersRetrievedStatus,
//     EntityStatus? userSelectedStatus,
//     EntityStatus? userCrudStatus,
//     String? message,
//     String? filterText,
//     String? filterSiteId,
//   }) {
//     return UsersState(
//       users: users ?? this.users,
//       selectedUser: selectedUser ?? this.selectedUser,
//       usersRetrievedStatus:
//           usersRetrievedStatus ?? this.usersRetrievedStatus,
//       userSelectedStatus:
//           userSelectedStatus ?? this.userSelectedStatus,
//       userCrudStatus: userCrudStatus ?? this.userCrudStatus,
//       message: message ?? this.message,
//       filterText: filterText ?? this.filterText,
//       filterSiteId: filterSiteId ?? this.filterSiteId,
//     );
//   }
// }
