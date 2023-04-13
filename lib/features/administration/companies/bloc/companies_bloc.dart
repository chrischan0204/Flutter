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
    on<SiteFromCompanyUnassigned>(_onSiteFromCompanyUnassigned);
    on<ProjectToCompanyAssigned>(_onProjectToCompanyAssigned);
    on<ProjectFromCompanyUnassigned>(_onProjectFromCompanyUnassigned);
    on<CompanySelectedById>(_onCompanySelectedById);
    on<CompanyAdded>(_onCompanyAdded);
    on<CompanyEdited>(_onCompanyEdited);
    on<CompanyDeleted>(_onCompanyDeleted);
    on<CompaniesSorted>(_onCompaniesSorted);
    on<UnAssignedCompanySiteRoleSelected>(_onUnAssignedCompanySiteRoleSelected);
    on<UnAssignedProjectCompanyRoleSelected>(
        _onUnAssignedProjectCompanyRoleSelected);
    on<CompaniesStatusInited>(_onCompaniesStatusInited);
    on<FilterTextChanged>(_onFilterTextChanged);
    on<FilterSiteIdChanged>(_onFilterSiteIdChanged);
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
      List<ProjectCompany> projectCompanies =
          await companiesRepository.getProjectCompanies(
              event.companyId, false, event.name, event.siteId);
      emit(state.copyWith(
        unassignedProjectCompanies: projectCompanies,
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
        emit(state.copyWith(
          siteToCompanyAssignedStatus: EntityStatus.success,
          message: response.message,
        ));
      } else {
        emit(state.copyWith(
          siteToCompanyAssignedStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(siteToCompanyAssignedStatus: EntityStatus.failure));
    }
  }

  Future<void> _onSiteFromCompanyUnassigned(
    SiteFromCompanyUnassigned event,
    Emitter<CompaniesState> emit,
  ) async {
    emit(state.copyWith(siteFromCompanyUnassignedStatus: EntityStatus.loading));
    try {
      EntityResponse response = await companiesRepository
          .unassignSiteFromCompany(event.companySiteUpdationId);
      if (response.isSuccess) {
        emit(state.copyWith(
          siteFromCompanyUnassignedStatus: EntityStatus.success,
          message: response.message,
        ));
      } else {
        emit(state.copyWith(
          siteFromCompanyUnassignedStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
          siteFromCompanyUnassignedStatus: EntityStatus.failure));
    }
  }

  Future<void> _onProjectFromCompanyUnassigned(
    ProjectFromCompanyUnassigned event,
    Emitter<CompaniesState> emit,
  ) async {
    emit(state.copyWith(
        projectFromCompanyUnassignedStatus: EntityStatus.loading));
    try {
      EntityResponse response = await companiesRepository
          .unassignProjectFromCompany(event.projectCompanyAssignmentId);
      if (response.isSuccess) {
        emit(state.copyWith(
          projectFromCompanyUnassignedStatus: EntityStatus.success,
          message: response.message,
        ));
      } else {
        emit(state.copyWith(
          projectFromCompanyUnassignedStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
          projectFromCompanyUnassignedStatus: EntityStatus.failure));
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
          projectToCompanyAssignedStatus: EntityStatus.success,
          message: response.message,
        ));
      } else {
        emit(state.copyWith(
          projectToCompanyAssignedStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      print(e);
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
          selectedCompany:
              state.selectedCompany!.copyWith(id: response.data?.id),
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

  Future<void> _onUnAssignedCompanySiteRoleSelected(
    UnAssignedCompanySiteRoleSelected event,
    Emitter<CompaniesState> emit,
  ) async {
    List<CompanySite> unassignedCompanySites =
        List.from(state.unassignedCompanySites);
    int index = event.companySiteIndex;
    unassignedCompanySites.replaceRange(index, index + 1, [
      unassignedCompanySites[index].copyWith(
        roleId: event.role.id,
        roleName: event.role.name,
      )
    ]);
    emit(state.copyWith(unassignedCompanySites: unassignedCompanySites));
  }

  Future<void> _onUnAssignedProjectCompanyRoleSelected(
    UnAssignedProjectCompanyRoleSelected event,
    Emitter<CompaniesState> emit,
  ) async {
    List<ProjectCompany> unassignedProjectCompanies =
        List.from(state.unassignedProjectCompanies);
    int index = event.projectCompanyIndex;
    unassignedProjectCompanies.replaceRange(index, index + 1, [
      unassignedProjectCompanies[index].copyWith(
        roleId: event.role.id,
        roleName: event.role.name,
      )
    ]);
    emit(
        state.copyWith(unassignedProjectCompanies: unassignedProjectCompanies));
  }

  void _onFilterTextChanged(
    FilterTextChanged event,
    Emitter<CompaniesState> emit,
  ) {
    emit(state.copyWith(filterText: event.filterText));
  }

  void _onFilterSiteIdChanged(
    FilterSiteIdChanged event,
    Emitter<CompaniesState> emit,
  ) {
    emit(state.copyWith(filterSiteId: event.siteId));
  }
}
