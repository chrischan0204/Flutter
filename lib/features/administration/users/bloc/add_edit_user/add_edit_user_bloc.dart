import 'package:equatable/equatable.dart';

import '/common_libraries.dart';

part 'add_edit_user_event.dart';
part 'add_edit_user_state.dart';

class AddEditUserBloc extends Bloc<AddEditUserEvent, AddEditUserState> {
  final UsersRepository usersRepository;

  static String firstNameValidationMessage = 'First name is required.';
  static String lastNameValidationMessage = 'Last name is required.';
  static String roleValidationMessage = 'Role is required.';
  static String defaultSiteValidationMessage = 'Default site is required.';
  AddEditUserBloc({required this.usersRepository})
      : super(const AddEditUserState()) {
    on<AddEditUserDetailsInited>(_onAddEditUserDetailsInited);
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
    on<AddEditUserRoleListLoaded>(_onAddEditUserRoleListLoaded);
    on<AddEditUserStatusInited>(_onAddEditUserStatusInited);
  }

  void _onAddEditUserDetailsInited(
    AddEditUserDetailsInited event,
    Emitter<AddEditUserState> emit,
  ) {
    emit(state.copyWith(
      firstName: event.user.firstName,
      lastName: event.user.lastName,
      title: event.user.title,
      email: event.user.email,
      roleId: event.user.roleId,
      roleName: event.user.roleName,
      defaultSiteId: event.user.defaultSiteId,
      defaultSiteName: event.user.defaultSiteName,
      timeZoneId: event.user.timeZoneId,
      timeZoneName: event.user.timeZoneName,
      mobilePhone: event.user.mobileNumber,
    ));
  }

  void _onAddEditUserFirstNameChanged(
    AddEditUserFirstNameChanged event,
    Emitter<AddEditUserState> emit,
  ) {
    emit(state.copyWith(
      firstName: event.firstName,
      firstNameValidationMessage: '',
    ));
  }

  void _onAddEditUserLastNameChanged(
    AddEditUserLastNameChanged event,
    Emitter<AddEditUserState> emit,
  ) {
    emit(state.copyWith(
      lastName: event.lastName,
      lastNameValidationMessage: '',
    ));
  }

  void _onAddEditUserTitleChanged(
    AddEditUserTitleChanged event,
    Emitter<AddEditUserState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onAddEditUserEmailChanged(
    AddEditUserEmailChanged event,
    Emitter<AddEditUserState> emit,
  ) {
    emit(state.copyWith(
      email: event.email,
      emailValidationMessage: '',
    ));
  }

  void _onAddEditUserMobilePhoneChanged(
    AddEditUserMobilePhoneChanged event,
    Emitter<AddEditUserState> emit,
  ) {
    emit(state.copyWith(mobilePhone: event.mobilePhone));
  }

  void _onAddEditUserDefaultSiteChanged(
    AddEditUserDefaultSiteChanged event,
    Emitter<AddEditUserState> emit,
  ) {
    emit(state.copyWith(
      defaultSiteId: event.defaultSiteId,
      defaultSiteName: event.defaultSiteName,
      defaultSiteValidationMessage: '',
    ));
  }

  void _onAddEditUserRoleChanged(
    AddEditUserRoleChanged event,
    Emitter<AddEditUserState> emit,
  ) {
    emit(state.copyWith(
      roleId: event.roleId,
      roleName: event.roleName,
      roleValidationMessage: '',
    ));
  }

  void _onAddEditUserTimeZoneChanged(
    AddEditUserTimeZoneChanged event,
    Emitter<AddEditUserState> emit,
  ) {
    emit(state.copyWith(
      timeZoneId: event.timeZoneId,
      timeZoneName: event.timeZoneName,
    ));
  }

  Future<void> _onAddEditUserUserAdded(
    AddEditUserUserAdded event,
    Emitter<AddEditUserState> emit,
  ) async {
    if (_validateUserData(emit)) {
      emit(state.copyWith(userAddStatus: EntityStatus.loading));
      try {
        EntityResponse response = await usersRepository.addUser(User(
          firstName: state.firstName,
          lastName: state.lastName,
          title: state.title,
          email: state.email,
          mobileNumber: state.mobilePhone,
          roleId: state.roleId,
          defaultSiteId: state.defaultSiteId,
          timeZoneId: state.timeZoneId,
        ));

        emit(state.copyWith(
          userAddStatus:
              response.isSuccess ? EntityStatus.success : EntityStatus.failure,
          message: response.message,
        ));
        if (response.message.contains('Email')) {
          emit(state.copyWith(emailValidationMessage: response.message));
        }
      } catch (e) {
        emit(state.copyWith(userAddStatus: EntityStatus.failure));
      }
    }
  }

  Future<void> _onAddEditUserUserEdited(
    AddEditUserUserEdited event,
    Emitter<AddEditUserState> emit,
  ) async {
    if (_validateUserData(emit)) {
      emit(state.copyWith(userAddStatus: EntityStatus.loading));
      try {
        EntityResponse response = await usersRepository.editUser(User(
          id: event.userId,
          firstName: state.firstName,
          lastName: state.lastName,
          title: state.title,
          email: state.email,
          mobileNumber: state.mobilePhone,
          roleId: state.roleId,
          defaultSiteId: state.defaultSiteId,
          timeZoneId: state.timeZoneId,
        ));

        emit(state.copyWith(
          userAddStatus:
              response.isSuccess ? EntityStatus.success : EntityStatus.failure,
          message: response.message,
        ));
        if (response.message.contains('Email')) {
          emit(state.copyWith(emailValidationMessage: response.message));
        }
      } catch (e) {
        emit(state.copyWith(userAddStatus: EntityStatus.failure));
      }
    }
  }

  bool _validateUserData(Emitter<AddEditUserState> emit) {
    bool success = true;
    if (Validation.isEmpty(state.firstName)) {
      emit(state.copyWith(
          firstNameValidationMessage: firstNameValidationMessage));
      success = false;
    }

    if (Validation.isEmpty(state.lastName)) {
      emit(
          state.copyWith(lastNameValidationMessage: lastNameValidationMessage));
      success = false;
    }

    if (Validation.isEmpty(state.roleId)) {
      emit(state.copyWith(roleValidationMessage: roleValidationMessage));
      success = false;
    }

    if (Validation.isEmpty(state.defaultSiteId)) {
      emit(state.copyWith(
          defaultSiteValidationMessage: defaultSiteValidationMessage));
      success = false;
    }

    return success;
  }

  Future<void> _onAddEditUserRoleListLoaded(
    AddEditUserRoleListLoaded event,
    Emitter<AddEditUserState> emit,
  ) async {
    emit(state.copyWith(userRoleListLoadStatus: EntityStatus.loading));
    try {
      List<Role> userRoleList = await usersRepository.getUserRoles();
      emit(state.copyWith(
        userRoleList: userRoleList,
        userRoleListLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(userRoleListLoadStatus: EntityStatus.failure));
    }
  }

  void _onAddEditUserStatusInited(
    AddEditUserStatusInited event,
    Emitter<AddEditUserState> emit,
  ) {
    emit(state.copyWith(
      userAddStatus: EntityStatus.initial,
      userEditStatus: EntityStatus.initial,
      userRoleListLoadStatus: EntityStatus.initial,
    ));
  }
}
