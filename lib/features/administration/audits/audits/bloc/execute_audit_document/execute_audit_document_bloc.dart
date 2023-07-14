import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'execute_audit_document_event.dart';
part 'execute_audit_document_state.dart';

class ExecuteAuditDocumentBloc extends Bloc<ExecuteAuditDocumentEvent, ExecuteAuditDocumentState> {
  ExecuteAuditDocumentBloc() : super(ExecuteAuditDocumentInitial()) {
    on<ExecuteAuditDocumentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
