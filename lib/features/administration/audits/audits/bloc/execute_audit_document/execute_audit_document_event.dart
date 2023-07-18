part of 'execute_audit_document_bloc.dart';

abstract class ExecuteAuditDocumentEvent extends Equatable {
  const ExecuteAuditDocumentEvent();

  @override
  List<Object> get props => [];
}

class ExecuteAuditDocumentListLoaded extends ExecuteAuditDocumentEvent {}
