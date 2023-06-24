// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'companies_bloc.dart';

abstract class CompaniesEvent extends Equatable {
  const CompaniesEvent();

  @override
  List<Object?> get props => [];
}

class CompaniesRetrieved extends CompaniesEvent {}

class CompanyListFiltered extends CompaniesEvent {
  final FilteredTableParameter option;
  const CompanyListFiltered({required this.option});

  @override
  List<Object?> get props => [option];
}

class CompanySelected extends CompaniesEvent {
  final Company? selectedCompany;
  const CompanySelected({
    required this.selectedCompany,
  });
  @override
  List<Object?> get props => [
        selectedCompany,
      ];
}

class CompanySelectedById extends CompaniesEvent {
  final String companyId;
  const CompanySelectedById({
    required this.companyId,
  });
  @override
  List<Object?> get props => [
        companyId,
      ];
}

class CompanyDeleted extends CompaniesEvent {
  final String companyId;
  const CompanyDeleted({
    required this.companyId,
  });
  @override
  List<Object?> get props => [
        companyId,
      ];
}

class CompaniesSorted extends CompaniesEvent {
  final List<Company> companies;
  const CompaniesSorted({required this.companies});

  @override
  List<Object?> get props => [
        companies,
      ];
}

class CompaniesStatusInited extends CompaniesEvent {}

class AssignedCompanySitesRetrieved extends CompaniesEvent {
  final String companyId;
  final String? name;
  const AssignedCompanySitesRetrieved({
    required this.companyId,
    this.name,
  });
  @override
  List<Object?> get props => [
        companyId,
        name,
      ];
}

class UnassignedCompanySitesRetrieved extends CompaniesEvent {
  final String companyId;
  final String? name;
  const UnassignedCompanySitesRetrieved({
    required this.companyId,
    this.name,
  });
  @override
  List<Object?> get props => [
        companyId,
        name,
      ];
}

class AssignedProjectCompaniesRetrieved extends CompaniesEvent {
  final String companyId;
  final String? name;
  final String? siteId;
  final bool forFilter;
  const AssignedProjectCompaniesRetrieved({
    required this.companyId,
    this.name,
    this.siteId,
    this.forFilter = false,
  });
  @override
  List<Object?> get props => [
        companyId,
        name,
        siteId,
        forFilter,
      ];
}

class UnassignedProjectCompaniesRetrieved extends CompaniesEvent {
  final String companyId;
  final String? name;
  final String? siteId;
  final bool forFilter;
  const UnassignedProjectCompaniesRetrieved({
    required this.companyId,
    this.name,
    this.siteId,
    this.forFilter = false,
  });
  @override
  List<Object?> get props => [
        companyId,
        name,
        siteId,
        forFilter,
      ];
}

class SiteToCompanyAssigned extends CompaniesEvent {
  final CompanySiteUpdation companySiteUpdation;
  const SiteToCompanyAssigned({
    required this.companySiteUpdation,
  });
  @override
  List<Object?> get props => [
        companySiteUpdation,
      ];
}

class SiteFromCompanyUnassigned extends CompaniesEvent {
  final String companySiteUpdationId;
  const SiteFromCompanyUnassigned({
    required this.companySiteUpdationId,
  });
  @override
  List<Object?> get props => [
        companySiteUpdationId,
      ];
}

class ProjectToCompanyAssigned extends CompaniesEvent {
  final ProjectCompanyAssignment projectCompanyAssignment;
  const ProjectToCompanyAssigned({
    required this.projectCompanyAssignment,
  });
  @override
  List<Object?> get props => [
        projectCompanyAssignment,
      ];
}

class ProjectFromCompanyUnassigned extends CompaniesEvent {
  final String projectCompanyAssignmentId;
  const ProjectFromCompanyUnassigned({
    required this.projectCompanyAssignmentId,
  });
  @override
  List<Object?> get props => [
        projectCompanyAssignmentId,
      ];
}

class UnAssignedProjectCompanyRoleSelected extends CompaniesEvent {
  final Role role;
  final int projectCompanyIndex;
  const UnAssignedProjectCompanyRoleSelected({
    required this.role,
    required this.projectCompanyIndex,
  });

  @override
  List<Object?> get props => [
        role,
        projectCompanyIndex,
      ];
}

class FilterTextForAssignedChanged extends CompaniesEvent {
  final String filterText;
  const FilterTextForAssignedChanged({
    required this.filterText,
  });

  @override
  List<Object?> get props => [filterText];
}

class FilterTextForUnassignedChanged extends CompaniesEvent {
  final String filterText;
  const FilterTextForUnassignedChanged({
    required this.filterText,
  });

  @override
  List<Object?> get props => [filterText];
}

class FilterSiteIdForUnassignedChanged extends CompaniesEvent {
  final String siteId;
  const FilterSiteIdForUnassignedChanged({
    required this.siteId,
  });

  @override
  List<Object?> get props => [siteId];
}

class FilterSiteIdForAssignedChanged extends CompaniesEvent {
  final String siteId;
  const FilterSiteIdForAssignedChanged({
    required this.siteId,
  });

  @override
  List<Object?> get props => [siteId];
}

class AuditTrailsRetrievedByCompanyId extends CompaniesEvent {
  final String companyId;
  const AuditTrailsRetrievedByCompanyId({
    required this.companyId,
  });

  @override
  List<Object?> get props => [companyId];
}
