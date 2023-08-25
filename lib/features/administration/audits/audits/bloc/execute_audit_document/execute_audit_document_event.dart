part of 'execute_audit_document_bloc.dart';

abstract class ExecuteAuditDocumentEvent extends Equatable {
  const ExecuteAuditDocumentEvent();

  @override
  List<Object> get props => [];
}

/// event to load document list 
class ExecuteAuditDocumentListLoaded extends ExecuteAuditDocumentEvent {}
