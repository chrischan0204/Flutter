import '/common_libraries.dart';

class ActionItemListView extends StatefulWidget {
  const ActionItemListView({super.key});

  @override
  State<ActionItemListView> createState() => _ActionItemListViewState();
}

class _ActionItemListViewState extends State<ActionItemListView> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ActionItemListBloc(context)),
      ],
      child: const ActionItemListWidget(),
    );
  }
}

class ActionItemListWidget extends StatefulWidget {
  const ActionItemListWidget({super.key});

  @override
  State<ActionItemListWidget> createState() => _ActionItemListState();
}

class _ActionItemListState extends State<ActionItemListWidget> {
  late ActionItemListBloc actionItemListBloc;
  // late ActionItemDetailBloc actionItemDetailBloc;

  static String pageTitle = 'Action Items';
  static String pageLabel = 'action item';
  static String emptyMessage =
      'There are no action items. Please click on New ActionItem to add new actionItem';

  @override
  void initState() {
    actionItemListBloc = context.read<ActionItemListBloc>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterSettingBloc, FilterSettingState>(
      builder: (context, filterSettingState) =>
          BlocBuilder<ActionItemListBloc, ActionItemListState>(
        builder: (context, state) {
          return EntityListTemplate(
            title: pageTitle,
            label: pageLabel,
            viewName: 'actionItem',
            entities: state.actionItemList,
            showTableHeaderButtons: true,
            onRowClick: (selectedActionItem) =>
                _selectActionItem(selectedActionItem),
            emptyMessage: emptyMessage,
            entityListLoadStatusLoading:
                filterSettingState.filterSettingLoading ||
                    state.actionItemListLoadStatus.isLoading,
            entityDetailLoadStatusLoading: state.actionItemLoadStatus.isLoading,
            selectedEntity: state.actionItem,
            isShowName: false,
            onViewSettingApplied: () {
              _filterActionItems();
            },
            onIncludeDeletedChanged: (value) {
              _filterActionItems(null, value, 1);
            },
            onFilterSaved: (value) {
              _filterActionItems(value, null, 1);
            },
            onFilterApplied: ([value, withoutSave]) {
              _filterActionItems(value, null, 1, null, withoutSave);
            },
            onPaginate: (pageNum, pageRow) {
              _filterActionItems(null, null, pageNum, pageRow);
            },
            totalRows: state.totalRows,
          );
        },
      ),
    );
  }

  void _selectActionItem(Entity selectedActionItem) {
    actionItemListBloc.add(ActionItemListActionItemForSideDetailLoaded(
        actionItemId: selectedActionItem.id!));
  }

  void _filterActionItems([
    String? filterId,
    bool? includeDeleted,
    int? pageNum,
    int? rowPerPage,
    bool? withoutSave,
  ]) {
    final FilterSettingBloc filterSettingBloc = context.read();
    final PaginationBloc paginationBloc = context.read();
    actionItemListBloc.add(ActionItemListFiltered(
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
