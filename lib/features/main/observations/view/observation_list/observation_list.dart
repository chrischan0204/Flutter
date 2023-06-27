import '/common_libraries.dart';

class ObservationListView extends StatefulWidget {
  const ObservationListView({super.key});

  @override
  State<ObservationListView> createState() => _ObservationListViewState();
}

class _ObservationListViewState extends State<ObservationListView> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ObservationListBloc(context)),
      ],
      child: const ObservationListWidget(),
    );
  }
}

class ObservationListWidget extends StatefulWidget {
  const ObservationListWidget({super.key});

  @override
  State<ObservationListWidget> createState() => _ObservationListState();
}

class _ObservationListState extends State<ObservationListWidget> {
  late ObservationListBloc observationListBloc;
  // late ObservationDetailBloc observationDetailBloc;

  static String pageTitle = 'Observations';
  static String pageLabel = 'observation';
  static String emptyMessage =
      'There are no observations. Please click on New Observation to add new observation';

  @override
  void initState() {
    observationListBloc = context.read<ObservationListBloc>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterSettingBloc, FilterSettingState>(
      builder: (context, filterSettingState) =>
          BlocBuilder<ObservationListBloc, ObservationListState>(
        builder: (context, observationListState) {
          return EntityListTemplate(
            title: pageTitle,
            label: pageLabel,
            viewName: pageLabel,
            entities: observationListState.observationList,
            showTableHeaderButtons: true,
            onRowClick: (selectedObservation) =>
                _selectObservation(selectedObservation),
            emptyMessage: emptyMessage,
            entityListLoadStatusLoading:
                filterSettingState.filterSettingLoading ||
                    observationListState.observationListLoadStatus.isLoading,
            entityDetailLoadStatusLoading:
                observationListState.observationLoadStatus.isLoading,
            selectedEntity: observationListState.observation,
            onViewSettingApplied: () {
              _filterObservations();
            },
            onIncludeDeletedChanged: (value) {
              _filterObservations(null, value, 1);
            },
            onFilterSaved: (value) {
              _filterObservations(value, null, 1);
            },
            onFilterApplied: ([value, withoutSave]) {
              _filterObservations(value, null, 1, null, withoutSave);
            },
            onPaginate: (pageNum, pageRow) {
              _filterObservations(null, null, pageNum, pageRow);
            },
            totalRows: observationListState.totalRows,
          );
        },
      ),
    );
  }

  void _selectObservation(Entity selectedObservation) {
    observationListBloc.add(ObservationListObservationForSideDetailLoaded(
        observationId: selectedObservation.id!));
  }

  void _filterObservations([
    String? filterId,
    bool? includeDeleted,
    int? pageNum,
    int? rowPerPage,
    bool? withoutSave,
  ]) {
    final FilterSettingBloc filterSettingBloc = context.read();
    final PaginationBloc paginationBloc = context.read();
    observationListBloc.add(ObservationListFiltered(
        option: FilteredTableParameter(
      filterId: filterId ??
          filterSettingBloc.state.appliedUserFilterSetting?.id ??
          emptyGuid,
      includeDeleted: includeDeleted ?? filterSettingBloc.state.includeDeleted,
      pageNum: pageNum ?? paginationBloc.state.selectedPageNum,
      pageSize: rowPerPage ?? paginationBloc.state.rowsPerPage,
      filterOption: filterSettingBloc.state.appliedUserFilterSetting != null
          ? filterSettingBloc.state.userFilterUpdate
          : null,
    )));
  }
}
