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

/// event to assign template to site
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

/// event to change the filter text for assigned template list
class AssignTemplateToSiteFilterTextForAssignedChanged
    extends AssignTemplateToSiteEvent {
  /// filter text to change
  final String filterText;
  const AssignTemplateToSiteFilterTextForAssignedChanged(
      {required this.filterText});

  @override
  List<Object> get props => [filterText];
}

/// event to change the filter text for unassigned template list
class AssignTemplateToSiteFilterTextForUnassignedChanged
    extends AssignTemplateToSiteEvent {
  /// filter text to change
  final String filterText;
  const AssignTemplateToSiteFilterTextForUnassignedChanged(
      {required this.filterText});

  @override
  List<Object> get props => [filterText];
}

/// event to unassign template from site
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
