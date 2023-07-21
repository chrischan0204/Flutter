import '/common_libraries.dart';

class AuditListView extends StatefulWidget {
  const AuditListView({super.key});

  @override
  State<AuditListView> createState() => _AuditListViewState();
}

class _AuditListViewState extends State<AuditListView> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuditListBloc(
                auditsRepository: RepositoryProvider.of(context))),
      ],
      child: const AuditListWidget(),
    );
  }
}

class AuditListWidget extends StatefulWidget {
  const AuditListWidget({super.key});

  @override
  State<AuditListWidget> createState() => _AuditListState();
}

class _AuditListState extends State<AuditListWidget> {
  late AuditListBloc auditListBloc;
  // late AuditDetailBloc auditDetailBloc;

  static String pageTitle = 'Audits';
  static String pageLabel = 'audit';
  static String emptyMessage =
      'There are no audits. Please click on New Audit to add new audit';

  @override
  void initState() {
    auditListBloc = context.read<AuditListBloc>();
    // auditDetailBloc = context.read<AuditDetailBloc>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterSettingBloc, FilterSettingState>(
      builder: (context, filterSettingState) =>
          BlocBuilder<AuditListBloc, AuditListState>(
        builder: (context, auditListState) {
          return EntityListTemplate(
            title: pageTitle,
            label: pageLabel,
            viewName: pageLabel,
            entities: auditListState.auditList,
            showTableHeaderButtons: true,
            onRowClick: (selectedAudit) => _selectAudit(selectedAudit),
            emptyMessage: emptyMessage,
            entityListLoadStatusLoading:
                filterSettingState.filterSettingLoading ||
                    auditListState.auditListLoadStatus.isLoading,
            entityDetailLoadStatusLoading:
                auditListState.auditLoadStatus.isLoading,
            selectedEntity: auditListState.audit,
            isShowName: false,
            onViewSettingApplied: () {
              _filterAudits();
            },
            onIncludeDeletedChanged: (value) {
              _filterAudits(null, value, 1);
            },
            onFilterSaved: (value) {
              _filterAudits(value, null, 1);
            },
            onFilterApplied: ([value, withoutSave]) {
              _filterAudits(value, null, 1, null, withoutSave);
            },
            onPaginate: (pageNum, pageRow) {
              _filterAudits(null, null, pageNum, pageRow);
            },
            totalRows: auditListState.totalRows,
          );
        },
      ),
    );
  }

  void _selectAudit(Entity selectedAudit) {
    auditListBloc
        .add(AuditListAuditForSideDetailLoaded(auditId: selectedAudit.id!));
  }

  void _filterAudits([
    String? filterId,
    bool? includeDeleted,
    int? pageNum,
    int? rowPerPage,
    bool? withoutSave,
  ]) {
    final FilterSettingBloc filterSettingBloc = context.read();
    final PaginationBloc paginationBloc = context.read();
    auditListBloc.add(AuditListFiltered(
        option: FilteredTableParameter(
      filterId: filterId ??
          filterSettingBloc.state.appliedUserFilterSetting?.id ??
          emptyGuid,
      includeDeleted: includeDeleted ?? filterSettingBloc.state.includeDeleted,
      pageNum: pageNum ?? paginationBloc.state.selectedPageNum,
      pageSize: rowPerPage ?? paginationBloc.state.rowsPerPage,
      filterOption: filterSettingBloc.state.userFilterUpdate,
    )));
  }
}
