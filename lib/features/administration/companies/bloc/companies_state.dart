part of 'companies_bloc.dart';

class CompaniesState extends Equatable {
  final List<Company> companies;
  final EntityStatus companyCompaniesRetrievedStatus;
  final Company? selectedCompany;
  final EntityStatus companiesRetrievedStatus;
  final EntityStatus companySelectedStatus;
  final EntityStatus companyCrudStatus;
  final String message;
  const CompaniesState({
    this.companies = const [],
    this.selectedCompany,
    this.companiesRetrievedStatus = EntityStatus.initial,
    this.companyCrudStatus = EntityStatus.initial,
    this.companySelectedStatus = EntityStatus.initial,
    this.companyCompaniesRetrievedStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        companies,
        selectedCompany,
        companiesRetrievedStatus,
        companyCrudStatus,
        companySelectedStatus,
        companyCompaniesRetrievedStatus,
        message,
      ];

  CompaniesState copyWith({
    List<Company>? companies,
    Company? selectedCompany,
    EntityStatus? companiesRetrievedStatus,
    EntityStatus? companySelectedStatus,
    EntityStatus? companyCrudStatus,
    EntityStatus? companyCompaniesRetrievedStatus,
    String? message,
  }) {
    return CompaniesState(
      companies: companies ?? this.companies,
      selectedCompany: selectedCompany ?? this.selectedCompany,
      companiesRetrievedStatus:
          companiesRetrievedStatus ?? this.companiesRetrievedStatus,
      companySelectedStatus:
          companySelectedStatus ?? this.companySelectedStatus,
      companyCrudStatus: companyCrudStatus ?? this.companyCrudStatus,
      companyCompaniesRetrievedStatus: companyCompaniesRetrievedStatus ?? this.companyCompaniesRetrievedStatus,
      message: message ?? this.message,
    );
  }
}
