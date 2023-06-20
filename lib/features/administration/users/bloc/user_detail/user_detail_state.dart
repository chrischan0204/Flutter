part of 'user_detail_bloc.dart';

class UserDetailState extends Equatable {
  final User? user;
  final EntityStatus userLoadStatus;
  final EntityStatus userDeleteStatus;
  final String message;
  const UserDetailState({
    this.user,
    this.userLoadStatus = EntityStatus.initial,
    this.userDeleteStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        user,
        userLoadStatus,
        userDeleteStatus,
        message,
      ];

  UserDetailState copyWith({
    User? user,
    EntityStatus? userLoadStatus,
    EntityStatus? userDeleteStatus,
    String? message,
  }) {
    return UserDetailState(
      user: user ?? this.user,
      userLoadStatus: userLoadStatus ?? this.userLoadStatus,
      userDeleteStatus: userDeleteStatus ?? this.userDeleteStatus,
      message: message ?? this.message,
    );
  }
}
