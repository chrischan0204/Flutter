import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_edit_site_event.dart';
part 'add_edit_site_state.dart';

class AddEditSiteBloc extends Bloc<AddEditSiteEvent, AddEditSiteState> {
  AddEditSiteBloc() : super(AddEditSiteInitial()) {
    on<AddEditSiteEvent>((event, emit) {
      
    });
  }
}
