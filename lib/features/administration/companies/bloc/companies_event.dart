// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'companies_bloc.dart';

abstract class CompaniesEvent extends Equatable {
  const CompaniesEvent();

  @override
  List<Object?> get props => [];
}

/// event to load company list
class CompanyListLoaded extends CompaniesEvent {}

/// event to load filtered company list
class CompanyListFiltered extends CompaniesEvent {
  final FilteredTableParameter option;
  const CompanyListFiltered({required this.option});

  @override
  List<Object?> get props => [option];
}

/// event to select company
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

/// event to load company detail
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

/// delete company by id
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

/// event to sort company list
class CompaniesSorted extends CompaniesEvent {
  final List<Company> companies;
  const CompaniesSorted({required this.companies});

  @override
  List<Object?> get props => [
        companies,
      ];
}

/// event to init state
class CompaniesStatusInited extends CompaniesEvent {}

/// event to load assigned company site list
class AssignedCompanySitesLoaded extends CompaniesEvent {
  final String companyId;
  final String? name;
  const AssignedCompanySitesLoaded({
    required this.companyId,
    this.name,
  });
  @override
  List<Object?> get props => [
        companyId,
        name,
      ];
}

/// event to load unassigned company site list
class UnassignedCompanySitesLoaded extends CompaniesEvent {
  final String companyId;
  final String? name;
  const UnassignedCompanySitesLoaded({
    required this.companyId,
    this.name,
  });
  @override
  List<Object?> get props => [
        companyId,
        name,
      ];
}

/// event to load assigned project company list
class AssignedProjectCompanyListLoaded extends CompaniesEvent {
  final String companyId;
  final String? name;
  final String? siteId;
  final bool forFilter;
  const AssignedProjectCompanyListLoaded({
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

/// event to load unassigned project company list
class UnassignedProjectCompanyListLoaded extends CompaniesEvent {
  final String companyId;
  final String? name;
  final String? siteId;
  final bool forFilter;
  const UnassignedProjectCompanyListLoaded({
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

/// event to assign site to company
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

/// event to unassign site from company
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

/// event to assign project to company
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

/// event to unassign project from company
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

/// event to select role 
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

/// event to change filter text to filter assigned company list
class FilterTextForAssignedChanged extends CompaniesEvent {
  final String filterText;
  const FilterTextForAssignedChanged({
    required this.filterText,
  });

  @override
  List<Object?> get props => [filterText];
}

/// event to change filter text to filter unassigned company list
class FilterTextForUnassignedChanged extends CompaniesEvent {
  final String filterText;
  const FilterTextForUnassignedChanged({
    required this.filterText,
  });

  @override
  List<Object?> get props => [filterText];
}

/// event to change site to filter unassigned company list
class FilterSiteIdForUnassignedChanged extends CompaniesEvent {
  final String siteId;
  const FilterSiteIdForUnassignedChanged({
    required this.siteId,
  });

  @override
  List<Object?> get props => [siteId];
}

/// event to change site to filter assigned company list
class FilterSiteIdForAssignedChanged extends CompaniesEvent {
  final String siteId;
  const FilterSiteIdForAssignedChanged({
    required this.siteId,
  });

  @override
  List<Object?> get props => [siteId];
}

/// event to load audit trails by company id
class AuditTrailsLoadedByCompanyId extends CompaniesEvent {
  final String companyId;
  const AuditTrailsLoadedByCompanyId({
    required this.companyId,
  });

  @override
  List<Object?> get props => [companyId];
}
