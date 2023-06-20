// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'assign_template_to_site_bloc.dart';

class AssignTemplateToSiteEvent extends Equatable {
  const AssignTemplateToSiteEvent();

  @override
  List<Object> get props => [];
}

/// event to load the assigned audit template list
class AssignTemplateToSiteAssignedAuditTemplateListLoaded
    extends AssignTemplateToSiteEvent {
  /// site id to load assigned audit template list
  final String id;

  const AssignTemplateToSiteAssignedAuditTemplateListLoaded({required this.id});

  @override
  List<Object> get props => [id];
}

/// event to load the unassigned audit template list
class AssignTemplateToSiteUnassignedAuditTemplateListLoaded
    extends AssignTemplateToSiteEvent {
  /// site id to load unassigned audit template list
  final String id;

  const AssignTemplateToSiteUnassignedAuditTemplateListLoaded(
      {required this.id});

  @override
  List<Object> get props => [id];
}

class AssignTemplateToSiteAssigned extends AssignTemplateToSiteEvent {
  final String templateId;
  final String siteId;
  const AssignTemplateToSiteAssigned({
    required this.templateId,
    required this.siteId,
  });

  @override
  List<Object> get props => [
        templateId,
        siteId,
      ];
}

class AssignTemplateFromSiteUnassigned extends AssignTemplateToSiteEvent {
  final String templateId;
  final String siteId;
  const AssignTemplateFromSiteUnassigned({
    required this.templateId,
    required this.siteId,
  });

  @override
  List<Object> get props => [
        templateId,
        siteId,
      ];
}
