import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'form_dirty_event.dart';
part 'form_dirty_state.dart';

class FormDirtyBloc extends Bloc<FormDirtyEvent, FormDirtyState> {
  FormDirtyBloc() : super(const FormDirtyState()) {
    on<FormDirtyChanged>(_onFormDirtyChanged);
  }

  @override
  void onChange(Change<FormDirtyState> change) {
    final currentState = change.currentState;
    final nextState = change.nextState;

    print('current');
    print(currentState.isDirty);
    print('next');
    print(nextState.isDirty);

    super.onChange(change);
  }

  void _onFormDirtyChanged(
    FormDirtyChanged event,
    Emitter<FormDirtyState> emit,
  ) {
    emit(state.copyWith(isDirty: event.isDirty));
  }
}
