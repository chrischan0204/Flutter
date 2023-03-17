import '/data/model/entity.dart';
import '../data/model/region.dart';
import '/features/administration/masters/regions/data/repository/regions_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'regions_event.dart';
part 'regions_state.dart';

class RegionsBloc extends Bloc<RegionsEvent, RegionsState> {
  final RegionsRepository regionsRepository;
  RegionsBloc({
    required this.regionsRepository,
  }) : super(const RegionsState()) {
    on<RegionsRetrieved>(_onRegionsRetrieved);
    on<RegionNamesRetrieved>(_onRegionNamesRetrieved);
    on<TimeZonesRetrievedByRegion>(_onTimeZonesRetrievedByRegion);

    on<SelectedRegionNameChanged>(_onSelectedRegionNameChanged);
    on<SelectedTimezonesChanged>(_onSelectedTimezonesChanged);
    on<SelectedAssociatedSitesCountChanged>(
        _onSelectedAssociatedSitesCountChanged);
    on<SelectedIsActiveChanged>(_onSelectedIsActiveChanged);

    on<RegionAdded>(_onRegionAdded);
    on<RegionEdited>(_onRegionEdited);
    on<RegionDeleted>(_onRegionDeleted);

    on<RegionsStateInited>(_onRegionsStateInited);
  }

  Future<void> _onRegionsRetrieved(
      RegionsRetrieved event, Emitter<RegionsState> emit) async {
    emit(
      state.copyWith(
        regionsRetrievedStatus: EntityStatus.loading,
      ),
    );
    try {
      List<Region> regions = await regionsRepository.getRegions();
      emit(
        state.copyWith(
          regions: regions,
          regionsRetrievedStatus: EntityStatus.succuess,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          regionsRetrievedStatus: EntityStatus.failure,
        ),
      );
    }
  }

  Future<void> _onRegionNamesRetrieved(
    RegionNamesRetrieved event,
    Emitter<RegionsState> emit,
  ) async {
    emit(
      state.copyWith(
        regionNamesRetrievedStatus: EntityStatus.loading,
      ),
    );
    try {
      List<String> regionNames = await regionsRepository.getRegionNames();
      emit(
        state.copyWith(
          regionNames: regionNames,
          regionNamesRetrievedStatus: EntityStatus.succuess,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          regionNamesRetrievedStatus: EntityStatus.failure,
        ),
      );
    }
  }

  Future<void> _onTimeZonesRetrievedByRegion(
    TimeZonesRetrievedByRegion event,
    Emitter<RegionsState> emit,
  ) async {
    emit(
      state.copyWith(
        timezonesRetrievedStatus: EntityStatus.loading,
      ),
    );
    try {
      List<String> timezones = await regionsRepository.getTimezonesByRegion(
        event.region,
      );
      emit(
        state.copyWith(
          timeZones: timezones,
          timezonesRetrievedStatus: EntityStatus.succuess,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          timezonesRetrievedStatus: EntityStatus.failure,
        ),
      );
    }
  }

  Future<void> _onRegionAdded(
    RegionAdded event,
    Emitter<RegionsState> emit,
  ) async {
    emit(
      state.copyWith(
        regionAddedStatus: EntityStatus.loading,
      ),
    );
    try {
      Region addedRegion = await regionsRepository.addRegion(
        event.region,
      );
      emit(
        state.copyWith(
          regionAddedStatus: EntityStatus.succuess,
          regions: [...state.regions, addedRegion],
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          regionAddedStatus: EntityStatus.failure,
        ),
      );
    }
    add(RegionsStateInited());
  }

  Future<void> _onRegionEdited(
    RegionEdited event,
    Emitter<RegionsState> emit,
  ) async {
    emit(
      state.copyWith(
        regionEditedStatus: EntityStatus.loading,
      ),
    );
    try {
      Region editedRegion = await regionsRepository.editRegion(
        event.region,
      );
      List<Region> regions = List.from(state.regions);
      int indexToDelete = regions
          .indexWhere((region) => region.regionName == editedRegion.regionName);
      regions.removeAt(indexToDelete);
      regions.insert(indexToDelete, editedRegion);

      emit(
        state.copyWith(
          regionEditedStatus: EntityStatus.succuess,
          regions: regions,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          regionEditedStatus: EntityStatus.failure,
        ),
      );
    }
    add(RegionsStateInited());
  }

  Future<void> _onRegionDeleted(
    RegionDeleted event,
    Emitter<RegionsState> emit,
  ) async {
    emit(
      state.copyWith(
        regionDeletedStatus: EntityStatus.loading,
      ),
    );
    try {
      await regionsRepository.editRegion(
        event.region,
      );
      emit(
        state.copyWith(
          regionDeletedStatus: EntityStatus.succuess,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          regionDeletedStatus: EntityStatus.failure,
        ),
      );
    }
    add(RegionsStateInited());
  }

  void _onSelectedRegionNameChanged(
    SelectedRegionNameChanged event,
    Emitter<RegionsState> emit,
  ) {
    emit(
      state.copyWith(
        selectedRegionName: event.selectedRegionName,
        selectedTimezones: [],
      ),
    );
    add(
      TimeZonesRetrievedByRegion(
        region: event.selectedRegionName,
      ),
    );
  }

  void _onSelectedTimezonesChanged(
    SelectedTimezonesChanged event,
    Emitter<RegionsState> emit,
  ) {
    emit(
      state.copyWith(
        selectedTimezones: event.selectedTimezones,
      ),
    );
  }

  void _onSelectedAssociatedSitesCountChanged(
      SelectedAssociatedSitesCountChanged event, Emitter<RegionsState> emit) {
    emit(
      state.copyWith(
        selectedAssociatedSitesCount: event.selectedAssociatedSitesCount,
      ),
    );
  }

  void _onSelectedIsActiveChanged(
      SelectedIsActiveChanged event, Emitter<RegionsState> emit) {
    emit(
      state.copyWith(
        selectedIsActive: event.selectedIsActive,
      ),
    );
  }

  void _onRegionsStateInited(
      RegionsStateInited event, Emitter<RegionsState> emit) {
    emit(state.copyWith(
      selectedRegionName: '',
      selectedTimezones: [],
      selectedAssociatedSitesCount: 0,
      selectedIsActive: true,
    ));
  }
}
