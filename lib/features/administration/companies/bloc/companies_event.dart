// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'companies_bloc.dart';

abstract class CompaniesEvent extends Equatable {
  const CompaniesEvent();

  @override
  List<Object?> get props => [];
}

class CompaniesRetrieved extends CompaniesEvent {}

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

class CompanyAdded extends CompaniesEvent {
  final Company company;
  const CompanyAdded({
    required this.company,
  });
  @override
  List<Object?> get props => [
        company,
      ];
}

class CompanyEdited extends CompaniesEvent {
  final Company company;
  const CompanyEdited({
    required this.company,
  });
  @override
  List<Object?> get props => [
        company,
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
  final String column;
  final bool sortType;
  const CompaniesSorted({
    required this.column,
    required this.sortType,
  });

  @override
  List<Object?> get props => [
        column,
        sortType,
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
  const AssignedProjectCompaniesRetrieved({
    required this.companyId,
    this.name,
  });
  @override
  List<Object?> get props => [
        companyId,
        name,
      ];
}

class UnassignedProjectCompaniesRetrieved extends CompaniesEvent {
  final String companyId;
  final String? name;
  const UnassignedProjectCompaniesRetrieved({
    required this.companyId,
    this.name,
  });
  @override
  List<Object?> get props => [
        companyId,
        name,
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
