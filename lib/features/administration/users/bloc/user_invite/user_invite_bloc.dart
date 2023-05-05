import 'package:equatable/equatable.dart';

import '/common_libraries.dart';

part 'user_invite_event.dart';
part 'user_invite_state.dart';

class UserInviteBloc extends Bloc<UserInviteEvent, UserInviteState> {
  final UsersRepository usersRepository;
  UserInviteBloc({required this.usersRepository})
      : super(const UserInviteState()) {
    on<UserInviteDetailsLoaded>(_onUserInviteDetailsLoaded);
    on<UserInviteInviteSent>(_onUserInviteInviteSent);
    on<UserInviteRegistered>(_onUserInviteRegistered);
    on<UserInviteAppDownloaded>(_onUserInviteAppDownloaded);
  }

  Future<void> _onUserInviteDetailsLoaded(
    UserInviteDetailsLoaded event,
    Emitter<UserInviteState> emit,
  ) async {
    emit(state.copyWith(userInviteDetailListLoadStatus: EntityStatus.loading));

    try {
      List<UserInviteDetail> userInviteDetailList =
          await usersRepository.getInviteDetails(event.userId);
      Map<String, String> userInviteDetailMap = {};
      for (var userInviteDetail in userInviteDetailList) {
        userInviteDetailMap.addEntries(
            [MapEntry(userInviteDetail.action, userInviteDetail.createdOn)]);
      }

      String appDownloadLink =
          userInviteDetailMap['App Download Link Clicked'] == null
              ? 'No'
              : 'Yes / ${userInviteDetailMap['App Download Link Clicked']}';
      String registrationLinkClick =
          userInviteDetailMap['Registration Link Clicked'] == null
              ? 'No'
              : 'Yes / ${userInviteDetailMap['Registration Link Clicked']}';
      String inviteSent =
          userInviteDetailMap['Invite Sent'] == null ? 'No' : 'Yes';

      emit(state.copyWith(
        userInviteDetailListLoadStatus: EntityStatus.success,
        appDownloadLinkClick: appDownloadLink,
        registrationLinkClick: registrationLinkClick,
        inviteSent: inviteSent,
        inviteSentOn: userInviteDetailMap['Invite Sent'],
      ));
    } catch (e) {
      emit(
          state.copyWith(userInviteDetailListLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onUserInviteInviteSent(
    UserInviteInviteSent event,
    Emitter<UserInviteState> emit,
  ) async {
    emit(state.copyWith(inviteSentStatus: EntityStatus.loading));
    try {
      EntityResponse response = await usersRepository.sendInvite(event.userId);
      emit(state.copyWith(
        inviteSentStatus: response.isSuccess.toEntityStatusCode(),
        message: response.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        inviteSentStatus: EntityStatus.failure,
      ));
    }
  }

  Future<void> _onUserInviteRegistered(
    UserInviteRegistered event,
    Emitter<UserInviteState> emit,
  ) async {
    emit(state.copyWith(registrationLinkClickStatus: EntityStatus.loading));
    try {
      EntityResponse response = await usersRepository.register(event.userId);

      emit(state.copyWith(
        registrationLinkClickStatus: response.isSuccess.toEntityStatusCode(),
        message: response.message,
      ));
    } catch (e) {
      emit(state.copyWith(registrationLinkClickStatus: EntityStatus.failure));
    }
  }

  Future<void> _onUserInviteAppDownloaded(
    UserInviteAppDownloaded event,
    Emitter<UserInviteState> emit,
  ) async {
    emit(state.copyWith(appDownloadLinkClickStatus: EntityStatus.loading));
    try {
      EntityResponse response = await usersRepository.appDownload(event.userId);

      emit(state.copyWith(
        appDownloadLinkClickStatus: response.isSuccess.toEntityStatusCode(),
        message: response.message,
      ));
    } catch (e) {
      emit(state.copyWith(appDownloadLinkClickStatus: EntityStatus.failure));
    }
  }
}
