part of 'user_invite_bloc.dart';

class UserInviteState extends Equatable {
  final String inviteSent;
  final String inviteSentOn;

  final String registrationLinkClick;
  final String appDownloadLinkClick;

  final EntityStatus appDownloadLinkClickStatus;
  final EntityStatus registrationLinkClickStatus;

  final EntityStatus inviteSentStatus;

  // final List<UserInviteDetail> userInviteDetailList;
  final EntityStatus userInviteDetailListLoadStatus;

  final String message;
  const UserInviteState({
    this.inviteSent = '',
    this.inviteSentOn = '',
    this.registrationLinkClick = '',
    this.appDownloadLinkClick = '',
    this.appDownloadLinkClickStatus = EntityStatus.initial,
    this.registrationLinkClickStatus = EntityStatus.initial,
    this.inviteSentStatus = EntityStatus.initial,
    // this.userInviteDetailList = const [],
    this.userInviteDetailListLoadStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object> get props => [
        inviteSent,
        inviteSentOn,
        registrationLinkClick,
        appDownloadLinkClick,
        appDownloadLinkClickStatus,
        registrationLinkClickStatus,
        // userInviteDetailList,
        userInviteDetailListLoadStatus,
        inviteSentStatus,
        message,
      ];

  UserInviteState copyWith({
    String? inviteSent,
    String? inviteSentOn,
    String? registrationLinkClick,
    String? appDownloadLinkClick,
    EntityStatus? appDownloadLinkClickStatus,
    EntityStatus? registrationLinkClickStatus,
    EntityStatus? inviteSentStatus,
    EntityStatus? userInviteDetailListLoadStatus,
    String? message,
  }) {
    return UserInviteState(
      inviteSent: inviteSent ?? this.inviteSent,
      inviteSentOn: inviteSentOn ?? this.inviteSentOn,
      registrationLinkClick:
          registrationLinkClick ?? this.registrationLinkClick,
      appDownloadLinkClick: appDownloadLinkClick ?? this.appDownloadLinkClick,
      appDownloadLinkClickStatus:
          appDownloadLinkClickStatus ?? this.appDownloadLinkClickStatus,
      registrationLinkClickStatus:
          registrationLinkClickStatus ?? this.registrationLinkClickStatus,
      inviteSentStatus: inviteSentStatus ?? this.inviteSentStatus,
      userInviteDetailListLoadStatus:
          userInviteDetailListLoadStatus ?? this.userInviteDetailListLoadStatus,
      message: message ?? this.message,
    );
  }
}
