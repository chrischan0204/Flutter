// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'show_site_bloc.dart';

class ShowSiteState extends Equatable {
  /// loaded site by id
  final Site? site;

  /// site load status
  final EntityStatus siteLoadStatus;

  /// audit template list
  final List<Template> auditTemplateList;

  /// project list
  final List<Project> projectList;

  final List<Company> companyList;

  /// audit template list load status
  final EntityStatus listLoadStatus;

  /// site delete status
  final EntityStatus deleteStatus;

  /// response message
  final String message;

  const ShowSiteState({
    this.site,
    this.siteLoadStatus = EntityStatus.initial,
    this.auditTemplateList = const [],
    this.projectList = const [],
    this.companyList = const [],
    this.listLoadStatus = EntityStatus.initial,
    this.deleteStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        site,
        siteLoadStatus,
        auditTemplateList,
        projectList,
        companyList,
        listLoadStatus,
        deleteStatus,
        message,
      ];

  ShowSiteState copyWith({
    Site? site,
    EntityStatus? siteLoadStatus,
    List<Template>? auditTemplateList,
    List<Project>? projectList,
    List<Company>? companyList,
    EntityStatus? listLoadStatus,
    EntityStatus? deleteStatus,
    String? message,
  }) {
    return ShowSiteState(
      site: site ?? this.site,
      siteLoadStatus: siteLoadStatus ?? this.siteLoadStatus,
      auditTemplateList: auditTemplateList ?? this.auditTemplateList,
      projectList: projectList ?? this.projectList,
      companyList: companyList ?? this.companyList,
      listLoadStatus:
          listLoadStatus ?? this.listLoadStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      message: message ?? this.message,
    );
  }
}
