import '/common_libraries.dart';

part 'add_action_item_event.dart';
part 'add_action_item_state.dart';

class AddActionItemBloc extends Bloc<AddActionItemEvent, AddActionItemState> {
  AddActionItemBloc() : super(const AddActionItemState()) {
    on<AddActionItemEvent>((event, emit) {});
  }
}
