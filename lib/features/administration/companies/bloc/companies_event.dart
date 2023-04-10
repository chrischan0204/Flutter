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
