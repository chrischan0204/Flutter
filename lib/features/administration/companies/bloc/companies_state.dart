part of 'companies_bloc.dart';

class CompaniesState extends Equatable {
  final List<Company> companies;
  final EntityStatus companiesLoadedStatus;
  final List<CompanySite> assignedCompanySites;
  final EntityStatus assignedCompanySitesLoadedStatus;
  final List<CompanySite> unassignedCompanySites;
  final EntityStatus unassignedCompanySitesLoadedStatus;
  final List<ProjectCompany> assignedProjectCompanies;
  final List<ProjectCompany> assignedProjectCompaniesForFilter;
  final EntityStatus assignedProjectCompanyListLoadedStatus;
  final List<ProjectCompany> unassignedProjectCompanies;
  final List<ProjectCompany> unassignedProjectCompaniesForFilter;
  final EntityStatus unassignedProjectCompanyListLoadedStatus;
  final List<AuditTrail> auditTrails;
  final EntityStatus auditTrailsRerievedStatus;
  final EntityStatus siteToCompanyAssignedStatus;
  final EntityStatus siteFromCompanyUnassignedStatus;
  final EntityStatus projectToCompanyAssignedStatus;
  final EntityStatus projectFromCompanyUnassignedStatus;
  final Company? selectedCompany;
  final EntityStatus companySelectedStatus;
  final EntityStatus companyCrudStatus;
  final String filterTextForAssigned;
  final String filterTextForUnassigned;
  final String filterSiteIdForAssigned;
  final String filterSiteIdForUnassigned;
  final String message;
  final int totalRows;
  const CompaniesState({
    this.companies = const [],
    this.assignedCompanySites = const [],
    this.unassignedCompanySites = const [],
    this.assignedProjectCompanies = const [],
    this.unassignedProjectCompanies = const [],
    this.assignedProjectCompaniesForFilter = const [],
    this.unassignedProjectCompaniesForFilter = const [],
    this.auditTrails = const [],
    this.selectedCompany,
    this.companiesLoadedStatus = EntityStatus.initial,
    this.projectToCompanyAssignedStatus = EntityStatus.initial,
    this.projectFromCompanyUnassignedStatus = EntityStatus.initial,
    this.siteToCompanyAssignedStatus = EntityStatus.initial,
    this.siteFromCompanyUnassignedStatus = EntityStatus.initial,
    this.assignedCompanySitesLoadedStatus = EntityStatus.initial,
    this.unassignedCompanySitesLoadedStatus = EntityStatus.initial,
    this.assignedProjectCompanyListLoadedStatus = EntityStatus.initial,
    this.unassignedProjectCompanyListLoadedStatus = EntityStatus.initial,
    this.auditTrailsRerievedStatus = EntityStatus.initial,
    this.companyCrudStatus = EntityStatus.initial,
    this.companySelectedStatus = EntityStatus.initial,
    this.filterTextForAssigned = '',
    this.filterTextForUnassigned = '',
    this.filterSiteIdForAssigned = '',
    this.filterSiteIdForUnassigned = '',
    this.message = '',
    this.totalRows = 0,
  });

  bool get isFormDataFill =>
      !Validation.isEmpty(selectedCompany?.einNumber) ||
      !Validation.isEmpty(selectedCompany?.name);

  @override
  List<Object?> get props => [
        companies,
        assignedCompanySites,
        unassignedCompanySites,
        assignedProjectCompanies,
        unassignedProjectCompanies,
        auditTrails,
        selectedCompany,
        companiesLoadedStatus,
        siteToCompanyAssignedStatus,
        siteFromCompanyUnassignedStatus,
        projectToCompanyAssignedStatus,
        projectFromCompanyUnassignedStatus,
        auditTrailsRerievedStatus,
        assignedCompanySitesLoadedStatus,
        assignedProjectCompanyListLoadedStatus,
        unassignedCompanySitesLoadedStatus,
        unassignedProjectCompanyListLoadedStatus,
        companyCrudStatus,
        companySelectedStatus,
        message,
        filterTextForAssigned,
        filterTextForUnassigned,
        filterSiteIdForAssigned,
        filterSiteIdForUnassigned,
        totalRows,
        assignedProjectCompaniesForFilter,
        unassignedProjectCompaniesForFilter,
      ];

  bool get deletable => assignedCompanySites.isEmpty;

  CompaniesState copyWith({
    List<Company>? companies,
    List<CompanySite>? assignedCompanySites,
    List<ProjectCompany>? assignedProjectCompanies,
    List<CompanySite>? unassignedCompanySites,
    List<ProjectCompany>? unassignedProjectCompanies,
    List<ProjectCompany>? assignedProjectCompaniesForFilter,
    List<ProjectCompany>? unassignedProjectCompaniesForFilter,
    List<AuditTrail>? auditTrails,
    Company? selectedCompany,
    EntityStatus? companiesLoadedStatus,
    EntityStatus? companySelectedStatus,
    EntityStatus? siteToCompanyAssignedStatus,
    EntityStatus? siteFromCompanyUnassignedStatus,
    EntityStatus? projectToCompanyAssignedStatus,
    EntityStatus? projectFromCompanyUnassignedStatus,
    EntityStatus? companyCrudStatus,
    EntityStatus? assignedProjectCompanyListLoadedStatus,
    EntityStatus? assignedCompanySitesLoadedStatus,
    EntityStatus? unassignedProjectCompanyListLoadedStatus,
    EntityStatus? unassignedCompanySitesLoadedStatus,
    EntityStatus? auditTrailsRerievedStatus,
    String? message,
    String? filterTextForAssigned,
    String? filterTextForUnassigned,
    String? filterSiteIdForAssigned,
    String? filterSiteIdForUnassigned,
    int? totalRows,
  }) {
    return CompaniesState(
      companies: companies ?? this.companies,
      assignedCompanySites: assignedCompanySites ?? this.assignedCompanySites,
      assignedProjectCompanies:
          assignedProjectCompanies ?? this.assignedProjectCompanies,
      assignedProjectCompaniesForFilter: assignedProjectCompaniesForFilter ??
          this.assignedProjectCompaniesForFilter,
      unassignedProjectCompaniesForFilter:
          unassignedProjectCompaniesForFilter ??
              this.unassignedProjectCompaniesForFilter,
      unassignedCompanySites:
          unassignedCompanySites ?? this.unassignedCompanySites,
      auditTrails: auditTrails ?? this.auditTrails,
      unassignedProjectCompanies:
          unassignedProjectCompanies ?? this.unassignedProjectCompanies,
      assignedCompanySitesLoadedStatus: assignedCompanySitesLoadedStatus ??
          this.assignedCompanySitesLoadedStatus,
      assignedProjectCompanyListLoadedStatus:
          assignedProjectCompanyListLoadedStatus ??
              this.assignedProjectCompanyListLoadedStatus,
      unassignedCompanySitesLoadedStatus: unassignedCompanySitesLoadedStatus ??
          this.unassignedCompanySitesLoadedStatus,
      unassignedProjectCompanyListLoadedStatus:
          unassignedProjectCompanyListLoadedStatus ??
              this.unassignedProjectCompanyListLoadedStatus,
      auditTrailsRerievedStatus:
          auditTrailsRerievedStatus ?? this.auditTrailsRerievedStatus,
      selectedCompany: selectedCompany ?? this.selectedCompany,
      companiesLoadedStatus:
          companiesLoadedStatus ?? this.companiesLoadedStatus,
      companySelectedStatus:
          companySelectedStatus ?? this.companySelectedStatus,
      companyCrudStatus: companyCrudStatus ?? this.companyCrudStatus,
      siteToCompanyAssignedStatus:
          siteToCompanyAssignedStatus ?? this.siteToCompanyAssignedStatus,
      siteFromCompanyUnassignedStatus: siteFromCompanyUnassignedStatus ??
          this.siteFromCompanyUnassignedStatus,
      projectToCompanyAssignedStatus:
          projectToCompanyAssignedStatus ?? this.projectToCompanyAssignedStatus,
      projectFromCompanyUnassignedStatus: projectFromCompanyUnassignedStatus ??
          this.projectFromCompanyUnassignedStatus,
      message: message ?? this.message,
      filterTextForAssigned:
          filterTextForAssigned ?? this.filterTextForAssigned,
      filterTextForUnassigned:
          filterTextForUnassigned ?? this.filterTextForUnassigned,
      filterSiteIdForAssigned:
          filterSiteIdForAssigned ?? this.filterSiteIdForAssigned,
      filterSiteIdForUnassigned:
          filterSiteIdForUnassigned ?? this.filterSiteIdForUnassigned,
      totalRows: totalRows ?? this.totalRows,
    );
  }
}
