import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_action_item_event.dart';
part 'add_action_item_state.dart';

class AddActionItemBloc extends Bloc<AddActionItemEvent, AddActionItemState> {
  AddActionItemBloc() : super(AddActionItemInitial()) {
    on<AddActionItemEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
