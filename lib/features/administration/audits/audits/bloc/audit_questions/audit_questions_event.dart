// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'audit_questions_bloc.dart';

abstract class AuditQuestionsEvent extends Equatable {
  const AuditQuestionsEvent();

  @override
  List<Object> get props => [];
}

/// event to load the audit question snapshot list
class AuditQuestionsSnapshotListLoaded extends AuditQuestionsEvent {
  final String auditId;
  const AuditQuestionsSnapshotListLoaded({
    required this.auditId,
  });

  @override
  List<Object> get props => [auditId];
}
