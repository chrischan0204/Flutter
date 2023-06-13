part of 'companies_bloc.dart';

class CompaniesState extends Equatable {
  final List<Company> companies;
  final EntityStatus companiesRetrievedStatus;
  final List<CompanySite> assignedCompanySites;
  final EntityStatus assignedCompanySitesRetrievedStatus;
  final List<CompanySite> unassignedCompanySites;
  final EntityStatus unassignedCompanySitesRetrievedStatus;
  final List<ProjectCompany> assignedProjectCompanies;
  final EntityStatus assignedProjectCompaniesRetrievedStatus;
  final List<ProjectCompany> unassignedProjectCompanies;
  final EntityStatus unassignedProjectCompaniesRetrievedStatus;
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
    this.auditTrails = const [],
    this.selectedCompany,
    this.companiesRetrievedStatus = EntityStatus.initial,
    this.projectToCompanyAssignedStatus = EntityStatus.initial,
    this.projectFromCompanyUnassignedStatus = EntityStatus.initial,
    this.siteToCompanyAssignedStatus = EntityStatus.initial,
    this.siteFromCompanyUnassignedStatus = EntityStatus.initial,
    this.assignedCompanySitesRetrievedStatus = EntityStatus.initial,
    this.unassignedCompanySitesRetrievedStatus = EntityStatus.initial,
    this.assignedProjectCompaniesRetrievedStatus = EntityStatus.initial,
    this.unassignedProjectCompaniesRetrievedStatus = EntityStatus.initial,
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
        companiesRetrievedStatus,
        siteToCompanyAssignedStatus,
        siteFromCompanyUnassignedStatus,
        projectToCompanyAssignedStatus,
        projectFromCompanyUnassignedStatus,
        auditTrailsRerievedStatus,
        assignedCompanySitesRetrievedStatus,
        assignedProjectCompaniesRetrievedStatus,
        unassignedCompanySitesRetrievedStatus,
        unassignedProjectCompaniesRetrievedStatus,
        companyCrudStatus,
        companySelectedStatus,
        message,
        filterTextForAssigned,
        filterTextForUnassigned,
        filterSiteIdForAssigned,
        filterSiteIdForUnassigned,
        totalRows,
      ];

  bool get deletable => assignedCompanySites.isEmpty;

  CompaniesState copyWith({
    List<Company>? companies,
    List<CompanySite>? assignedCompanySites,
    List<ProjectCompany>? assignedProjectCompanies,
    List<CompanySite>? unassignedCompanySites,
    List<ProjectCompany>? unassignedProjectCompanies,
    List<AuditTrail>? auditTrails,
    Company? selectedCompany,
    EntityStatus? companiesRetrievedStatus,
    EntityStatus? companySelectedStatus,
    EntityStatus? siteToCompanyAssignedStatus,
    EntityStatus? siteFromCompanyUnassignedStatus,
    EntityStatus? projectToCompanyAssignedStatus,
    EntityStatus? projectFromCompanyUnassignedStatus,
    EntityStatus? companyCrudStatus,
    EntityStatus? assignedProjectCompaniesRetrievedStatus,
    EntityStatus? assignedCompanySitesRetrievedStatus,
    EntityStatus? unassignedProjectCompaniesRetrievedStatus,
    EntityStatus? unassignedCompanySitesRetrievedStatus,
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
      unassignedCompanySites:
          unassignedCompanySites ?? this.unassignedCompanySites,
      auditTrails: auditTrails ?? this.auditTrails,
      unassignedProjectCompanies:
          unassignedProjectCompanies ?? this.unassignedProjectCompanies,
      assignedCompanySitesRetrievedStatus:
          assignedCompanySitesRetrievedStatus ??
              this.assignedCompanySitesRetrievedStatus,
      assignedProjectCompaniesRetrievedStatus:
          assignedProjectCompaniesRetrievedStatus ??
              this.assignedProjectCompaniesRetrievedStatus,
      unassignedCompanySitesRetrievedStatus:
          unassignedCompanySitesRetrievedStatus ??
              this.unassignedCompanySitesRetrievedStatus,
      unassignedProjectCompaniesRetrievedStatus:
          unassignedProjectCompaniesRetrievedStatus ??
              this.unassignedProjectCompaniesRetrievedStatus,
      auditTrailsRerievedStatus:
          auditTrailsRerievedStatus ?? this.auditTrailsRerievedStatus,
      selectedCompany: selectedCompany ?? this.selectedCompany,
      companiesRetrievedStatus:
          companiesRetrievedStatus ?? this.companiesRetrievedStatus,
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
