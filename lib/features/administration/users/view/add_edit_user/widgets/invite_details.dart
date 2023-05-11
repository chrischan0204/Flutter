import '/common_libraries.dart';

class InviteDetailView extends StatefulWidget {
  final String userId;
  const InviteDetailView({
    super.key,
    required this.userId,
  });

  @override
  State<InviteDetailView> createState() => _InviteDetailViewState();
}

class _InviteDetailViewState extends State<InviteDetailView> {
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
        return const Center(child: Loader());
      } else if (state.userInviteDetailListLoadStatus.isSuccess) {
        if (state.inviteSent == 'Yes') {
          if (!state.registrationLinkClick.contains('Yes') &&
              !state.appDownloadLinkClick.contains('Yes')) {
            return InviteItem(
              title: 'Invite Sent/ Pending app download',
              content: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'An email invite was sent to the user on ${state.inviteSentOn}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Text(
                          'Registration link clicked:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          state.registrationLinkClick,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Text(
                          'App download link clicked:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          state.registrationLinkClick,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (state.registrationLinkClick.contains('Yes') &&
              !state.appDownloadLinkClick.contains('Yes')) {
            return InviteItem(
              title: 'Registration Completed/ Pending App download',
              content: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'An email invite was sent to the user on ${state.inviteSentOn}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'The user clicked the link for registration on their device on ${state.registrationLinkClikedOn}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Text(
                          'App download link clicked:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          state.registrationLinkClick,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (state.registrationLinkClick.contains('Yes') &&
              state.appDownloadLinkClick.contains('Yes')) {
            return InviteItem(
              title: 'Registration completed and App downloaded',
              content: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'An email invite was sent to the user on ${state.inviteSentOn}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'The user clicked the link for registration on their device on ${state.registrationLinkClikedOn}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'The user clicked the link to download the app on their device on ${state.appDownloadLinkClickedOn}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            );
          }
        } else {
          if (state.inviteSentStatus.isLoading) {
            return InviteItem(
              title: 'Send an invite to the user?',
              content: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Loader(),
                    SizedBox(height: 10),
                    Text(
                      'Please wait as the invite is being sent out to the user........',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state.inviteSentStatus.isSuccess) {
            return InviteItem(
              title: 'Send an invite to the user?',
              content: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'An email invite was sent to the user on ${state.inviteSentOn}.',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const Text(
                      'They will receive an email along with a link that can be used to download and install the Tap In app on their mobile device.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            );
          }

          return InviteItem(
            title: 'Send an invite to the user?',
            content: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Please click on the send invite button below to send an invite out to the user.',
                    style: TextStyle(fontSize: 14),
                  ),
                  const Text(
                    'They will receive an email along with a link that can be used to download and install the Tap In app on their mobile device.',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    backgroundColor: const Color(0xff049aad),
                    hoverBackgroundColor: const Color(0xff048b9c),
                    text: 'Send invite',
                    textStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    borderRadius: 5,
                    onClick: () => _sendInvitation(),
                  ),
                ],
              ),
            ),
          );
        }
      }
      return Container();
    });
  }

  void _sendInvitation() {
    userInviteBloc.add(UserInviteInviteSent(userId: widget.userId));
  }
}

class InviteItem extends StatelessWidget {
  final String title;
  final Widget content;
  const InviteItem({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(1, 1),
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const CustomDivider(
            height: 5,
          ),
          content,
        ],
      ),
    );
  }
}
