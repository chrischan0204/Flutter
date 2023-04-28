part of 'add_edit_user_bloc.dart';

abstract class AddEditUserState extends Equatable {
  final String message;
  const AddEditUserState({this.message = ''});

  @override
  List<Object?> get props => [];
}

class AddEditUserInitial extends AddEditUserState {}

class UserAddInProgress extends AddEditUserState {}

class UserAddSuccess extends AddEditUserState {
  final User? addedUser;
  const UserAddSuccess({
    this.addedUser,
    super.message,
  });
  @override
  List<Object?> get props => [addedUser];
}

class UserAddFailure extends AddEditUserState {
  const UserAddFailure({super.message});
}

class UserEditInProgress extends AddEditUserState {}

class UserEditSuccess extends AddEditUserState {
  final User? editedUser;
  const UserEditSuccess({
    this.editedUser,
    super.message,
  });
  @override
  List<Object?> get props => [
        editedUser,
        message,
      ];
}

class UserEditFailure extends AddEditUserState {
  const UserEditFailure({super.message});
}
