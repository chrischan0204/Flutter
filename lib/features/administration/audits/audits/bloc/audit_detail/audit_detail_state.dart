part of 'audit_detail_bloc.dart';

abstract class AuditDetailState extends Equatable {
  const AuditDetailState();
  
  @override
  List<Object> get props => [];
}

class AuditDetailInitial extends AuditDetailState {}
