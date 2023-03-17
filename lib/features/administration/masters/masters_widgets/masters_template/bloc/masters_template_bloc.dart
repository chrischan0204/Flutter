import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'masters_template_event.dart';
part 'masters_template_state.dart';

class MastersTemplateBloc
    extends Bloc<MastersTemplateEvent, MastersTemplateState> {
  MastersTemplateBloc()
      : super(
          const MastersTemplateState(),
        ) {
    on<MastersTemplateCrudTypeChanged>(_onMasterTemplateCrudTypeChanged);
  }
  void _onMasterTemplateCrudTypeChanged(
    MastersTemplateCrudTypeChanged event,
    Emitter<MastersTemplateState> emit,
  ) {
    emit(state.copyWith(
      crudType: event.crudType,
    ));
  }
}
