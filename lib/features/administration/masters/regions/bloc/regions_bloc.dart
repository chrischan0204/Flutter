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

    on<SelectedRegionChanged>(_onSelectedRegionChanged);
    // on<SelectedRegionNameChanged>(_onSelectedRegionNameChanged);
    // on<SelectedTimezonesChanged>(_onSelectedTimezonesChanged);
    // on<SelectedAssociatedSitesCountChanged>(
    //     _onSelectedAssociatedSitesCountChanged);
    // on<SelectedActiveChanged>(_onSelectedActiveChanged);
    // on<SelectedRegionIdChanged>(_onSelectedRegionIdChanged);

    on<RegionAdded>(_onRegionAdded);
    on<RegionEdited>(_onRegionEdited);
    on<RegionDeleted>(_onRegionDeleted);

    on<RegionsStateInited>(_onRegionsStateInited);
  }

  Future<void> _onAssignedRegionsRetrieved(
      AssignedRegionsRetrieved event, Emitter<RegionsState> emit) async {
    emit(
      state.copyWith(
        unassignedRegionsRetrievedStatus: EntityStatus.loading,
      ),
    );
    try {
      List<Region> assignedRegions =
          await regionsRepository.getAssignedRegions();
      emit(
        state.copyWith(
          assignedRegions: assignedRegions,
          unassignedRegionsRetrievedStatus: EntityStatus.succuess,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          unassignedRegionsRetrievedStatus: EntityStatus.failure,
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
      ),
    );
    try {
      List<Region> unassignedRegions =
          await regionsRepository.getUnassignedRegions();
      emit(
        state.copyWith(
          unassignedRegions: unassignedRegions,
          assignedRegionsRetrievedStatus: EntityStatus.succuess,
        ),
      );
    } catch (e) {
      print(e.toString());
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
        timezonesRetrievedStatus: EntityStatus.loading,
      ),
    );
    try {
      List<TimeZone> timezones = await regionsRepository.getTimeZonesForRegion(
        event.regionId,
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
    // add(const SelectedTimezonesChanged(selectedTimezones: []));
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
          assignedRegions: [...state.assignedRegions, addedRegion],
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
      List<Region> assignedRegions = List.from(state.assignedRegions);
      int indexToDelete =
          assignedRegions.indexWhere((region) => region.id == editedRegion.id);
      assignedRegions.removeAt(indexToDelete);
      assignedRegions.insert(indexToDelete, editedRegion);

      emit(
        state.copyWith(
          regionEditedStatus: EntityStatus.succuess,
          assignedRegions: assignedRegions,
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
      Region deletedRegion = await regionsRepository.deleteRegion(
        event.region,
      );
      List<Region> assignedRegions = List.from(state.assignedRegions);
      assignedRegions.removeWhere((region) => region.id == deletedRegion.id);
      emit(
        state.copyWith(
          regionDeletedStatus: EntityStatus.succuess,
          assignedRegions: assignedRegions,
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

  void _onSelectedRegionChanged(
    SelectedRegionChanged event,
    Emitter<RegionsState> emit,
  ) {

  }
  // void _onSelectedRegionNameChanged(
  //   SelectedRegionNameChanged event,
  //   Emitter<RegionsState> emit,
  // ) {
  //   emit(
  //     state.copyWith(
  //       selectedRegionName: event.selectedRegionName,
  //       selectedTimezones: [],
  //     ),
  //   );
  //   add(
  //     TimeZonesRetrievedForRegion(
  //       region: event.selectedRegionName,
  //     ),
  //   );
  // }

  // void _onSelectedTimezonesChanged(
  //   SelectedTimezonesChanged event,
  //   Emitter<RegionsState> emit,
  // ) {
  //   emit(
  //     state.copyWith(
  //       selectedTimezones: event.selectedTimezones,
  //     ),
  //   );
  // }

  // void _onSelectedAssociatedSitesCountChanged(
  //     SelectedAssociatedSitesCountChanged event, Emitter<RegionsState> emit) {
  //   emit(
  //     state.copyWith(
  //       selectedAssociatedSitesCount: event.selectedAssociatedSitesCount,
  //     ),
  //   );
  // }

  // void _onSelectedActiveChanged(
  //     SelectedActiveChanged event, Emitter<RegionsState> emit) {
  //   emit(
  //     state.copyWith(
  //       selectedActive: event.selectedActive,
  //     ),
  //   );
  // }

  // void _onSelectedRegionIdChanged(
  //   SelectedRegionIdChanged event,
  //   Emitter<RegionsState> emit,
  // ) {
  //   emit(
  //     state.copyWith(
  //       selectedRegionId: event.selectedRegionId,
  //     ),
  //   );
  // }

  void _onRegionsStateInited(
      RegionsStateInited event, Emitter<RegionsState> emit) {
    emit(state.copyWith(
      selectedRegionName: '',
      selectedTimezones: [],
      selectedAssociatedSitesCount: 0,
      selectedActive: true,
      timeZones: [],
    ));
  }
}
