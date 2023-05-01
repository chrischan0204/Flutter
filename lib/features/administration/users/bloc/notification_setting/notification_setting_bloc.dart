import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notification_setting_event.dart';
part 'notification_setting_state.dart';

class NotificationSettingBloc extends Bloc<NotificationSettingEvent, NotificationSettingState> {
  NotificationSettingBloc() : super(NotificationSettingInitial()) {
    on<NotificationSettingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
