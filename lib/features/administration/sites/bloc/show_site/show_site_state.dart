// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'show_site_bloc.dart';

class ShowSiteState extends Equatable {
  /// loaded site by id
  final Site? site;

  /// site load status
  final EntityStatus siteLoadStatus;

  /// audit template list
  final List<Template> auditTemplateList;

  /// audit template list load status
  final EntityStatus auditTemplateListLoadStatus;

  /// site delete status
  final EntityStatus deleteStatus;

  /// response message
  final String message;

  const ShowSiteState({
    this.site,
    this.siteLoadStatus = EntityStatus.initial,
    this.auditTemplateList = const [],
    this.auditTemplateListLoadStatus = EntityStatus.initial,
    this.deleteStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        site,
        siteLoadStatus,
        auditTemplateList,
        auditTemplateListLoadStatus,
        deleteStatus,
        message,
      ];

  ShowSiteState copyWith({
    Site? site,
    EntityStatus? siteLoadStatus,
    List<Template>? auditTemplateList,
    EntityStatus? auditTemplateListLoadStatus,
    EntityStatus? deleteStatus,
    String? message,
  }) {
    return ShowSiteState(
      site: site ?? this.site,
      siteLoadStatus: siteLoadStatus ?? this.siteLoadStatus,
      auditTemplateList: auditTemplateList ?? this.auditTemplateList,
      auditTemplateListLoadStatus:
          auditTemplateListLoadStatus ?? this.auditTemplateListLoadStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      message: message ?? this.message,
    );
  }
}
