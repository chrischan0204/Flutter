// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_detail_bloc.dart';

class UserDetailState extends Equatable {
  final User? user;
  final EntityStatus userLoadStatus;
  final List<UserSite> userSiteAssignmentList;
  final EntityStatus userSiteAssignmentListLoadStatus;
  final List<UserSiteNotification> userSiteNotificationList;
  final EntityStatus userSiteNotificationListLoadStatus;
  final EntityStatus userDeleteStatus;
  final String message;
  const UserDetailState({
    this.user,
    this.userLoadStatus = EntityStatus.initial,
    this.userSiteAssignmentList = const [],
    this.userSiteAssignmentListLoadStatus = EntityStatus.initial,
    this.userSiteNotificationList = const [],
    this.userSiteNotificationListLoadStatus = EntityStatus.initial,
    this.userDeleteStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        user,
        userLoadStatus,
        userSiteAssignmentList,
        userSiteAssignmentListLoadStatus,
        userSiteNotificationList,
        userSiteNotificationListLoadStatus,
        userDeleteStatus,
        message,
      ];

  bool get deletable =>
      userSiteAssignmentList.isEmpty && userSiteNotificationList.isEmpty;

  UserDetailState copyWith({
    User? user,
    EntityStatus? userLoadStatus,
    List<UserSite>? userSiteAssignmentList,
    EntityStatus? userSiteAssignmentListLoadStatus,
    List<UserSiteNotification>? userSiteNotificationList,
    EntityStatus? userSiteNotificationListLoadStatus,
    EntityStatus? userDeleteStatus,
    String? message,
  }) {
    return UserDetailState(
      user: user ?? this.user,
      userLoadStatus: userLoadStatus ?? this.userLoadStatus,
      userSiteAssignmentList:
          userSiteAssignmentList ?? this.userSiteAssignmentList,
      userSiteAssignmentListLoadStatus: userSiteAssignmentListLoadStatus ??
          this.userSiteAssignmentListLoadStatus,
      userSiteNotificationList:
          userSiteNotificationList ?? this.userSiteNotificationList,
      userSiteNotificationListLoadStatus: userSiteNotificationListLoadStatus ??
          this.userSiteNotificationListLoadStatus,
      userDeleteStatus: userDeleteStatus ?? this.userDeleteStatus,
      message: message ?? this.message,
    );
  }
}
