part of 'companies_bloc.dart';

class CompaniesState extends Equatable {
  final List<Company> companies;
  final EntityStatus companiesRetrievedStatus;
  final List<CompanySite> companySites;
  final EntityStatus companySitesRetrievedStatus;
  final List<ProjectCompany> projectCompanies;
  final EntityStatus projectCompaniesRetrievedStatus;
  final EntityStatus siteToCompanyAssignedStatus;
  final EntityStatus projectToCompanyAssignedStatus;
  final Company? selectedCompany;
  final EntityStatus companySelectedStatus;
  final EntityStatus companyCrudStatus;
  final String message;
  const CompaniesState({
    this.companies = const [],
    this.companySites = const [],
    this.projectCompanies = const [],
    this.selectedCompany,
    this.companiesRetrievedStatus = EntityStatus.initial,
    this.projectToCompanyAssignedStatus = EntityStatus.initial,
    this.siteToCompanyAssignedStatus = EntityStatus.initial,
    this.companySitesRetrievedStatus = EntityStatus.initial,
    this.projectCompaniesRetrievedStatus = EntityStatus.initial,
    this.companyCrudStatus = EntityStatus.initial,
    this.companySelectedStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        companies,
        companySites,
        projectCompanies,
        selectedCompany,
        companiesRetrievedStatus,
        siteToCompanyAssignedStatus,
        projectToCompanyAssignedStatus,
        companySitesRetrievedStatus,
        projectCompaniesRetrievedStatus,
        companyCrudStatus,
        companySelectedStatus,
        message,
      ];

  CompaniesState copyWith({
    List<Company>? companies,
    List<CompanySite>? companySites,
    List<ProjectCompany>? projectCompanies,
    Company? selectedCompany,
    EntityStatus? companiesRetrievedStatus,
    EntityStatus? companySelectedStatus,
    EntityStatus? projectToCompanyAssignedStatus,
    EntityStatus? siteToCompanyAssignedStatus,
    EntityStatus? companyCrudStatus,
    EntityStatus? projectCompaniesRetrievedStatus,
    EntityStatus? companySitesRetrievedStatus,
    String? message,
  }) {
    return CompaniesState(
      companies: companies ?? this.companies,
      companySites: companySites ?? this.companySites,
      projectCompanies: projectCompanies ?? this.projectCompanies,
      companySitesRetrievedStatus:
          companySitesRetrievedStatus ?? this.companySitesRetrievedStatus,
      projectCompaniesRetrievedStatus: projectCompaniesRetrievedStatus ??
          this.projectCompaniesRetrievedStatus,
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
