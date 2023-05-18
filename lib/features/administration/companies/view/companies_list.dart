import '/common_libraries.dart';

class CompaniesListView extends StatefulWidget {
  const CompaniesListView({super.key});

  @override
  State<CompaniesListView> createState() => _CompaniesListViewState();
}

class _CompaniesListViewState extends State<CompaniesListView> {
  late CompaniesBloc companiesBloc;
  late SitesBloc sitesBloc;
  late RegionsBloc regionsBloc;
  late ProjectsBloc projectsBloc;

  static String pageTitle = 'Companies';
  static String pageLabel = 'company';
  static String emptyMessage =
      'There are no companies. Please click on New Company to add new company';

  @override
  void initState() {
    companiesBloc = context.read<CompaniesBloc>()..add(CompaniesRetrieved());
    sitesBloc = context.read<SitesBloc>()..add(SitesRetrieved());
    regionsBloc = context.read<RegionsBloc>()..add(AssignedRegionsRetrieved());
    projectsBloc = context.read<ProjectsBloc>()..add(ProjectsRetrieved());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompaniesBloc, CompaniesState>(
      builder: (context, state) {
        return EntityListTemplate(
          title: pageTitle,
          label: pageLabel,
          viewName: pageLabel,
          entities: state.companies,
          showTableHeaderButtons: true,
          onRowClick: (selectedCompany) => _selectCompany(selectedCompany),
          emptyMessage: emptyMessage,
          entityRetrievedStatus: state.companiesRetrievedStatus,
          selectedEntity: state.selectedCompany,
          onTableSorted: (sortedCompanies) => _sortCompanies(sortedCompanies),
        );
      },
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
}
