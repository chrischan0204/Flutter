part of 'add_edit_user_bloc.dart';

abstract class AddEditUserEvent extends Equatable {
  const AddEditUserEvent();

  @override
  List<Object?> get props => [];
}

class UserAdded extends AddEditUserEvent {
  final User user;
  const UserAdded({
    required this.user,
  });
  @override
  List<Object?> get props => [
        user,
      ];
}
