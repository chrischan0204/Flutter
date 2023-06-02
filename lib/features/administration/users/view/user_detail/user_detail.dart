import 'widgets/invite_details.dart';
import 'widgets/user_notifcation_settings.dart';
import 'widgets/user_site_access.dart';

import '/common_libraries.dart';

class UserDetailView extends StatefulWidget {
  final String userId;
  const UserDetailView({
    super.key,
    required this.userId,
  });

  @override
  State<UserDetailView> createState() => _UserDetailViewState();
}

class _UserDetailViewState extends State<UserDetailView> {
  String token = '';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) =>
          setState(() => token = state.authUser?.token ?? ''),
      listenWhen: (previous, current) =>
          previous.authUser?.token != current.authUser?.token,
      builder: (context, state) {
        token = state.authUser?.token ?? '';
        return MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => UserDetailBloc(
                    usersRepository: RepositoryProvider.of(context))),
            BlocProvider(
                create: (context) => AssignSiteToUserBloc(
                    usersRepository: RepositoryProvider.of(context))),
            BlocProvider(
                create: (context) => NotificationSettingBloc(
                    usersRepository: RepositoryProvider.of(context))),
            BlocProvider(
                create: (context) => UserInviteBloc(
                    usersRepository: RepositoryProvider.of(context)))
          ],
          child: UserDetailWidget(userId: widget.userId),
        );
      },
    );
  }
}

class UserDetailWidget extends StatefulWidget {
  final String userId;
  const UserDetailWidget({
    super.key,
    required this.userId,
  });

  @override
  State<UserDetailWidget> createState() => _UserDetailWidgetState();
}

class _UserDetailWidgetState extends State<UserDetailWidget> {
  late UserDetailBloc usersBloc;
  late NotificationSettingBloc notificationSettingBloc;
  late AssignSiteToUserBloc assignSiteToUserBloc;

  static String pageTitle = 'User';
  static String pageLabel = 'user';
  static String descriptionForDelete =
      'This item can not be deleted as it has sites assigned to it.';

  @override
  void initState() {
    usersBloc = context.read<UserDetailBloc>()
      ..add(UserDetailUserLoadedById(userId: widget.userId));
    assignSiteToUserBloc = context.read()
      ..add(AssignSiteToUserAssignedUserSiteListLoaded(userId: widget.userId));
    notificationSettingBloc = context.read()
      ..add(NotificationSettingUserSiteNotificationLoaded(userId: widget.userId));

    super.initState();
  }

  _deleteUser(UserDetailState state) {
    usersBloc.add(UserDetailUserDeleted(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserDetailBloc, UserDetailState>(
      listener: (context, state) => _checkDeleteUserStatus(state, context),
      builder: (context, state) {
        return EntityShowTemplate(
          title: pageTitle,
          label: pageLabel,
          deleteEntity: () => _deleteUser(state),
          tabItems: _buildTabs(state),
          entity: state.user,
          crudStatus: state.userDeleteStatus,
          descriptionForDelete: descriptionForDelete,
        );
      },
    );
  }

  Map<String, Widget> _buildTabs(UserDetailState state) {
    return {
      'User Details': Container(),
      'Site Access': UserSiteAccessView(username: state.user?.name ?? ''),
      'Notifications': const UserNotificationSettingView(),
      'Invite Details': UserInviteDetailsView(
        userId: widget.userId,
      ),
      '': Container(),
    };
  }

  void _checkDeleteUserStatus(UserDetailState state, BuildContext context) {
    if (state.userDeleteStatus.isSuccess) {
      CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: state.message,
      ).showNotification();

      GoRouter.of(context).go('/users');
    }
    if (state.userDeleteStatus.isFailure) {
      CustomNotification(
        context: context,
        notifyType: NotifyType.error,
        content: state.message,
      ).showNotification();
    }
  }
}
