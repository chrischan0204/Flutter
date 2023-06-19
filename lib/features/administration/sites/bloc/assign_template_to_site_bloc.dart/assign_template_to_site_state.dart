// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'assign_template_to_site_bloc.dart';

class AssignTemplateToSiteState extends Equatable {
  /// assigned audit template list
  final List<Template> assignedAuditTemplateList;

  /// unassigned audit template list
  final List<Template> unassignedAuditTemplateList;

  /// assign & unassign template to site status
  final EntityStatus status;

  /// message for notification
  final String message;
  const AssignTemplateToSiteState({
    this.assignedAuditTemplateList = const [],
    this.unassignedAuditTemplateList = const [],
    this.status = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object> get props => [
        assignedAuditTemplateList,
        unassignedAuditTemplateList,
        status,
        message,
      ];

  AssignTemplateToSiteState copyWith({
    List<Template>? assignedAuditTemplateList,
    List<Template>? unassignedAuditTemplateList,
    EntityStatus? status,
    String? message,
  }) {
    return AssignTemplateToSiteState(
      assignedAuditTemplateList:
          assignedAuditTemplateList ?? this.assignedAuditTemplateList,
      unassignedAuditTemplateList:
          unassignedAuditTemplateList ?? this.unassignedAuditTemplateList,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
