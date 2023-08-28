part of 'time_zone_bloc.dart';

abstract class TimeZonesEvent extends Equatable {
  const TimeZonesEvent();

  @override
  List<Object> get props => [];
}

/// event to load time zone list
class TimeZoneListLoaded extends TimeZonesEvent {}
