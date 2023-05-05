import './invite_detail_item.dart';
import '/common_libraries.dart';

class UserInviteDetailsView extends StatefulWidget {
  final String userId;
  const UserInviteDetailsView({
    super.key,
    required this.userId,
  });

  @override
  State<UserInviteDetailsView> createState() => _UserInviteDetailsViewState();
}

class _UserInviteDetailsViewState extends State<UserInviteDetailsView> {
  late UserInviteBloc userInviteBloc;
  @override
  void initState() {
    userInviteBloc = context.read()
      ..add(UserInviteDetailsLoaded(userId: widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInviteBloc, UserInviteState>(
        builder: (context, state) {
      if (state.userInviteDetailListLoadStatus.isLoading) {
        return const Center(
          child: Loader(),
        );
      } else if (state.userInviteDetailListLoadStatus.isSuccess) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InviteDetailItem(
                label: 'Invite Sent',
                content: state.inviteSent,
              ),
              state.inviteSent == 'Yes'
                  ? InviteDetailItem(
                      label: 'Sent On',
                      content: state.inviteSentOn,
                    )
                  : const Text(
                      'An invite was never sent to this user.',
                      style: TextStyle(fontSize: 12),
                    ),
              state.inviteSent == 'Yes' &&
                      state.registrationLinkClick.contains('Yes')
                  ? InviteDetailItem(
                      label: 'Registration link Clicked?',
                      content: state.registrationLinkClick,
                    )
                  : state.inviteSent == 'Yes' &&
                          state.registrationLinkClick == 'No'
                      ? const Text(
                          'An invite was sent but the user has not clicked on the registration or app download link yet.',
                          style: TextStyle(fontSize: 12),
                        )
                      : Container(),
              state.inviteSent == 'Yes' &&
                      state.registrationLinkClick.contains('Yes')
                  ? InviteDetailItem(
                      label: 'TapInApp downloaded?',
                      content: state.appDownloadLinkClick,
                      isLast: true,
                    )
                  : Container(),
            ],
          ),
        );
      }
      return Container();
    });
  }
}
