part of 'roles_bloc.dart';

class RolesState extends Equatable {
  final List<Role> roles;
  final EntityStatus rolesRetrievedStatus;
  const RolesState({
    this.roles = const [],
    this.rolesRetrievedStatus = EntityStatus.initial,
  });

  @override
  List<Object> get props => [
        roles,
        rolesRetrievedStatus,
      ];

  RolesState copyWith({
    List<Role>? roles,
    EntityStatus? rolesRetrievedStatus,
  }) {
    return RolesState(
      roles: roles ?? this.roles,
      rolesRetrievedStatus: rolesRetrievedStatus ?? this.rolesRetrievedStatus,
    );
  }
}
