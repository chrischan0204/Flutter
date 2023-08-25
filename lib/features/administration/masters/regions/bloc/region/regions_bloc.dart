import '/common_libraries.dart';

part 'regions_event.dart';
part 'regions_state.dart';

class RegionsBloc extends Bloc<RegionsEvent, RegionsState> {
  final RegionsRepository regionsRepository;

  static String addErrorMessage = ErrorMessage('region').add;
  static String editErrorMessage = ErrorMessage('region').edit;
  static String deleteErrorMessage = ErrorMessage('region').delete;

  RegionsBloc({
    required this.regionsRepository,
  }) : super(const RegionsState()) {
    _triggerEvents();
  }

  void _triggerEvents() {
    on<AssignedRegionsLoaded>(_onAssignedRegionsLoaded);
    on<UnassignedRegionsLoaded>(_onUnassignedRegionsLoaded);
    on<TimeZonesLoadedForRegion>(_onTimeZonesLoadedForRegion);
    on<RegionSelected>(_onRegionSelected);
    on<RegionSelectedById>(_onRegionSelectedById);
    on<RegionAdded>(_onRegionAdded);
    on<RegionEdited>(_onRegionEdited);
    on<RegionDeleted>(_onRegionDeleted);
    on<RegionsStatusInited>(_onRegionsStatusInited);
    on<RegionsTimeZonesInited>(_onRegionsTimeZonesInited);
  }

  // get assigned regions list
  Future<void> _onAssignedRegionsLoaded(
      AssignedRegionsLoaded event, Emitter<RegionsState> emit) async {
    emit(
      state.copyWith(
        assignedRegionsLoadedStatus: EntityStatus.loading,
      ),
    );
    try {
      List<Region> assignedRegions =
          await regionsRepository.getAssignedRegions();
      emit(
        state.copyWith(
          assignedRegions: assignedRegions,
          assignedRegionsLoadedStatus: EntityStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          assignedRegionsLoadedStatus: EntityStatus.failure,
        ),
      );
    }
  }

  // get unassigned regions list
  Future<void> _onUnassignedRegionsLoaded(
    UnassignedRegionsLoaded event,
    Emitter<RegionsState> emit,
  ) async {
    emit(
      state.copyWith(
        unassignedRegionsLoadedStatus: EntityStatus.loading,
        timeZones: [],
      ),
    );
    try {
      List<Region> unassignedRegions =
          await regionsRepository.getUnassignedRegions();
      if (unassignedRegions.isEmpty &&
          !(state.selectedRegion != null
              ? !state.selectedRegion!.deletable
              : true)) {
        emit(state.copyWith(
          unassignedRegionsLoadedStatus: EntityStatus.failure,
          message: 'No region available for Add',
          selectedRegion: null,
        ));
      } else {
        emit(state.copyWith(
          unassignedRegions: unassignedRegions,
          unassignedRegionsLoadedStatus: EntityStatus.success,
          selectedRegion: null,
        ));
      }
    } catch (e) {
      emit(
        state.copyWith(
          unassignedRegionsLoadedStatus: EntityStatus.failure,
        ),
      );
    }
  }

  // get time zones by region id
  Future<void> _onTimeZonesLoadedForRegion(
    TimeZonesLoadedForRegion event,
    Emitter<RegionsState> emit,
  ) async {
    emit(
      state.copyWith(
        timeZonesLoadedStatus: EntityStatus.loading,
        timeZones: [],
      ),
    );
    try {
      List<TimeZone> timezones = await regionsRepository.getTimeZonesForRegion(
        event.regionId,
      );
      emit(
        state.copyWith(
          timeZones: timezones,
          timeZonesLoadedStatus: EntityStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          timeZonesLoadedStatus: EntityStatus.failure,
          timeZones: [],
        ),
      );
    }
  }

  // select region
  Future<void> _onRegionSelected(
    RegionSelected event,
    Emitter<RegionsState> emit,
  ) async {
    emit(state.copyWith(
      selectedRegion: event.region,
    ));
    if (event.region != null && event.region!.id != null) {
      add(TimeZonesLoadedForRegion(regionId: event.region!.id!));
    }
  }

  // select region by id
  Future<void> _onRegionSelectedById(
    RegionSelectedById event,
    Emitter<RegionsState> emit,
  ) async {
    emit(state.copyWith(
      regionSelectedStatus: EntityStatus.loading,
      selectedRegion: null,
    ));
    try {
      Region? selectedRegion =
          await regionsRepository.getRegionById(event.regionId);
      emit(
        state.copyWith(
          selectedRegion: selectedRegion,
          regionSelectedStatus: EntityStatus.success,
        ),
      );
      add(TimeZonesLoadedForRegion(regionId: event.regionId));
    } catch (e) {
      emit(state.copyWith(
        selectedRegion: null,
        regionSelectedStatus: EntityStatus.failure,
      ));
    }
  }

  // add region
  Future<void> _onRegionAdded(
    RegionAdded event,
    Emitter<RegionsState> emit,
  ) async {
    emit(state.copyWith(
      regionCrudStatus: EntityStatus.loading,
    ));
    try {
      EntityResponse response = await regionsRepository.addRegion(event.region);
      if (response.isSuccess) {
        emit(state.copyWith(
          regionCrudStatus: EntityStatus.success,
          selectedRegion: null,
          message: response.message,
        ));
      } else {
        emit(state.copyWith(
          regionCrudStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        regionCrudStatus: EntityStatus.failure,
        message: addErrorMessage,
      ));
    }
  }

  // edit region
  Future<void> _onRegionEdited(
    RegionEdited event,
    Emitter<RegionsState> emit,
  ) async {
    emit(state.copyWith(
      regionCrudStatus: EntityStatus.loading,
    ));
    try {
      EntityResponse response =
          await regionsRepository.editRegion(event.region);
      if (response.isSuccess) {
        emit(state.copyWith(
          regionCrudStatus: EntityStatus.success,
          selectedRegion: null,
          message: response.message,
        ));
      } else {
        emit(state.copyWith(
          regionCrudStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        regionCrudStatus: EntityStatus.failure,
        message: editErrorMessage,
      ));
    }
  }

  // delete region
  Future<void> _onRegionDeleted(
    RegionDeleted event,
    Emitter<RegionsState> emit,
  ) async {
    emit(state.copyWith(
      regionCrudStatus: EntityStatus.loading,
    ));
    try {
      EntityResponse response =
          await regionsRepository.deleteRegion(event.regionId);
      if (response.isSuccess) {
        emit(state.copyWith(
          regionCrudStatus: EntityStatus.success,
          selectedRegion: null,
          message: response.message,
        ));
      } else {
        emit(state.copyWith(
          regionCrudStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        regionCrudStatus: EntityStatus.failure,
        message: deleteErrorMessage,
      ));
    }
  }

  // init status of bloc
  void _onRegionsStatusInited(
      RegionsStatusInited event, Emitter<RegionsState> emit) {
    emit(
      state.copyWith(
        regionCrudStatus: EntityStatus.initial,
        regionSelectedStatus: EntityStatus.initial,
        assignedRegionsLoadedStatus: EntityStatus.initial,
        unassignedRegionsLoadedStatus: EntityStatus.initial,
        timeZonesLoadedStatus: EntityStatus.initial,
      ),
    );
  }

  void _onRegionsTimeZonesInited(
    RegionsTimeZonesInited event,
    Emitter<RegionsState> emit,
  ) async {
    emit(state.copyWith(timeZones: []));
  }
}
