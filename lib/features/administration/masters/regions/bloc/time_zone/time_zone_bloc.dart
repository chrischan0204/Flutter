import 'package:equatable/equatable.dart';
import 'package:safety_eta/common_libraries.dart';

part 'time_zone_event.dart';
part 'time_zone_state.dart';

class TimeZonesBloc extends Bloc<TimeZonesEvent, TimeZoneState> {
  final TimeZonesRepository timeZonesRepository;
  TimeZonesBloc({required this.timeZonesRepository})
      : super(const TimeZoneState()) {
    on<TimeZoneListLoaded>(_onTimeZoneListLoaded);
  }

  Future<void> _onTimeZoneListLoaded(
    TimeZoneListLoaded event,
    Emitter<TimeZoneState> emit,
  ) async {
    emit(state.copyWith(timeZoneListLoadStatus: EntityStatus.loading));

    try {
      List<TimeZone> timeZoneList = await timeZonesRepository.getTimeZoneList();
      emit(state.copyWith(
        timeZoneList: timeZoneList,
        timeZoneListLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(timeZoneListLoadStatus: EntityStatus.failure));
    }
  }
}
