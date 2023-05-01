import 'package:safety_eta/features/administration/users/view/assign_sites_to_user.dart';

import '/common_libraries.dart';

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
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) => setState(() => token = state.token),
      listenWhen: (previous, current) => previous.token != current.token,
      builder: (context, addEditUserState) {
        token = addEditUserState.token;
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
                create: (context) => UsersRepository(token: token)),
            RepositoryProvider(
                create: (context) => SitesRepository(token: token)),
            RepositoryProvider(
                create: (context) => RolesRepository(token: token)),
            RepositoryProvider(
                create: (context) => TimeZonesRepository(token: token)),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => AddEditUserBloc(
                      usersRepository: RepositoryProvider.of(context))),
              BlocProvider(
                  create: (context) => UserDetailBloc(
                      usersRepository: RepositoryProvider.of(context))),
              BlocProvider(
                  create: (context) => RolesBloc(
                      rolesRepository: RepositoryProvider.of(context))),
              BlocProvider(
                  create: (context) => SitesBloc(
                      sitesRepository: RepositoryProvider.of(context))),
              BlocProvider(
                  create: (context) => TimeZoneBloc(
                      timeZonesRepository: RepositoryProvider.of(context))),
              BlocProvider(
                  create: (context) => AssignSiteToUserBloc(
                      usersRepository: RepositoryProvider.of(context))),
            ],
            child: AddEditUserWidget(userId: widget.userId),
          ),
        );
      },
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
  late AddEditUserBloc addEditUserBloc;
  late UserDetailBloc userDetailBloc;
  late RolesBloc rolesBloc;
  late SitesBloc sitesBloc;
  late TimeZoneBloc timeZoneBloc;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  static String pageLabel = 'user';
  static String addButtonName = 'Assign sites & invite';
  static String editButtonName = 'Update';

  bool isFirstInit = true;

  @override
  void initState() {
    addEditUserBloc = context.read<AddEditUserBloc>()
      ..add(AddEditUserRoleListLoaded());
    userDetailBloc = context.read<UserDetailBloc>();
    timeZoneBloc = context.read<TimeZoneBloc>()..add(TimeZoneListLoaded());
    rolesBloc = context.read<RolesBloc>()..add(RolesRetrieved());
    sitesBloc = context.read<SitesBloc>()..add(SitesRetrieved());
    if (widget.userId != null) {
      userDetailBloc.add(UserDetailUserLoadedById(userId: widget.userId!));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditUserBloc, AddEditUserState>(
      listener: (context, addEditUserState) {
        _checkCrudResult(addEditUserState, context);
      },
      builder: (context, addEditUserState) {
        return BlocBuilder<UserDetailBloc, UserDetailState>(
          builder: (context, userDetailState) {
            return BlocListener<UserDetailBloc, UserDetailState>(
              listener: (context, state) {
                if (state.user != null) {
                  addEditUserBloc
                      .add(AddEditUserDetailsInited(user: state.user!));
                  firstNameController.text = state.user!.firstName;
                  lastNameController.text = state.user!.lastName;
                  titleController.text = state.user!.title;
                  emailController.text = state.user!.email;
                  mobileNumberController.text = state.user!.mobileNumber;
                }
              },
              listenWhen: (previous, current) => previous.user != current.user,
              child: AddEditEntityTemplate(
                label: pageLabel,
                id: widget.userId,
                selectedEntity: userDetailState.user,
                addButtonName: addButtonName,
                editButtonName: editButtonName,
                addEntity: () => _addUser(addEditUserState),
                editEntity: () => _editUser(addEditUserState),
                crudStatus: addEditUserState.userAddStatus,
                isCrudDataFill: _checkFormDataFill(addEditUserState),
                tabItems: _buildTabs(addEditUserState),
                tabWidth: 500,
                view: widget.view,
                child: Column(
                  children: [
                    _buildFirstNameField(addEditUserState),
                    _buildLastNameField(addEditUserState),
                    _buildUserTitleField(addEditUserState),
                    _buildEmailField(addEditUserState),
                    _buildRoleSelectField(addEditUserState),
                    _buildDefaultSiteSelectField(addEditUserState),
                    _buildMobilePhoneField(addEditUserState),
                    _buildDefaultTimeZoneSelectField(addEditUserState),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  bool _checkFormDataFill(AddEditUserState addEditUserState) {
    return widget.userId == null ? addEditUserState.isUserDataFill : true;
  }

  Map<String, Widget> _buildTabs(AddEditUserState addEditUserState) {
    if (widget.userId != null) {
      return {
        'User Details': Container(),
        'Site Access': AssignSitesToUserView(userId: widget.userId!),
        'Notifications': Container(),
        'Invite Details': Container(),
        '': Container(),
      };
    }
    return {};
  }

  void _checkCrudResult(
      AddEditUserState addEditUserState, BuildContext context) {
    if (addEditUserState.userAddStatus.isSuccess ||
        addEditUserState.userEditStatus.isSuccess) {
      CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: addEditUserState.message,
      ).showNotification();
      addEditUserBloc.add(AddEditUserStatusInited());
      if (widget.userId == null) {
        GoRouter.of(context).go('/users/edit/${widget.userId}?view=created');
      }
    } else if (addEditUserState.userAddStatus.isFailure) {
      if (!addEditUserState.message
          .contains('Email exists, Email cannot be duplicate.')) {
        CustomNotification(
          context: context,
          notifyType: NotifyType.error,
          content: addEditUserState.message,
        ).showNotification();
      }
      addEditUserBloc.add(AddEditUserStatusInited());
    }
  }

  FormItem _buildFirstNameField(AddEditUserState addEditUserState) {
    return FormItem(
      label: 'First Name (*)',
      content: CustomTextField(
        controller: firstNameController,
        hintText: 'First Name(required)',
        onChanged: (firstName) => addEditUserBloc
            .add(AddEditUserFirstNameChanged(firstName: firstName)),
      ),
      message: addEditUserState.firstNameValidationMessage,
    );
  }

  FormItem _buildLastNameField(AddEditUserState addEditUserState) {
    return FormItem(
      label: 'Last Name (*)',
      content: CustomTextField(
        controller: lastNameController,
        hintText: 'Last Name(required)',
        onChanged: (lastName) =>
            addEditUserBloc.add(AddEditUserLastNameChanged(lastName: lastName)),
      ),
      message: addEditUserState.lastNameValidationMessage,
    );
  }

  FormItem _buildUserTitleField(AddEditUserState addEditUserState) {
    return FormItem(
      label: 'User Title',
      content: CustomTextField(
        controller: titleController,
        hintText: 'User Title',
        onChanged: (title) =>
            addEditUserBloc.add(AddEditUserTitleChanged(title: title)),
      ),
      message: '',
    );
  }

  FormItem _buildEmailField(AddEditUserState addEditUserState) {
    return FormItem(
      label: 'Email',
      content: CustomTextField(
        controller: emailController,
        hintText: 'Email',
        onChanged: (email) =>
            addEditUserBloc.add(AddEditUserEmailChanged(email: email)),
      ),
      message: addEditUserState.emailValidationMessage,
    );
  }

  FormItem _buildMobilePhoneField(AddEditUserState addEditUserState) {
    return FormItem(
      label: 'Mobile Phone',
      content: CustomTextField(
        controller: mobileNumberController,
        hintText: 'Cell Phone',
        onChanged: (mobilePhone) => addEditUserBloc
            .add(AddEditUserMobilePhoneChanged(mobilePhone: mobilePhone)),
      ),
      message: '',
    );
  }

  FormItem _buildRoleSelectField(AddEditUserState addEditUserState) {
    Map<String, String> items = <String, String>{}..addEntries(addEditUserState
        .userRoleList
        .map((userRole) => MapEntry(userRole.name, userRole.id)));
    return FormItem(
      label: 'Role (*)',
      content: CustomSingleSelect(
        items: items,
        hint: 'Select Role',
        selectedValue: addEditUserState.roleName,
        onChanged: (role) => addEditUserBloc.add(AddEditUserRoleChanged(
          roleId: role.value,
          roleName: role.key,
        )),
      ),
      message: addEditUserState.roleValidationMessage,
    );
  }

  BlocBuilder<SitesBloc, SitesState> _buildDefaultSiteSelectField(
      AddEditUserState addEditUserState) {
    return BlocBuilder<SitesBloc, SitesState>(
      builder: (context, sitesState) {
        Map<String, String> items = <String, String>{}..addEntries(
            sitesState.sites.map((site) => MapEntry(site.name!, site.id!)));
        return FormItem(
          label: 'Default Site (*)',
          content: CustomSingleSelect(
            items: items,
            hint: 'Select Default Site',
            selectedValue: addEditUserState.defaultSiteName,
            onChanged: (defaultSite) =>
                addEditUserBloc.add(AddEditUserDefaultSiteChanged(
              defaultSiteId: defaultSite.value,
              defaultSiteName: defaultSite.key,
            )),
          ),
          message: addEditUserState.defaultSiteValidationMessage,
        );
      },
    );
  }

  BlocBuilder<TimeZoneBloc, TimeZoneState> _buildDefaultTimeZoneSelectField(
      AddEditUserState addEditUserState) {
    return BlocBuilder<TimeZoneBloc, TimeZoneState>(
      builder: (context, state) {
        Map<String, String> items = <String, String>{}..addEntries(state
            .timeZoneList
            .map((timeZone) => MapEntry(timeZone.name!, timeZone.id!)));
        return FormItem(
          label: 'Time Zone',
          content: CustomSingleSelect(
            items: items,
            hint: 'Select Timezone',
            selectedValue: addEditUserState.timeZoneName,
            onChanged: (timeZone) =>
                addEditUserBloc.add(AddEditUserTimeZoneChanged(
              timeZoneId: timeZone.value,
              timeZoneName: timeZone.key,
            )),
          ),
          message: '',
        );
      },
    );
  }

  void _addUser(AddEditUserState addEditUserState) =>
      addEditUserBloc.add(AddEditUserUserAdded());

  void _editUser(AddEditUserState addEditUserState) =>
      addEditUserBloc.add(AddEditUserUserEdited(userId: widget.userId!));
}
