import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/data/repository/repository.dart';
import '/data/model/model.dart';

part 'companies_event.dart';
part 'companies_state.dart';

class CompaniesBloc extends Bloc<CompaniesEvent, CompaniesState> {
  CompaniesRepository companiesRepository;

  static String addErrorMessage =
      'There was an error while adding company. Our team has been notified. Please wait a few minutes and try again.';
  static String editErrorMessage =
      'There was an error while editing company. Our team has been notified. Please wait a few minutes and try again.';
  static String deleteErrorMessage =
      'There was an error while deleting company. Our team has been notified. Please wait a few minutes and try again.';
  CompaniesBloc({
    required this.companiesRepository,
  }) : super(const CompaniesState()) {
    _triggerEvents();
  }

  void _triggerEvents() {
    on<CompaniesRetrieved>(_onCompaniesRetrieved);
    on<AssignedCompanySitesRetrieved>(_onAssignedCompanySitesRetrieved);
    on<AssignedProjectCompaniesRetrieved>(_onAssignedProjectCompaniesRetrieved);
    on<UnassignedCompanySitesRetrieved>(_onUnassignedCompanySitesRetrieved);
    on<UnassignedProjectCompaniesRetrieved>(
        _onUnassignedProjectCompaniesRetrieved);
    on<CompanySelected>(_onCompanySelected);
    on<SiteToCompanyAssigned>(_onSiteToCompanyAssigned);
    on<ProjectToCompanyAssigned>(_onProjectToCompanyAssigned);
    on<CompanySelectedById>(_onCompanySelectedById);
    on<CompanyAdded>(_onCompanyAdded);
    on<CompanyEdited>(_onCompanyEdited);
    on<CompanyDeleted>(_onCompanyDeleted);
    on<CompaniesSorted>(_onCompaniesSorted);
    on<CompaniesStatusInited>(_onCompaniesStatusInited);
  }

  Future<void> _onCompaniesRetrieved(
    CompaniesRetrieved event,
    Emitter<CompaniesState> emit,
  ) async {
    emit(state.copyWith(companiesRetrievedStatus: EntityStatus.loading));
    try {
      List<Company> companies = await companiesRepository.getCompanies();
      emit(state.copyWith(
        companies: companies,
        companiesRetrievedStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(companiesRetrievedStatus: EntityStatus.failure));
    }
  }

  Future<void> _onAssignedCompanySitesRetrieved(
    AssignedCompanySitesRetrieved event,
    Emitter<CompaniesState> emit,
  ) async {
    emit(state.copyWith(
        assignedCompanySitesRetrievedStatus: EntityStatus.loading));
    try {
      List<CompanySite> companySites = await companiesRepository
          .getCompanySites(event.companyId, true, event.name);
      emit(state.copyWith(
        assignedCompanySites: companySites,
        assignedCompanySitesRetrievedStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
          assignedCompanySitesRetrievedStatus: EntityStatus.failure));
    }
  }

  Future<void> _onUnassignedCompanySitesRetrieved(
    UnassignedCompanySitesRetrieved event,
    Emitter<CompaniesState> emit,
  ) async {
    emit(state.copyWith(
        unassignedCompanySitesRetrievedStatus: EntityStatus.loading));
    try {
      List<CompanySite> companySites = await companiesRepository
          .getCompanySites(event.companyId, false, event.name);
      emit(state.copyWith(
        unassignedCompanySites: companySites,
        unassignedCompanySitesRetrievedStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
          unassignedCompanySitesRetrievedStatus: EntityStatus.failure));
    }
  }

  Future<void> _onAssignedProjectCompaniesRetrieved(
    AssignedProjectCompaniesRetrieved event,
    Emitter<CompaniesState> emit,
  ) async {
    emit(state.copyWith(
        assignedProjectCompaniesRetrievedStatus: EntityStatus.loading));
    try {
      List<ProjectCompany> projectCompanies = await companiesRepository
          .getProjectCompanies(event.companyId, true, event.name);
      emit(state.copyWith(
        assignedProjectCompanies: projectCompanies,
        assignedProjectCompaniesRetrievedStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
          assignedProjectCompaniesRetrievedStatus: EntityStatus.failure));
    }
  }

  Future<void> _onUnassignedProjectCompaniesRetrieved(
    UnassignedProjectCompaniesRetrieved event,
    Emitter<CompaniesState> emit,
  ) async {
    emit(state.copyWith(
        unassignedProjectCompaniesRetrievedStatus: EntityStatus.loading));
    try {
      List<ProjectCompany> projectCompanies = await companiesRepository
          .getProjectCompanies(event.companyId, false, event.name);
      emit(state.copyWith(
        assignedProjectCompanies: projectCompanies,
        unassignedProjectCompaniesRetrievedStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
          unassignedProjectCompaniesRetrievedStatus: EntityStatus.failure));
    }
  }

  void _onCompanySelected(
    CompanySelected event,
    Emitter<CompaniesState> emit,
  ) {
    emit(state.copyWith(selectedCompany: event.selectedCompany));
  }

  Future<void> _onCompanySelectedById(
    CompanySelectedById event,
    Emitter<CompaniesState> emit,
  ) async {
    emit(state.copyWith(
      companySelectedStatus: EntityStatus.loading,
    ));
    try {
      Company selectedCompany =
          await companiesRepository.getCompanyById(event.companyId);
      emit(state.copyWith(
        companySelectedStatus: EntityStatus.success,
        selectedCompany: selectedCompany,
      ));
    } catch (e) {
      emit(state.copyWith(
        companySelectedStatus: EntityStatus.failure,
        selectedCompany: null,
      ));
    }
  }

  Future<void> _onSiteToCompanyAssigned(
    SiteToCompanyAssigned event,
    Emitter<CompaniesState> emit,
  ) async {
    emit(state.copyWith(siteToCompanyAssignedStatus: EntityStatus.loading));
    try {
      EntityResponse response = await companiesRepository
          .assignSiteToCompany(event.companySiteUpdation);
      if (response.isSuccess) {
        emit(state.copyWith(siteToCompanyAssignedStatus: EntityStatus.success));
      } else {
        emit(state.copyWith(siteToCompanyAssignedStatus: EntityStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(siteToCompanyAssignedStatus: EntityStatus.failure));
    }
  }

  Future<void> _onProjectToCompanyAssigned(
    ProjectToCompanyAssigned event,
    Emitter<CompaniesState> emit,
  ) async {
    emit(state.copyWith(projectToCompanyAssignedStatus: EntityStatus.loading));
    try {
      EntityResponse response = await companiesRepository
          .assignProjectToCompany(event.projectCompanyAssignment);
      if (response.isSuccess) {
        emit(state.copyWith(
            projectToCompanyAssignedStatus: EntityStatus.success));
      } else {
        emit(state.copyWith(
            projectToCompanyAssignedStatus: EntityStatus.failure));
      }
    } catch (e) {
      emit(
          state.copyWith(projectToCompanyAssignedStatus: EntityStatus.failure));
    }
  }

  Future<void> _onCompanyAdded(
    CompanyAdded event,
    Emitter<CompaniesState> emit,
  ) async {
    emit(state.copyWith(companyCrudStatus: EntityStatus.loading));
    try {
      EntityResponse response =
          await companiesRepository.addCompany(event.company);
      if (response.isSuccess) {
        emit(state.copyWith(
          companyCrudStatus: EntityStatus.success,
          message: response.message,
          selectedCompany:
              state.selectedCompany!.copyWith(id: response.data!.id),
        ));
      } else {
        emit(state.copyWith(
          companyCrudStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        companyCrudStatus: EntityStatus.failure,
        message: addErrorMessage,
      ));
    }
  }

  Future<void> _onCompanyEdited(
    CompanyEdited event,
    Emitter<CompaniesState> emit,
  ) async {
    emit(state.copyWith(companyCrudStatus: EntityStatus.loading));
    try {
      EntityResponse response =
          await companiesRepository.editCompany(event.company);
      if (response.isSuccess) {
        emit(state.copyWith(
          companyCrudStatus: EntityStatus.success,
          message: response.message,
          selectedCompany: null,
        ));
      } else {
        emit(state.copyWith(
          companyCrudStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        companyCrudStatus: EntityStatus.failure,
        message: addErrorMessage,
      ));
    }
  }

  Future<void> _onCompanyDeleted(
    CompanyDeleted event,
    Emitter<CompaniesState> emit,
  ) async {
    emit(state.copyWith(companyCrudStatus: EntityStatus.loading));
    try {
      EntityResponse response =
          await companiesRepository.deleteCompany(event.companyId);
      if (response.isSuccess) {
        emit(state.copyWith(
          companyCrudStatus: EntityStatus.success,
          selectedCompany: null,
          message: response.message,
        ));
      } else {
        emit(state.copyWith(
          companyCrudStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        companyCrudStatus: EntityStatus.failure,
        message: deleteErrorMessage,
      ));
    }
  }

  void _onCompaniesSorted(
    CompaniesSorted event,
    Emitter<CompaniesState> emit,
  ) {
    List<Company> companies = List.from(state.companies);

    companies.sort(
      (a, b) {
        return (event.sortType ? 1 : -1) *
            (a.tableItemsToMap()[event.column].toString())
                .compareTo(b.tableItemsToMap()[event.column].toString());
      },
    );
    emit(state.copyWith(companies: companies));
  }

  void _onCompaniesStatusInited(
    CompaniesStatusInited event,
    Emitter<CompaniesState> emit,
  ) {
    emit(state.copyWith(
      companyCrudStatus: EntityStatus.initial,
      companySelectedStatus: EntityStatus.initial,
      companiesRetrievedStatus: EntityStatus.initial,
    ));
  }
}
