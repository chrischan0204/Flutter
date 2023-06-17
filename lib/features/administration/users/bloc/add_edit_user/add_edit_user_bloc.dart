import '/common_libraries.dart';

part 'add_edit_user_event.dart';
part 'add_edit_user_state.dart';

class AddEditUserBloc extends Bloc<AddEditUserEvent, AddEditUserState> {
  final UsersRepository usersRepository;
  final SitesRepository sitesRepository;
  final TimeZonesRepository timeZonesRepository;
  final FormDirtyBloc formDirtyBloc;

  static String firstNameValidationMessage = 'First name is required.';
  static String lastNameValidationMessage = 'Last name is required.';
  static String roleValidationMessage = 'Role is required.';
  static String defaultSiteValidationMessage = 'Default site is required.';
  static String timeZoneValidationMessage = 'Time Zone is required.';
  static String emailValidationMessage = 'Email is required.';

  static String addErrorMessage =
      'There was an error while adding user. Our team has been notified. Please wait a few minutes and try again.';
  static String editErrorMessage =
      'There was an error while editing user. Our team has been notified. Please wait a few minutes and try again.';

  AddEditUserBloc({
    required this.usersRepository,
    required this.timeZonesRepository,
    required this.sitesRepository,
    required this.formDirtyBloc,
  }) : super(const AddEditUserState()) {
    on<AddEditUserFirstNameChanged>(_onAddEditUserFirstNameChanged);
    on<AddEditUserLastNameChanged>(_onAddEditUserLastNameChanged);
    on<AddEditUserTitleChanged>(_onAddEditUserTitleChanged);
    on<AddEditUserEmailChanged>(_onAddEditUserEmailChanged);
    on<AddEditUserMobilePhoneChanged>(_onAddEditUserMobilePhoneChanged);
    on<AddEditUserDefaultSiteChanged>(_onAddEditUserDefaultSiteChanged);
    on<AddEditUserRoleChanged>(_onAddEditUserRoleChanged);
    on<AddEditUserTimeZoneChanged>(_onAddEditUserTimeZoneChanged);
    on<AddEditUserUserAdded>(_onAddEditUserUserAdded);
    on<AddEditUserUserEdited>(_onAddEditUserUserEdited);
    on<AddEditUserLoaded>(_onAddEditUserLoaded);
    on<AddEditUserRoleListLoaded>(_onAddEditUserRoleListLoaded);
    on<AddEditUserSiteListLoaded>(_onAddEditUserSiteListLoaded);
    on<AddEditUserTimeZoneListLoaded>(_onAddEditUserTimeZoneListLoaded);
  }

  void _onAddEditUserFirstNameChanged(
    AddEditUserFirstNameChanged event,
    Emitter<AddEditUserState> emit,
  ) {
    emit(state.copyWith(
      firstName: event.firstName,
      firstNameValidationMessage: '',
    ));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditUserLastNameChanged(
    AddEditUserLastNameChanged event,
    Emitter<AddEditUserState> emit,
  ) {
    emit(state.copyWith(
      lastName: event.lastName,
      lastNameValidationMessage: '',
    ));
    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditUserTitleChanged(
    AddEditUserTitleChanged event,
    Emitter<AddEditUserState> emit,
  ) {
    emit(state.copyWith(
      title: event.title,
      titleValidationMessage: '',
    ));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditUserEmailChanged(
    AddEditUserEmailChanged event,
    Emitter<AddEditUserState> emit,
  ) {
    emit(state.copyWith(
      email: event.email,
      emailValidationMessage: '',
    ));
    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditUserMobilePhoneChanged(
    AddEditUserMobilePhoneChanged event,
    Emitter<AddEditUserState> emit,
  ) {
    emit(state.copyWith(
      mobilePhone: event.mobilePhone,
      mobilePhoneValidationMessage: '',
    ));
    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditUserDefaultSiteChanged(
    AddEditUserDefaultSiteChanged event,
    Emitter<AddEditUserState> emit,
  ) {
    emit(state.copyWith(
      defaultSite: event.defaultSite,
      defaultSiteValidationMessage: '',
    ));
    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditUserRoleChanged(
    AddEditUserRoleChanged event,
    Emitter<AddEditUserState> emit,
  ) {
    emit(state.copyWith(
      role: event.role,
      roleValidationMessage: '',
    ));
    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditUserTimeZoneChanged(
    AddEditUserTimeZoneChanged event,
    Emitter<AddEditUserState> emit,
  ) {
    emit(state.copyWith(
      timeZone: event.timeZone,
      timeZoneValidationMessage: '',
    ));
    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  Future<void> _onAddEditUserUserAdded(
    AddEditUserUserAdded event,
    Emitter<AddEditUserState> emit,
  ) async {
    if (_validate(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));
      try {
        EntityResponse response = await usersRepository.addUser(state.user);

        if (response.isSuccess) {
          emit(state.copyWith(
            createdUserId: response.data?.id,
            status: EntityStatus.success,
            message: response.message,
          ));

          formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
        } else {
          if (response.message.contains('Email')) {
            emit(state.copyWith(
              emailValidationMessage: response.message,
              status: EntityStatus.initial,
            ));
          } else {
            emit(state.copyWith(
              status: EntityStatus.failure,
              message: response.message,
            ));
          }
        }
      } catch (e) {
        emit(state.copyWith(
          status: EntityStatus.failure,
          message: addErrorMessage,
        ));
      }
    }
  }

  Future<void> _onAddEditUserUserEdited(
    AddEditUserUserEdited event,
    Emitter<AddEditUserState> emit,
  ) async {
    if (_validate(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));
      try {
        EntityResponse response = await usersRepository
            .editUser(state.user.copyWith(id: event.userId));

        if (response.isSuccess) {
          emit(state.copyWith(
            status: EntityStatus.success,
            message: response.message,
            initialFirstName: state.firstName,
            initialLastName: state.lastName,
            initialTitle: state.title,
            initialEmail: state.email,
            initialRole: state.role,
            initialMobilePhone: state.mobilePhone,
            initialDefaultSite: state.defaultSite,
            initialTimeZone: state.timeZone,
          ));

          formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
        } else {
          if (response.message.contains('Email')) {
            emit(state.copyWith(
              emailValidationMessage: response.message,
              status: EntityStatus.initial,
            ));
          } else {
            emit(state.copyWith(
              status: EntityStatus.failure,
              message: response.message,
            ));
          }
        }
      } catch (e) {
        emit(state.copyWith(
          status: EntityStatus.failure,
          message: editErrorMessage,
        ));
      }
    }
  }

  /// validate the form
  bool _validate(Emitter<AddEditUserState> emit) {
    bool success = true;
    if (Validation.isEmpty(state.firstName)) {
      emit(state.copyWith(
          firstNameValidationMessage: firstNameValidationMessage));
      success = false;
    } else if (!Validation.checkAlphabetic(state.firstName)) {
      emit(state.copyWith(
          firstNameValidationMessage: 'First name should be alphabetical.'));
      success = false;
    } else if (state.firstName.length > UserFormValidation.firstNameMaxLength) {
      emit(state.copyWith(
          firstNameValidationMessage:
              'First name can be ${UserFormValidation.firstNameMaxLength} long at maximum.'));
      success = false;
    }

    if (Validation.isEmpty(state.lastName)) {
      emit(
          state.copyWith(lastNameValidationMessage: lastNameValidationMessage));
      success = false;
    } else if (!Validation.checkAlphabetic(state.lastName)) {
      emit(state.copyWith(
          lastNameValidationMessage: 'Last name should be alphabetical.'));
      success = false;
    } else if (state.lastName.length > UserFormValidation.lastNameMaxLength) {
      emit(state.copyWith(
          lastNameValidationMessage:
              'Last name can be ${UserFormValidation.lastNameMaxLength} long at maximum.'));
      success = false;
    }

    if (!Validation.isEmpty(state.title) &&
        !Validation.checkAlphabetic(state.title)) {
      emit(state.copyWith(
          titleValidationMessage: 'User title should be alphabetical.'));
      success = false;
    } else if (state.title.length > UserFormValidation.userTitleMaxLength) {
      emit(state.copyWith(
          titleValidationMessage:
              'User title can be ${UserFormValidation.userTitleMaxLength} long at maximum.'));
      success = false;
    }

    if (Validation.isEmpty(state.email)) {
      emit(state.copyWith(emailValidationMessage: emailValidationMessage));
      success = false;
    } else if (!Validation.isEmail(state.email)) {
      emit(
          state.copyWith(emailValidationMessage: 'It should be email format.'));
      success = false;
    } else if (state.email.length > UserFormValidation.emailMaxLength) {
      emit(state.copyWith(
          emailValidationMessage:
              'Emaii can be ${UserFormValidation.emailMaxLength} long at maximum.'));
      success = false;
    }

    if (state.timeZone == null) {
      emit(
          state.copyWith(timeZoneValidationMessage: timeZoneValidationMessage));
      success = false;
    }

    if (state.role == null) {
      emit(state.copyWith(roleValidationMessage: roleValidationMessage));
      success = false;
    }

    if (state.defaultSite == null) {
      emit(state.copyWith(
          defaultSiteValidationMessage: defaultSiteValidationMessage));
      success = false;
    }

    if (!Validation.isEmpty(state.mobilePhone) &&
        !Validation.isMobilePhone(state.mobilePhone)) {
      emit(state.copyWith(
          mobilePhoneValidationMessage: 'It should be phone number format.'));
      success = false;
    }

    return success;
  }

  Future<void> _onAddEditUserLoaded(
    AddEditUserLoaded event,
    Emitter<AddEditUserState> emit,
  ) async {
    try {
      User user = await usersRepository.getUserById(event.userId);

      emit(state.copyWith(
        loadedUser: user,
        initialFirstName: user.firstName,
        initialLastName: user.lastName,
        initialTitle: user.title,
        initialEmail: user.email,
        initialRole: Role(id: user.roleId, name: user.roleName),
        initialMobilePhone: user.mobileNumber,
        initialDefaultSite:
            Site(id: user.defaultSiteId, name: user.defaultSiteName),
        initialTimeZone: TimeZone(id: user.timeZoneId, name: user.timeZoneName),
        firstName: user.firstName,
        lastName: user.lastName,
        title: user.title,
        email: user.email,
        role: Role(id: user.roleId, name: user.roleName),
        mobilePhone: user.mobileNumber,
        defaultSite: Site(id: user.defaultSiteId, name: user.defaultSiteName),
        timeZone: TimeZone(id: user.timeZoneId, name: user.timeZoneName),
      ));
    } catch (e) {}
  }

  Future<void> _onAddEditUserRoleListLoaded(
    AddEditUserRoleListLoaded event,
    Emitter<AddEditUserState> emit,
  ) async {
    try {
      List<Role> roleList = await usersRepository.getUserRoles();
      emit(state.copyWith(roleList: roleList));
    } catch (e) {}
  }

  Future<void> _onAddEditUserSiteListLoaded(
    AddEditUserSiteListLoaded event,
    Emitter<AddEditUserState> emit,
  ) async {
    try {
      List<Site> siteList = await sitesRepository.getSites();
      emit(state.copyWith(siteList: siteList));
    } catch (e) {}
  }

  Future<void> _onAddEditUserTimeZoneListLoaded(
    AddEditUserTimeZoneListLoaded event,
    Emitter<AddEditUserState> emit,
  ) async {
    try {
      List<TimeZone> timeZoneList = await timeZonesRepository.getTimeZoneList();
      emit(state.copyWith(timeZoneList: timeZoneList));
    } catch (e) {}
  }
}
