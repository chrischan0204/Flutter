import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'observation_detail_event.dart';
part 'observation_detail_state.dart';

class ObservationDetailBloc extends Bloc<ObservationDetailEvent, ObservationDetailState> {
  ObservationDetailBloc() : super(ObservationDetailInitial()) {
    on<ObservationDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
