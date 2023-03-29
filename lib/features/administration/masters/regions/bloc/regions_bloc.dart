import '/data/repository/repository.dart';
import '/data/model/model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'regions_event.dart';
part 'regions_state.dart';

class RegionsBloc extends Bloc<RegionsEvent, RegionsState> {
  final RegionsRepository regionsRepository;
  RegionsBloc({
    required this.regionsRepository,
  }) : super(const RegionsState()) {
    on<AssignedRegionsRetrieved>(_onAssignedRegionsRetrieved);
    on<UnassignedRegionsRetrieved>(_onUnassignedRegionsRetrieved);
    on<TimeZonesRetrievedForRegion>(_onTimeZonesRetrievedForRegion);
    on<RegionSelected>(_onRegionSelected);
    on<RegionSelectedById>(_onRegionSelectedById);
    on<RegionAdded>(_onRegionAdded);
    on<RegionEdited>(_onRegionEdited);
    on<RegionDeleted>(_onRegionDeleted);
    on<RegionsStatusInited>(_onRegionsStatusInited);
  }

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
          assignedRegionsRetrievedStatus: EntityStatus.succuess,
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

  Future<void> _onUnassignedRegionsRetrieved(
    UnassignedRegionsRetrieved event,
    Emitter<RegionsState> emit,
  ) async {
    emit(
      state.copyWith(
        assignedRegionsRetrievedStatus: EntityStatus.loading,
        timeZones: [],
      ),
    );
    try {
      List<Region> unassignedRegions =
          await regionsRepository.getUnassignedRegions();
      emit(
        state.copyWith(
          unassignedRegions: unassignedRegions,
          assignedRegionsRetrievedStatus: EntityStatus.succuess,
          selectedRegion: null,
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
          timeZonesRetrievedStatus: EntityStatus.succuess,
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
          regionSelectedStatus: EntityStatus.succuess,
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
          regionCrudStatus: EntityStatus.succuess,
          selectedRegion: null,
        ));
      } else {
        emit(state.copyWith(
          regionCrudStatus: EntityStatus.failure,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        regionCrudStatus: EntityStatus.failure,
      ));
    }
  }

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
          regionCrudStatus: EntityStatus.succuess,
          selectedRegion: null,
        ));
      } else {
        emit(state.copyWith(
          regionCrudStatus: EntityStatus.failure,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        regionCrudStatus: EntityStatus.failure,
      ));
    }
  }

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
          regionCrudStatus: EntityStatus.succuess,
          selectedRegion: null,
        ));
      } else {
        emit(state.copyWith(
          regionCrudStatus: EntityStatus.failure,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        regionCrudStatus: EntityStatus.failure,
      ));
    }
  }

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
}
