import '/common_libraries.dart';

part 'companies_event.dart';
part 'companies_state.dart';

class CompaniesBloc extends Bloc<CompaniesEvent, CompaniesState> {
  CompaniesRepository companiesRepository;

  static String deleteErrorMessage = ErrorMessage('company').delete;
  static String assignSiteToCompanyErrorMessage =
      ErrorMessage('company').assign('site');
  static String assignProjectToCompanyErrorMessage =
      ErrorMessage('company').assign('project');

  CompaniesBloc({
    required this.companiesRepository,
  }) : super(const CompaniesState()) {
    _triggerEvents();
  }

  void _triggerEvents() {
    on<CompaniesRetrieved>(_onCompaniesRetrieved);
    on<AssignedCompanySitesRetrieved>(_onAssignedCompanySitesRetrieved);
    on<CompanyListFiltered>(_onCompanyListFiltered);
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
    on<CompanyDeleted>(_onCompanyDeleted);
    on<CompaniesSorted>(_onCompaniesSorted);
    on<UnAssignedProjectCompanyRoleSelected>(
        _onUnAssignedProjectCompanyRoleSelected);
    on<CompaniesStatusInited>(_onCompaniesStatusInited);
    on<FilterTextForAssignedChanged>(_onFilterTextAssignedChanged);
    on<FilterTextForUnassignedChanged>(_onFilterTextUnassignedChanged);
    on<FilterSiteIdForUnassignedChanged>(_onFilterSiteIdForUnassignedChanged);
    on<FilterSiteIdForAssignedChanged>(_onFilterSiteIdForAssignedChanged);
    on<AuditTrailsRetrievedByCompanyId>(_onAuditTrailsRetrievedByCompanyId);
  }

  // get companies list from repository
  Future<void> _onCompaniesRetrieved(
    CompaniesRetrieved event,
    Emitter<CompaniesState> emit,
  ) async {
    emit(state.copyWith(companiesRetrievedStatus: EntityStatus.loading));
    try {
      List<Company> companies = await companiesRepository.getCompanyList();
      emit(state.copyWith(
        companies: companies,
        companiesRetrievedStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(companiesRetrievedStatus: EntityStatus.failure));
    }
  }

  Future<void> _onCompanyListFiltered(
    CompanyListFiltered event,
    Emitter<CompaniesState> emit,
  ) async {
    emit(state.copyWith(companiesRetrievedStatus: EntityStatus.loading));

    try {
      FilteredCompanyData data =
          await companiesRepository.getFilteredCompanyList(event.option);
      final List<String> columns =
          List.from(data.headers.where((e) => !e.isHidden).map((e) => e.title));
      return emit(state.copyWith(
        totalRows: data.totalRows,
        companies: data.data
            .map((e) => e.toCompany().copyWith(columns: columns))
            .toList(),
        companiesRetrievedStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(companiesRetrievedStatus: EntityStatus.failure));
    }
  }

  // get assigned sites list to company
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

  // get unassigned sites list from company
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

  // get assigned projects list to company
  Future<void> _onAssignedProjectCompaniesRetrieved(
    AssignedProjectCompaniesRetrieved event,
    Emitter<CompaniesState> emit,
  ) async {
    emit(state.copyWith(
        assignedProjectCompaniesRetrievedStatus: EntityStatus.loading));
    try {
      List<ProjectCompany> projectCompanies = await companiesRepository
          .getProjectCompanies(event.companyId, true, event.name, event.siteId);
      emit(state.copyWith(
        assignedProjectCompanies: projectCompanies,
        assignedProjectCompaniesRetrievedStatus: EntityStatus.success,
        assignedProjectCompaniesForFilter:
            event.forFilter ? projectCompanies : null,
      ));
    } catch (e) {
      emit(state.copyWith(
          assignedProjectCompaniesRetrievedStatus: EntityStatus.failure));
    }
  }

  // get unassigned projects list from company
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
        unassignedProjectCompaniesForFilter:
            event.forFilter ? projectCompanies : null,
      ));
    } catch (e) {
      emit(state.copyWith(
          unassignedProjectCompaniesRetrievedStatus: EntityStatus.failure));
    }
  }

  // select company to add or edit
  void _onCompanySelected(
    CompanySelected event,
    Emitter<CompaniesState> emit,
  ) {
    emit(state.copyWith(selectedCompany: event.selectedCompany));
  }

  // get company details by id
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

  // assign site to company
  Future<void> _onSiteToCompanyAssigned(
    SiteToCompanyAssigned event,
    Emitter<CompaniesState> emit,
  ) async {
    emit(state.copyWith(siteToCompanyAssignedStatus: EntityStatus.loading));
    List<CompanySite> unassignedCompanySites = state.unassignedCompanySites;
    final result = unassignedCompanySites.firstWhere(
      (unassignedCompanySite) =>
          unassignedCompanySite.companyId ==
              event.companySiteUpdation.companyId &&
          unassignedCompanySite.siteId == event.companySiteUpdation.siteId,
    );
    try {
      result.assigned = true;

      EntityResponse response = await companiesRepository.assignSiteToCompany(
          event.companySiteUpdation
              .copyWith(roleId: 'd0f55a78-1244-4a29-b52a-32f0d9026a9d'));
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
        result.assigned = false;
      }
    } catch (e) {
      emit(state.copyWith(
        siteToCompanyAssignedStatus: EntityStatus.failure,
        message: assignSiteToCompanyErrorMessage,
      ));
      result.assigned = false;
    }
  }

  // unassign site from company
  Future<void> _onSiteFromCompanyUnassigned(
    SiteFromCompanyUnassigned event,
    Emitter<CompaniesState> emit,
  ) async {
    emit(state.copyWith(siteFromCompanyUnassignedStatus: EntityStatus.loading));
    List<CompanySite> assignedCompanySites = state.assignedCompanySites;
    final result = assignedCompanySites.firstWhere(
      (assignedCompanySite) =>
          assignedCompanySite.id == event.companySiteUpdationId,
    );
    try {
      result.assigned = false;
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
        result.assigned = true;
      }
    } catch (e) {
      emit(state.copyWith(
          siteFromCompanyUnassignedStatus: EntityStatus.failure));
      result.assigned = true;
    }
  }

  // assign project to compnay
  Future<void> _onProjectToCompanyAssigned(
    ProjectToCompanyAssigned event,
    Emitter<CompaniesState> emit,
  ) async {
    emit(state.copyWith(projectToCompanyAssignedStatus: EntityStatus.loading));
    final result = state.unassignedProjectCompanies.firstWhere(
      (unassignedProjectCompany) =>
          unassignedProjectCompany.roleId ==
              event.projectCompanyAssignment.roleId &&
          unassignedProjectCompany.projectId ==
              event.projectCompanyAssignment.projectId,
    );

    try {
      result.assigned = true;
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
        result.assigned = false;
      }
    } catch (e) {
      emit(state.copyWith(
        projectToCompanyAssignedStatus: EntityStatus.failure,
        message: assignProjectToCompanyErrorMessage,
      ));
      result.assigned = false;
    }
  }

  // unassign project from company
  Future<void> _onProjectFromCompanyUnassigned(
    ProjectFromCompanyUnassigned event,
    Emitter<CompaniesState> emit,
  ) async {
    emit(state.copyWith(
        projectFromCompanyUnassignedStatus: EntityStatus.loading));

    final result = state.assignedProjectCompanies.firstWhere(
        (assignedProjectCompany) =>
            assignedProjectCompany.id == event.projectCompanyAssignmentId);
    result.assigned = false;
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
        result.assigned = true;
      }
    } catch (e) {
      emit(state.copyWith(
          projectFromCompanyUnassignedStatus: EntityStatus.failure));
      result.assigned = true;
    }
  }

  // delete company
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

  // sort companies list by column alphabetically
  void _onCompaniesSorted(
    CompaniesSorted event,
    Emitter<CompaniesState> emit,
  ) {
    emit(state.copyWith(companies: event.companies));
  }

  // init company state status
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

  // change role id on project company DTO
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

  /// change the filter text
  void _onFilterTextAssignedChanged(
    FilterTextForAssignedChanged event,
    Emitter<CompaniesState> emit,
  ) {
    emit(state.copyWith(filterTextForAssigned: event.filterText));
  }

  void _onFilterTextUnassignedChanged(
    FilterTextForUnassignedChanged event,
    Emitter<CompaniesState> emit,
  ) {
    emit(state.copyWith(filterTextForUnassigned: event.filterText));
  }

  // change the filter site id for assigned project
  void _onFilterSiteIdForAssignedChanged(
    FilterSiteIdForAssignedChanged event,
    Emitter<CompaniesState> emit,
  ) {
    emit(state.copyWith(filterSiteIdForAssigned: event.siteId));
  }

  // change the filter site id
  void _onFilterSiteIdForUnassignedChanged(
    FilterSiteIdForUnassignedChanged event,
    Emitter<CompaniesState> emit,
  ) {
    emit(state.copyWith(filterSiteIdForUnassigned: event.siteId));
  }

  void _onAuditTrailsRetrievedByCompanyId(
    AuditTrailsRetrievedByCompanyId event,
    Emitter<CompaniesState> emit,
  ) async {
    emit(state.copyWith(auditTrailsRerievedStatus: EntityStatus.loading));

    try {
      List<AuditTrail> auditTrails =
          await companiesRepository.getAuditTrailsByCompanyId(event.companyId);
      emit(state.copyWith(
        auditTrails: auditTrails,
        auditTrailsRerievedStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        auditTrailsRerievedStatus: EntityStatus.failure,
        auditTrails: [],
      ));
    }
  }
}
