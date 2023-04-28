import 'package:equatable/equatable.dart';

import '/common_libraries.dart';

part 'add_edit_user_event.dart';
part 'add_edit_user_state.dart';

class AddEditUserBloc extends Bloc<AddEditUserEvent, AddEditUserState> {
  AddEditUserBloc() : super(AddEditUserInitial()) {
    on<AddEditUserEvent>((event, emit) {
      
    });
  }
}
