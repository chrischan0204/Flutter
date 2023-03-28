import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sites_event.dart';
part 'sites_state.dart';

class SitesBloc extends Bloc<SitesEvent, SitesState> {
  SitesBloc() : super(SitesInitial()) {
    on<SitesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
