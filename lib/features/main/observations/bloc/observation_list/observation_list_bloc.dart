import 'package:safety_eta/common_libraries.dart';

part 'observation_list_event.dart';
part 'observation_list_state.dart';

class ObservationListBloc
    extends Bloc<ObservationListEvent, ObservationListState> {
  final ObservationsRepository observationsRepository;
  ObservationListBloc({required this.observationsRepository})
      : super(const ObservationListState()) {
    on<ObservationListLoaded>(_onObservationListLoaded);
    on<ObservationListFiltered>(_onObservationListFiltered);
    on<ObservationListObservationSelected>(
        _onObservationListObservationSelected);
  }

  Future<void> _onObservationListLoaded(
    ObservationListLoaded event,
    Emitter<ObservationListState> emit,
  ) async {
    emit(state.copyWith(observationListLoadStatus: EntityStatus.loading));
    try {
      List<Observation> observationList =
          await observationsRepository.getObservationList();
      emit(state.copyWith(
        observationListLoadStatus: EntityStatus.success,
        observationList: observationList,
      ));
    } catch (e) {
      emit(state.copyWith(observationListLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onObservationListFiltered(
    ObservationListFiltered event,
    Emitter<ObservationListState> emit,
  ) async {
    emit(state.copyWith(observationListLoadStatus: EntityStatus.loading));

    try {
      final observationList = await observationsRepository.getObservationList();
      emit(state.copyWith(
        observationListLoadStatus: EntityStatus.success,
        observationList: observationList,
      ));
      // final filteredobservationData =
      //     await observationsRepository.getFilteredObservationList(event.option);
      // final List<String> columns = List.from(filteredobservationData.headers
      //     .where((e) => !e.isHidden)
      //     .map((e) => e.title));

      // emit(state.copyWith(
      //   observationList: filteredobservationData.data
      //       .map((e) => e.toObservation().copyWith(columns: columns))
      //       .toList(),
      //   observationListLoadStatus: EntityStatus.success,
      //   totalRows: filteredobservationData.totalRows,
      // ));
    } catch (e) {
      emit(state.copyWith(observationListLoadStatus: EntityStatus.failure));
    }
  }

  void _onObservationListObservationSelected(
    ObservationListObservationSelected event,
    Emitter<ObservationListState> emit,
  ) {
    emit(state.copyWith(observation: event.observation));
  }
}
