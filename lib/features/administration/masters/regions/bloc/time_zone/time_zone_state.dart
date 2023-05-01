part of 'time_zone_bloc.dart';

class TimeZoneState extends Equatable {
  final List<TimeZone> timeZoneList;
  final EntityStatus timeZoneListLoadStatus;
  const TimeZoneState({
    this.timeZoneList = const [],
    this.timeZoneListLoadStatus = EntityStatus.initial,
  });

  @override
  List<Object> get props => [
        timeZoneList,
        timeZoneListLoadStatus,
      ];

  TimeZoneState copyWith({
    List<TimeZone>? timeZoneList,
    EntityStatus? timeZoneListLoadStatus,
  }) {
    return TimeZoneState(
      timeZoneList: timeZoneList ?? this.timeZoneList,
      timeZoneListLoadStatus:
          timeZoneListLoadStatus ?? this.timeZoneListLoadStatus,
    );
  }
}
