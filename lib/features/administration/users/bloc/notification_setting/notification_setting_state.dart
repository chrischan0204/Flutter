part of 'notification_setting_bloc.dart';

abstract class NotificationSettingState extends Equatable {
  const NotificationSettingState();
  
  @override
  List<Object> get props => [];
}

class NotificationSettingInitial extends NotificationSettingState {}
