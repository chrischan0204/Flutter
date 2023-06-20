import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../common_libraries.dart';

part 'audit_detail_event.dart';
part 'audit_detail_state.dart';

class AuditDetailBloc extends Bloc<AuditDetailEvent, AuditDetailState> {
  AuditDetailBloc() : super(const AuditDetailState()) {
    on<AuditDetailLoaded>(_onAuditDetailLoaded);
    on<AuditDetailAuditDeleted>(_onAuditDetailAuditDeleted);
  }

  Future<void> _onAuditDetailLoaded(
    AuditDetailLoaded event,
    Emitter<AuditDetailState> emit,
  ) async {}

  Future<void> _onAuditDetailAuditDeleted(
    AuditDetailAuditDeleted event,
    Emitter<AuditDetailState> emit,
  ) async {}
}
