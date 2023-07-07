import 'package:safety_eta/common_libraries.dart';

part 'observation_list_event.dart';
part 'observation_list_state.dart';

class ObservationListBloc
    extends Bloc<ObservationListEvent, ObservationListState> {
  late ObservationsRepository observationsRepository;
  final BuildContext context;
  ObservationListBloc(this.context) : super(const ObservationListState()) {
    observationsRepository = RepositoryProvider.of(context);

    on<ObservationListLoaded>(_onObservationListLoaded);
    on<ObservationListFiltered>(_onObservationListFiltered);
    on<ObservationListObservationForSideDetailLoaded>(
        _onObservationListObservationForSideDetailLoaded);
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
      final filteredobservationData =
          await observationsRepository.getFilteredObservationList(event.option);
      final List<String> columns = List.from(filteredobservationData.headers
          .where((e) => !e.isHidden)
          .map((e) => e.title));

      emit(state.copyWith(
        observationList: filteredobservationData.data
            .map((e) => e.observation.copyWith(columns: columns))
            .toList(),
        observationListLoadStatus: EntityStatus.success,
        totalRows: filteredobservationData.totalRows,
      ));
    } catch (e) {
      print(e);
      emit(state.copyWith(observationListLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onObservationListObservationForSideDetailLoaded(
    ObservationListObservationForSideDetailLoaded event,
    Emitter<ObservationListState> emit,
  ) async {
    emit(state.copyWith(observationLoadStatus: EntityStatus.loading));

    try {
      ObservationDetail observation =
          await observationsRepository.getObservationById(event.observationId);

      emit(state.copyWith(
        observationLoadStatus: EntityStatus.success,
        observation: observation,
      ));
    } catch (e) {
      emit(state.copyWith(observationLoadStatus: EntityStatus.failure));
    }
  }
}
