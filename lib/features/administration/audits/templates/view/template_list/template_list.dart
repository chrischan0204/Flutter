import '/common_libraries.dart';

class TemplateListView extends StatefulWidget {
  const TemplateListView({super.key});

  @override
  State<TemplateListView> createState() => _TemplateListViewState();
}

class _TemplateListViewState extends State<TemplateListView> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => TemplateListBloc(
                templatesRepository: RepositoryProvider.of(context))),
        BlocProvider(
            create: (context) => TemplateDetailBloc(
                  context: context,
                  templateId: '',
                )),
      ],
      child: const TemplateListWidget(),
    );
  }
}

class TemplateListWidget extends StatefulWidget {
  const TemplateListWidget({super.key});

  @override
  State<TemplateListWidget> createState() => _TemplateListWidgetState();
}

class _TemplateListWidgetState extends State<TemplateListWidget> {
  late TemplateListBloc templateListBloc;
  late TemplateDetailBloc templateDetailBloc;

  static String pageTitle = 'Templates';
  static String pageLabel = 'template';
  static String emptyMessage =
      'There are no templates. Please click on New Template to add new template';

  @override
  void initState() {
    templateListBloc = context.read()..add(TemplateListLoaded());
    templateDetailBloc = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateListBloc, TemplateListState>(
      builder: (context, templateListState) {
        return BlocBuilder<TemplateDetailBloc, TemplateDetailState>(
          builder: (context, templateDetailState) {
            return BlocBuilder<FilterSettingBloc, FilterSettingState>(
              builder: (context, state) {
                return EntityListTemplate(
                  title: pageTitle,
                  label: pageLabel,
                  viewName: pageLabel,
                  entities: templateListState.templateList,
                  showTableHeaderButtons: true,
                  onRowClick: (selectedTemplate) =>
                      _selectTemplate(selectedTemplate),
                  emptyMessage: emptyMessage,
                  entityListLoadStatusLoading: state.filterSettingLoading ||
                      templateListState.templateListLoadStatus.isLoading,
                  entityDetailLoadStatusLoading:
                      templateDetailState.templateLoadStatus.isLoading,
                  selectedEntity: templateDetailState.template,
                  onTableSorted: (sortedTemplates) =>
                      _sortTemplates(sortedTemplates),
                  onViewSettingApplied: () => _filterTemplates(),
                  onIncludeDeletedChanged: (value) =>
                      _filterTemplates(null, value, 1),
                  onFilterSaved: (value) => _filterTemplates(value, null, 1),
                  onFilterApplied: ([value, withoutSave]) =>
                      _filterTemplates(value, null, 1, null, withoutSave),
                  onPaginate: (pageNum, pageRow) =>
                      _filterTemplates(null, null, pageNum, pageRow),
                  totalRows: templateListState.totalRows,
                );
              },
            );
          },
        );
      },
    );
  }

  void _sortTemplates(List<Entity> sortedTemplates) {
    templateListBloc.add(TemplateListSorted(
        sortedTemplateList: sortedTemplates
            .map((sortedTemplate) => sortedTemplate as Template)
            .toList()));
  }

  void _selectTemplate(Entity selectedTemplate) {
    templateDetailBloc.add(
        TemplateDetailTemplateLoadedById(templateId: selectedTemplate.id!));
  }

  void _filterTemplates([
    String? filterId,
    bool? includeDeleted,
    int? pageNum,
    int? rowPerPage,
    bool? withoutSave,
  ]) {
    final FilterSettingBloc filterSettingBloc = context.read();
    final PaginationBloc paginationBloc = context.read();
    templateListBloc.add(TemplateListFiltered(
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
