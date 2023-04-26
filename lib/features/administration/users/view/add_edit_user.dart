import '/common_libraries.dart';

class AddEditUserView extends StatefulWidget {
  final String? userId;
  const AddEditUserView({
    super.key,
    this.userId,
  });

  @override
  State<AddEditUserView> createState() => _AddEditUserViewState();
}

class _AddEditUserViewState extends State<AddEditUserView> {
  late UsersBloc usersBloc;
  late RolesBloc rolesBloc;
  late SitesBloc sitesBloc;
  TextEditingController firstNameController = TextEditingController(text: '');
  TextEditingController lastNameController = TextEditingController(text: '');
  TextEditingController userTitleController = TextEditingController(text: '');
  TextEditingController mobilePhoneController = TextEditingController(text: '');

  String firstNameValidationMessage = '';
  String lastNameValidationMessage = '';
  String roleValidationMessage = '';
  String defaultSiteValidationMessage = '';

  static String pageLabel = 'user';

  bool isFirstInit = true;

  @override
  void initState() {
    usersBloc = context.read<UsersBloc>()..add(UsersStatusInited());
    rolesBloc = context.read<RolesBloc>()..add(RolesRetrieved());
    sitesBloc = context.read<SitesBloc>()..add(SitesRetrieved());
    usersBloc.add(const UserSelected(selectedUser: null));
    if (widget.userId != null) {
      usersBloc.add(UserSelectedById(userId: widget.userId!));
    } else {
      usersBloc.add(
        const UserSelected(selectedUser: User()),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersBloc, UsersState>(
      listener: (context, state) {
        // _changeFormData(state);
        _checkCrudResult(state, context);
      },
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: pageLabel,
          id: widget.userId,
          selectedEntity: state.selectedUser,
          addEntity: () => _addUser(state),
          editEntity: () => _editUser(state),
          crudStatus: state.userCrudStatus,
          isCrudDataFill: _checkFormDataFill(),
          child: Column(
            children: [
              _buildFirstNameField(state),
              _buildLastNameField(state),
              _buildUserTitleField(state),
              _buildRoleSelectField(state),
              _buildDefaultSiteSelectField(state),
              _buildMobilePhoneField(state),
              _buildDefaultTimeZoneSelectField(state),
            ],
          ),
        );
      },
    );
  }

  bool _checkFormDataFill() {
    return widget.userId == null
        ? Validation.isEmpty(firstNameController.text) ||
            Validation.isEmpty(lastNameController.text) ||
            Validation.isEmpty(userTitleController.text) ||
            Validation.isEmpty(mobilePhoneController.text)
        : true;
  }

  void _checkCrudResult(UsersState state, BuildContext context) {
    if (state.userCrudStatus == EntityStatus.success) {
      usersBloc.add(UsersStatusInited());
      CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: state.message,
      ).showNotification();
      GoRouter.of(context).go(
          '/users/assign-templates?userId=${state.selectedUser!.id}&userName=${state.selectedUser!.name}');
    }
    if (state.userCrudStatus == EntityStatus.failure) {
      usersBloc.add(UsersStatusInited());
    }
  }

  FormItem _buildFirstNameField(UsersState state) {
    return FormItem(
      label: 'First Name (*)',
      content: CustomTextField(
        controller: firstNameController,
        hintText: 'First Name(required)',
        onChanged: (firstName) {
          setState(() {
            firstNameValidationMessage = '';
          });
          usersBloc.add(
            UserSelected(
              selectedUser: state.selectedUser!.copyWith(
                firstName: firstName,
              ),
            ),
          );
        },
      ),
      message: firstNameValidationMessage,
    );
  }

  FormItem _buildLastNameField(UsersState state) {
    return FormItem(
      label: 'Last Name (*)',
      content: CustomTextField(
        controller: lastNameController,
        hintText: 'Last Name(required)',
        onChanged: (lastName) {
          setState(() {
            lastNameValidationMessage = '';
          });
          usersBloc.add(
            UserSelected(
              selectedUser: state.selectedUser!.copyWith(
                lastName: lastName,
              ),
            ),
          );
        },
      ),
      message: lastNameValidationMessage,
    );
  }

  FormItem _buildUserTitleField(UsersState state) {
    return FormItem(
      label: 'User Title',
      content: CustomTextField(
        controller: userTitleController,
        hintText: 'User Title',
        onChanged: (title) {
          usersBloc.add(
            UserSelected(
              selectedUser: state.selectedUser!.copyWith(
                title: title,
              ),
            ),
          );
        },
      ),
      message: '',
    );
  }

  FormItem _buildMobilePhoneField(UsersState state) {
    return FormItem(
      label: 'Mobile Phone',
      content: CustomTextField(
        controller: mobilePhoneController,
        hintText: 'Cell Phone',
        onChanged: (mobilePhone) {
          usersBloc.add(
            UserSelected(
              selectedUser: state.selectedUser!.copyWith(
                mobileNumber: mobilePhone,
              ),
            ),
          );
        },
      ),
      message: '',
    );
  }

  BlocBuilder<RolesBloc, RolesState> _buildRoleSelectField(UsersState state) {
    return BlocBuilder<RolesBloc, RolesState>(
      builder: (context, rolesState) {
        Map<String, String> items = <String, String>{}
          ..addEntries(rolesState.roles.map(
              (assignedRole) => MapEntry(assignedRole.name, assignedRole.id)));
        return FormItem(
          label: 'Role (*)',
          content: CustomSingleSelect(
            items: items,
            hint: 'Select Role',
            selectedValue: state.selectedUser?.roleName,
            onChanged: (role) {
              setState(() {
                roleValidationMessage = '';
              });

              usersBloc.add(
                UserSelected(
                  selectedUser: state.selectedUser!.copyWith(
                    roleName: role.key,
                    roleId: role.value,
                  ),
                ),
              );
            },
          ),
          message: roleValidationMessage,
        );
      },
    );
  }

  BlocBuilder<SitesBloc, SitesState> _buildDefaultSiteSelectField(
      UsersState state) {
    return BlocBuilder<SitesBloc, SitesState>(
      builder: (context, sitesState) {
        Map<String, String> items = <String, String>{}..addEntries(
            sitesState.sites.map((site) => MapEntry(site.name!, site.id!)));
        return FormItem(
          label: 'Default Site (*)',
          content: CustomSingleSelect(
            items: items,
            hint: 'Select Default Site',
            selectedValue: state.selectedUser?.defaultSiteName,
            onChanged: (role) {
              setState(() {
                defaultSiteValidationMessage = '';
              });

              usersBloc.add(
                UserSelected(
                  selectedUser: state.selectedUser!.copyWith(
                    defaultSiteName: role.key,
                    defaultSiteId: role.value,
                  ),
                ),
              );
            },
          ),
          message: defaultSiteValidationMessage,
        );
      },
    );
  }

  BlocBuilder<RolesBloc, RolesState> _buildDefaultTimeZoneSelectField(
      UsersState state) {
    return BlocBuilder<RolesBloc, RolesState>(
      builder: (context, rolesState) {
        Map<String, String> items = <String, String>{}
          ..addEntries(rolesState.roles.map(
              (assignedRole) => MapEntry(assignedRole.name, assignedRole.id)));
        return FormItem(
          label: 'Time Zone',
          content: CustomSingleSelect(
            items: items,
            hint: 'Select Timezone',
            selectedValue: state.selectedUser?.roleName,
            onChanged: (timeZone) {
              usersBloc.add(
                UserSelected(
                  selectedUser: state.selectedUser!.copyWith(
                    timeZoneName: timeZone.key,
                    timeZoneId: timeZone.value,
                  ),
                ),
              );
            },
          ),
          message: '',
        );
      },
    );
  }

  bool _validate(UsersState state) {
    bool validated = true;
    if (Validation.isEmpty(firstNameController.text)) {
      setState(() {
        firstNameValidationMessage = 'First Name is required.';
      });

      validated = false;
    }

    if (Validation.isEmpty(lastNameController.text)) {
      setState(() {
        lastNameValidationMessage = 'Last Name is required.';
      });

      validated = false;
    }

    if (Validation.isEmpty(state.selectedUser!.roleName)) {
      setState(() {
        roleValidationMessage = 'Role is required.';
      });

      validated = false;
    }

    if (Validation.isEmpty(state.selectedUser!.defaultSiteName)) {
      setState(() {
        defaultSiteValidationMessage = 'Default site is required.';
      });

      validated = false;
    }

    return validated;
  }

  void _addUser(UsersState state) {
    if (!_validate(state)) return;
    usersBloc.add(UserAdded(user: state.selectedUser!));
  }

  void _editUser(UsersState state) {
    if (!_validate(state)) return;
    usersBloc.add(UserEdited(user: state.selectedUser!));
  }
}
