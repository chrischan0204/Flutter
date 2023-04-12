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
  final EntityStatus siteToCompanyAssignedStatus;
  final EntityStatus projectToCompanyAssignedStatus;
  final Company? selectedCompany;
  final EntityStatus companySelectedStatus;
  final EntityStatus companyCrudStatus;
  final String message;
  const CompaniesState({
    this.companies = const [],
    this.assignedCompanySites = const [],
    this.unassignedCompanySites = const [],
    this.assignedProjectCompanies = const [],
    this.unassignedProjectCompanies = const [],
    this.selectedCompany,
    this.companiesRetrievedStatus = EntityStatus.initial,
    this.projectToCompanyAssignedStatus = EntityStatus.initial,
    this.siteToCompanyAssignedStatus = EntityStatus.initial,
    this.assignedCompanySitesRetrievedStatus = EntityStatus.initial,
    this.unassignedCompanySitesRetrievedStatus = EntityStatus.initial,
    this.assignedProjectCompaniesRetrievedStatus = EntityStatus.initial,
    this.unassignedProjectCompaniesRetrievedStatus = EntityStatus.initial,
    this.companyCrudStatus = EntityStatus.initial,
    this.companySelectedStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        companies,
        assignedCompanySites,
        unassignedCompanySites,
        assignedProjectCompanies,
        unassignedProjectCompanies,
        selectedCompany,
        companiesRetrievedStatus,
        siteToCompanyAssignedStatus,
        projectToCompanyAssignedStatus,
        assignedCompanySitesRetrievedStatus,
        assignedProjectCompaniesRetrievedStatus,
        unassignedCompanySitesRetrievedStatus,
        unassignedProjectCompaniesRetrievedStatus,
        companyCrudStatus,
        companySelectedStatus,
        message,
      ];

  CompaniesState copyWith({
    List<Company>? companies,
    List<CompanySite>? assignedCompanySites,
    List<ProjectCompany>? assignedProjectCompanies,
    List<CompanySite>? unassignedCompanySites,
    List<ProjectCompany>? unassignedProjectCompanies,
    Company? selectedCompany,
    EntityStatus? companiesRetrievedStatus,
    EntityStatus? companySelectedStatus,
    EntityStatus? projectToCompanyAssignedStatus,
    EntityStatus? siteToCompanyAssignedStatus,
    EntityStatus? companyCrudStatus,
    EntityStatus? assignedProjectCompaniesRetrievedStatus,
    EntityStatus? assignedCompanySitesRetrievedStatus,
    EntityStatus? unassignedProjectCompaniesRetrievedStatus,
    EntityStatus? unassignedCompanySitesRetrievedStatus,
    String? message,
  }) {
    return CompaniesState(
      companies: companies ?? this.companies,
      assignedCompanySites: assignedCompanySites ?? this.assignedCompanySites,
      assignedProjectCompanies:
          assignedProjectCompanies ?? this.assignedProjectCompanies,
      unassignedCompanySites:
          unassignedCompanySites ?? this.unassignedCompanySites,
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
      selectedCompany: selectedCompany ?? this.selectedCompany,
      companiesRetrievedStatus:
          companiesRetrievedStatus ?? this.companiesRetrievedStatus,
      companySelectedStatus:
          companySelectedStatus ?? this.companySelectedStatus,
      companyCrudStatus: companyCrudStatus ?? this.companyCrudStatus,
      message: message ?? this.message,
    );
  }
}
