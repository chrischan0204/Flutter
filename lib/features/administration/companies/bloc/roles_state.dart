part of 'roles_bloc.dart';

class RolesState extends Equatable {
  final List<Role> roles;
  final EntityStatus rolesLoadedStatus;
  const RolesState({
    this.roles = const [],
    this.rolesLoadedStatus = EntityStatus.initial,
  });

  @override
  List<Object> get props => [
        roles,
        rolesLoadedStatus,
      ];

  RolesState copyWith({
    List<Role>? roles,
    EntityStatus? rolesLoadedStatus,
  }) {
    return RolesState(
      roles: roles ?? this.roles,
      rolesLoadedStatus: rolesLoadedStatus ?? this.rolesLoadedStatus,
    );
  }
}
