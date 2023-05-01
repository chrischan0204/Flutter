part of 'time_zone_bloc.dart';

abstract class TimeZonesEvent extends Equatable {
  const TimeZonesEvent();

  @override
  List<Object> get props => [];
}

class TimeZoneListLoaded extends TimeZonesEvent {}
