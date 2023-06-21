import '/common_libraries.dart';

part 'observation_detail_event.dart';
part 'observation_detail_state.dart';

class ObservationDetailBloc
    extends Bloc<ObservationDetailEvent, ObservationDetailState> {
  final BuildContext context;
  late ObservationsRepository observationsRepository;
  ObservationDetailBloc(this.context) : super(const ObservationDetailState()) {
    observationsRepository = RepositoryProvider.of(context);
    on<ObservationDetailLoaded>(_onObservationDetailLoaded);
    on<ObservationDetailObservationDeleted>(
        _onObservationDetailObservationDeleted);
  }

  Future<void> _onObservationDetailLoaded(
    ObservationDetailLoaded event,
    Emitter<ObservationDetailState> emit,
  ) async {
    try {
      Observation observation =
          await observationsRepository.getObservationById(event.observationId);

      emit(state.copyWith(observation: observation));
    } catch (e) {}
  }

  Future<void> _onObservationDetailObservationDeleted(
    ObservationDetailObservationDeleted event,
    Emitter<ObservationDetailState> emit,
  ) async {}
}
