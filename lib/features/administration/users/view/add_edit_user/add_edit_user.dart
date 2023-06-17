import 'widgets/invite_details.dart';
import 'widgets/assign_sites_to_user.dart';

import '/common_libraries.dart';
import 'widgets/update_notification_for_user/update_notification_for_user.dart';

class AddEditUserView extends StatefulWidget {
  final String? userId;
  final String? view;
  const AddEditUserView({
    super.key,
    this.userId,
    this.view,
  });

  @override
  State<AddEditUserView> createState() => _AddEditUserViewState();
}

class _AddEditUserViewState extends State<AddEditUserView> {
  String token = '';
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AddEditUserBloc(
                  usersRepository: RepositoryProvider.of(context),
                  sitesRepository: RepositoryProvider.of(context),
                  timeZonesRepository: RepositoryProvider.of(context),
                  formDirtyBloc: context.read(),
                )),
        BlocProvider(
            create: (context) => UserDetailBloc(
                usersRepository: RepositoryProvider.of(context))),
        BlocProvider(
            create: (context) => UserInviteBloc(
                usersRepository: RepositoryProvider.of(context))),
        BlocProvider(
            create: (context) =>
                RolesBloc(rolesRepository: RepositoryProvider.of(context))),
        BlocProvider(
            create: (context) =>
                SitesBloc(sitesRepository: RepositoryProvider.of(context))),
        BlocProvider(
            create: (context) => TimeZonesBloc(
                timeZonesRepository: RepositoryProvider.of(context))),
        BlocProvider(
            create: (context) => AssignSiteToUserBloc(
                usersRepository: RepositoryProvider.of(context))),
        BlocProvider(
            create: (context) => NotificationSettingBloc(
                usersRepository: RepositoryProvider.of(context))),
      ],
      child: AddEditUserWidget(
        userId: widget.userId,
        view: widget.view,
      ),
    );
  }
}

class AddEditUserWidget extends StatefulWidget {
  final String? userId;
  final String? view;

  const AddEditUserWidget({
    super.key,
    this.userId,
    this.view,
  });

  @override
  State<AddEditUserWidget> createState() => _AddEditUserWidgetState();
}

class _AddEditUserWidgetState extends State<AddEditUserWidget> {
  late AddEditUserBloc _addEditUserBloc;

  static String pageLabel = 'user';
  static String addButtonName = 'Assign sites & invite';
  static String editButtonName = 'Save';

  bool isFirstInit = true;

  Map<String, Widget> get tabViews => widget.userId == null
      ? {}
      : {
          'Site Access': AssignSitesToUserView(userId: widget.userId!),
          'Notifications': UpdateNotificationForUserView(
            userId: widget.userId!,
          ),
          'Invite Details': InviteDetailView(
            userId: widget.userId!,
          ),
        };

  @override
  void initState() {
    _addEditUserBloc = context.read<AddEditUserBloc>()
      ..add(AddEditUserRoleListLoaded())
      ..add(AddEditUserTimeZoneListLoaded())
      ..add(AddEditUserSiteListLoaded());

    if (widget.userId != null) {
      _addEditUserBloc.add(AddEditUserLoaded(userId: widget.userId!));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditUserBloc, AddEditUserState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: state.message,
          ).showNotification();
          if (widget.userId == null) {
            GoRouter.of(context)
                .go('/users/edit/${state.createdUserId!}?view=created');
          }
        } else if (state.status.isFailure) {
          if (!state.message
              .contains('Email exists, Email cannot be duplicate.')) {
            CustomNotification(
              context: context,
              notifyType: NotifyType.error,
              content: state.message,
            ).showNotification();
          }
        }
      },
      listenWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: pageLabel,
          id: widget.userId,
          selectedEntity: state.loadedUser,
          addButtonName: addButtonName,
          editButtonName: editButtonName,
          addEntity: _addUser,
          editEntity: _editUser,
          crudStatus: state.status,
          formDirty: state.formDirty,
          tabItems: tabViews,
          tabWidth: 500,
          view: widget.view,
          child: Column(
            children: [
              _buildFirstNameField(),
              _buildLastNameField(),
              _buildUserTitleField(),
              _buildEmailField(),
              _buildRoleSelectField(),
              _buildDefaultSiteSelectField(),
              _buildMobilePhoneField(),
              _buildDefaultTimeZoneSelectField(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFirstNameField() {
    return BlocBuilder<AddEditUserBloc, AddEditUserState>(
      builder: (context, state) => FormItem(
        label: 'First Name (*)',
        content: CustomTextField(
          key: ValueKey(state.loadedUser?.id),
          initialValue: state.firstName,
          hintText: 'First Name(required)',
          onChanged: (firstName) => _addEditUserBloc
              .add(AddEditUserFirstNameChanged(firstName: firstName)),
        ),
        message: state.firstNameValidationMessage,
      ),
    );
  }

  Widget _buildLastNameField() {
    return BlocBuilder<AddEditUserBloc, AddEditUserState>(
      builder: (context, state) {
        return FormItem(
          label: 'Last Name (*)',
          content: CustomTextField(
            key: ValueKey(state.loadedUser?.id),
            initialValue: state.lastName,
            hintText: 'Last Name(required)',
            onChanged: (lastName) => _addEditUserBloc
                .add(AddEditUserLastNameChanged(lastName: lastName)),
          ),
          message: state.lastNameValidationMessage,
        );
      },
    );
  }

  Widget _buildUserTitleField() {
    return BlocBuilder<AddEditUserBloc, AddEditUserState>(
      builder: (context, state) {
        return FormItem(
          label: 'User Title',
          content: CustomTextField(
            key: ValueKey(state.loadedUser?.id),
            initialValue: state.title,
            hintText: 'User Title',
            onChanged: (title) =>
                _addEditUserBloc.add(AddEditUserTitleChanged(title: title)),
          ),
          message: state.titleValidationMessage,
        );
      },
    );
  }

  Widget _buildEmailField() {
    return BlocBuilder<AddEditUserBloc, AddEditUserState>(
      builder: (context, state) {
        return FormItem(
          label: 'Email (*)',
          content: CustomTextField(
            key: ValueKey(state.loadedUser?.id),
            initialValue: state.email,
            hintText: 'Email',
            onChanged: (email) =>
                _addEditUserBloc.add(AddEditUserEmailChanged(email: email)),
          ),
          message: state.emailValidationMessage,
        );
      },
    );
  }

  Widget _buildMobilePhoneField() {
    return BlocBuilder<AddEditUserBloc, AddEditUserState>(
      builder: (context, state) {
        return FormItem(
          label: 'Mobile Phone',
          content: CustomTextField(
            key: ValueKey(state.loadedUser?.id),
            initialValue: state.mobilePhone,
            hintText: '+14844731093',
            onChanged: (mobilePhone) => _addEditUserBloc
                .add(AddEditUserMobilePhoneChanged(mobilePhone: mobilePhone)),
          ),
          message: state.mobilePhoneValidationMessage,
        );
      },
    );
  }

  Widget _buildRoleSelectField() {
    return BlocBuilder<AddEditUserBloc, AddEditUserState>(
      builder: (context, state) {
        Map<String, Role> items = <String, Role>{}..addEntries(state.roleList
            .map((userRole) => MapEntry(userRole.name, userRole)));
        return FormItem(
          label: 'Role (*)',
          content: CustomSingleSelect(
            items: items,
            hint: 'Select Role',
            selectedValue: state.roleList.isEmpty ? null : state.role?.name,
            onChanged: (role) =>
                _addEditUserBloc.add(AddEditUserRoleChanged(role: role.value)),
          ),
          message: state.roleValidationMessage,
        );
      },
    );
  }

  Widget _buildDefaultSiteSelectField() {
    return BlocBuilder<AddEditUserBloc, AddEditUserState>(
      builder: (context, state) {
        Map<String, Site> items = <String, Site>{}..addEntries(
            state.siteList.map((site) => MapEntry(site.name!, site)));
        return FormItem(
          label: 'Default Site (*)',
          content: CustomSingleSelect(
            items: items,
            hint: 'Select Default Site',
            selectedValue:
                state.siteList.isEmpty ? null : state.defaultSite?.name,
            onChanged: (defaultSite) => _addEditUserBloc.add(
                AddEditUserDefaultSiteChanged(defaultSite: defaultSite.value)),
          ),
          message: state.defaultSiteValidationMessage,
        );
      },
    );
  }

  Widget _buildDefaultTimeZoneSelectField() {
    return BlocBuilder<AddEditUserBloc, AddEditUserState>(
      builder: (context, state) {
        Map<String, TimeZone> items = <String, TimeZone>{}..addEntries(state
            .timeZoneList
            .map((timeZone) => MapEntry(timeZone.name!, timeZone)));
        return FormItem(
          label: 'Time Zone (*)',
          content: CustomSingleSelect(
            items: items,
            hint: 'Select Timezone',
            selectedValue:
                state.timeZoneList.isEmpty ? null : state.timeZone?.name,
            onChanged: (timeZone) => _addEditUserBloc
                .add(AddEditUserTimeZoneChanged(timeZone: timeZone.value)),
          ),
          message: state.timeZoneValidationMessage,
        );
      },
    );
  }

  void _addUser() => _addEditUserBloc.add(AddEditUserUserAdded());

  void _editUser() =>
      _addEditUserBloc.add(AddEditUserUserEdited(userId: widget.userId!));
}
