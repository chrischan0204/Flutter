import '/common_libraries.dart';

class SitesListView extends StatefulWidget {
  const SitesListView({super.key});

  @override
  State<SitesListView> createState() => _SitesListViewState();
}

class _SitesListViewState extends State<SitesListView> {
  late SitesBloc sitesBloc;

  static String pageTitle = 'Sites';
  static String pageLabel = 'site';
  static String emptyMessage =
      'There are no sites. Please click New Site to add new site.';

  @override
  void initState() {
    sitesBloc = context.read<SitesBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterSettingBloc, FilterSettingState>(
      builder: (context, filterSettingState) =>
          BlocBuilder<SitesBloc, SitesState>(
        builder: (context, state) {
          return EntityListTemplate(
            title: pageTitle,
            label: pageLabel,
            viewName: pageLabel,
            entities: state.sites,
            showTableHeaderButtons: true,
            onRowClick: (selectedSite) =>
                sitesBloc.add(SiteSelectedById(siteId: selectedSite.id!)),
            emptyMessage: emptyMessage,
            entityListLoadStatusLoading:
                filterSettingState.filterSettingLoading ||
                    state.sitesRetrievedStatus.isLoading,
            entityDetailLoadStatusLoading: state.siteSelectedStatus.isLoading,
            selectedEntity: state.selectedSite,
            onViewSettingApplied: () => _filterSites(),
            onIncludeDeletedChanged: (value) => _filterSites(null, value, 1),
            onFilterSaved: (value) => _filterSites(value, null, 1),
            onFilterApplied: ([value]) => _filterSites(value, null, 1),
            onPaginate: (pageNum, pageRow) =>
                _filterSites(null, null, pageNum, pageRow),
            totalRows: state.totalRows,
          );
        },
      ),
    );
  }

  void _filterSites([
    String? filterId,
    bool? includeDeleted,
    int? pageNum,
    int? rowPerPage,
  ]) {
    final FilterSettingBloc filterSettingBloc = context.read();
    final PaginationBloc paginationBloc = context.read();
    sitesBloc.add(SiteListFiltered(
      filterId: filterId ??
          filterSettingBloc.state.appliedUserFilterSetting?.id ??
          emptyGuid,
      includeDeleted: includeDeleted ?? filterSettingBloc.state.includeDeleted,
      pageNum: pageNum ?? paginationBloc.state.selectedPageNum,
      pageSize: rowPerPage ?? paginationBloc.state.rowsPerPage,
    ));
  }
}
