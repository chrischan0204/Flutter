import '/common_libraries.dart';

class CompaniesListView extends StatefulWidget {
  const CompaniesListView({super.key});

  @override
  State<CompaniesListView> createState() => _CompaniesListViewState();
}

class _CompaniesListViewState extends State<CompaniesListView> {
  late CompaniesBloc companiesBloc;

  static String pageTitle = 'Companies';
  static String pageLabel = 'company';
  static String emptyMessage =
      'There are no companies. Please click on New Company to add new company';

  @override
  void initState() {
    companiesBloc = context.read<CompaniesBloc>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterSettingBloc, FilterSettingState>(
      builder: (context, filterSettingState) =>
          BlocBuilder<CompaniesBloc, CompaniesState>(
        builder: (context, state) {
          return EntityListTemplate(
            title: pageTitle,
            label: pageLabel,
            viewName: pageLabel,
            entities: state.companies,
            showTableHeaderButtons: true,
            onRowClick: (selectedCompany) => _selectCompany(selectedCompany),
            emptyMessage: emptyMessage,
            entityListLoadStatusLoading:
                filterSettingState.filterSettingLoading ||
                    state.companiesRetrievedStatus.isLoading,
            entityDetailLoadStatusLoading:
                state.companySelectedStatus.isLoading,
            selectedEntity: state.selectedCompany,
            onTableSorted: (sortedCompanies) => _sortCompanies(sortedCompanies),
            onViewSettingApplied: () => _filterCompanies(),
            onIncludeDeletedChanged: (value) => _filterCompanies(null, value),
            onFilterSaved: _filterCompanies,
            onFilterApplied: _filterCompanies,
          );
        },
      ),
    );
  }

  void _sortCompanies(List<Entity> sortedCompanies) {
    companiesBloc.add(CompaniesSorted(
        companies: sortedCompanies
            .map((sortedCompany) => sortedCompany as Company)
            .toList()));
  }

  void _selectCompany(Entity selectedCompany) {
    companiesBloc.add(CompanySelectedById(companyId: selectedCompany.id!));
  }

  void _filterCompanies([
    String? filterId,
    bool? includeDeleted,
  ]) {
    final FilterSettingBloc filterSettingBloc = context.read();
    companiesBloc.add(CompanyListFiltered(
      filterId: filterId ??
          filterSettingBloc.state.selectedUserFilterSetting?.id ??
          emptyGuid,
      includeDeleted: includeDeleted ?? filterSettingBloc.state.includeDeleted,
    ));
  }
}
