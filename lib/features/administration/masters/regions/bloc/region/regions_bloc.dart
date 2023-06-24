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
    on<AssignedRegionsRetrieved>(_onAssignedRegionsRetrieved);
    on<UnassignedRegionsRetrieved>(_onUnassignedRegionsRetrieved);
    on<TimeZonesRetrievedForRegion>(_onTimeZonesRetrievedForRegion);
    on<RegionSelected>(_onRegionSelected);
    on<RegionSelectedById>(_onRegionSelectedById);
    on<RegionAdded>(_onRegionAdded);
    on<RegionEdited>(_onRegionEdited);
    on<RegionDeleted>(_onRegionDeleted);
    on<RegionsStatusInited>(_onRegionsStatusInited);
    on<RegionsTimeZonesInited>(_onRegionsTimeZonesInited);
  }

  // get assigned regions list
  Future<void> _onAssignedRegionsRetrieved(
      AssignedRegionsRetrieved event, Emitter<RegionsState> emit) async {
    emit(
      state.copyWith(
        assignedRegionsRetrievedStatus: EntityStatus.loading,
      ),
    );
    try {
      List<Region> assignedRegions =
          await regionsRepository.getAssignedRegions();
      emit(
        state.copyWith(
          assignedRegions: assignedRegions,
          assignedRegionsRetrievedStatus: EntityStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          assignedRegionsRetrievedStatus: EntityStatus.failure,
        ),
      );
    }
  }

  // get unassigned regions list
  Future<void> _onUnassignedRegionsRetrieved(
    UnassignedRegionsRetrieved event,
    Emitter<RegionsState> emit,
  ) async {
    emit(
      state.copyWith(
        unassignedRegionsRetrievedStatus: EntityStatus.loading,
        timeZones: [],
      ),
    );
    try {
      List<Region> unassignedRegions =
          await regionsRepository.getUnassignedRegions();
      if (unassignedRegions.isEmpty) {
        emit(state.copyWith(
          unassignedRegionsRetrievedStatus: EntityStatus.failure,
          message: 'No region available for Add',
          selectedRegion: null,
        ));
      } else {
        emit(state.copyWith(
          unassignedRegions: unassignedRegions,
          unassignedRegionsRetrievedStatus: EntityStatus.success,
          selectedRegion: null,
        ));
      }
    } catch (e) {
      emit(
        state.copyWith(
          unassignedRegionsRetrievedStatus: EntityStatus.failure,
        ),
      );
    }
  }

  // get time zones by region id
  Future<void> _onTimeZonesRetrievedForRegion(
    TimeZonesRetrievedForRegion event,
    Emitter<RegionsState> emit,
  ) async {
    emit(
      state.copyWith(
        timeZonesRetrievedStatus: EntityStatus.loading,
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
          timeZonesRetrievedStatus: EntityStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          timeZonesRetrievedStatus: EntityStatus.failure,
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
      add(TimeZonesRetrievedForRegion(regionId: event.region!.id!));
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
      add(TimeZonesRetrievedForRegion(regionId: event.regionId));
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
        assignedRegionsRetrievedStatus: EntityStatus.initial,
        unassignedRegionsRetrievedStatus: EntityStatus.initial,
        timeZonesRetrievedStatus: EntityStatus.initial,
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
