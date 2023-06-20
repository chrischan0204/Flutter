import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'audit_detail_event.dart';
part 'audit_detail_state.dart';

class AuditDetailBloc extends Bloc<AuditDetailEvent, AuditDetailState> {
  AuditDetailBloc() : super(AuditDetailInitial()) {
    on<AuditDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
