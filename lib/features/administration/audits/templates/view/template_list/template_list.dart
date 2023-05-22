import '/common_libraries.dart';

class TemplateListView extends StatefulWidget {
  const TemplateListView({super.key});

  @override
  State<TemplateListView> createState() => _TemplateListViewState();
}

class _TemplateListViewState extends State<TemplateListView> {
  String token = '';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) =>
          setState(() => token = state.authUser?.token ?? ''),
      listenWhen: (previous, current) =>
          previous.authUser?.token != current.authUser?.token,
      builder: (context, state) {
        token = state.authUser?.token ?? '';
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
                create: (context) => TemplatesRepository(
                      token: token,
                      authBloc: BlocProvider.of(context),
                    )),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => TemplateListBloc(
                      templatesRepository: RepositoryProvider.of(context))),
              BlocProvider(
                  create: (context) => TemplateDetailBloc(
                      templatesRepository: RepositoryProvider.of(context))),
            ],
            child: const TemplateListWidget(),
          ),
        );
      },
    );
  }
}

class TemplateListWidget extends StatefulWidget {
  const TemplateListWidget({super.key});

  @override
  State<TemplateListWidget> createState() => _TemplateListWidgetState();
}

class _TemplateListWidgetState extends State<TemplateListWidget> {
  late TemplateListBloc templatesListBloc;
  late TemplateDetailBloc templateDetailBloc;

  static String pageTitle = 'Templates';
  static String pageLabel = 'template';
  static String emptyMessage =
      'There are no templates. Please click on New Template to add new template';

  @override
  void initState() {
    templatesListBloc = context.read()..add(TemplateListLoaded());
    templateDetailBloc = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateListBloc, TemplateListState>(
      builder: (context, templateListState) {
        return BlocBuilder<TemplateDetailBloc, TemplateDetailState>(
          builder: (context, templateDetailState) {
            return BlocConsumer<FilterSettingBloc, FilterSettingState>(
              listener: (context, state) {
                // if (state.selectedTemplateFilterSetting!.id.isNotEmpty) {
                // templatesListBloc.add(TemplateListFiltered(
                //   filterId: state.selectedTemplateFilterSetting!.id,
                //   includeDeleted: state.includeDeleted,
                // ));
                // } else {
                // templatesListBloc.add(TemplateListLoaded());
                // }
              },
              // listenWhen: (previous, current) =>
              //     previous.selectedTemplateFilterSetting !=
              //     current.selectedTemplateFilterSetting,
              builder: (context, state) {
                return BlocListener<ViewSettingBloc, ViewSettingState>(
                  listener: (context, viewSettingState) {
                    // templatesListBloc.add(TemplateListFiltered(
                    //   filterId: state.templateFilterUpdate.id,
                    //   includeDeleted: state.includeDeleted,
                    // ));
                  },
                  listenWhen: (previous, current) =>
                      previous.viewSettingSaveStatus !=
                      current.viewSettingSaveStatus,
                  child: EntityListTemplate(
                    title: pageTitle,
                    label: pageLabel,
                    entities: templateListState.templateList,
                    showTableHeaderButtons: true,
                    onRowClick: (selectedTemplate) =>
                        _selectTemplate(selectedTemplate),
                    emptyMessage: emptyMessage,
                    entityListLoadStatusLoading:
                        templateListState.templateListLoadStatus.isLoading,
                    selectedEntity: templateDetailState.template,
                    onTableSorted: (sortedTemplates) =>
                        _sortTemplates(sortedTemplates),
                    onViewSettingApplied: () {
                      // viewSettingBloc
                      //     .add(const ViewSettingApplied(viewName: 'template'));
                      // templatesListBloc.add(TemplateListFiltered(
                      //   filterId: state.templateFilterUpdate.id,
                      //   includeDeleted: state.includeDeleted,
                      // ));
                    },
                    onIncludeDeletedChanged: (value) {
                      // templatesListBloc.add(TemplateListFiltered(
                      //   filterId: state.templateFilterUpdate.id,
                      //   includeDeleted: value,
                      // ));
                    },
                    viewName: 'template',
                    onFilterSaved: (filterId) {
                      //       templatesListBloc.add(TemplateListFiltered(
                      //   filterId: state.templateFilterUpdate.id,
                      //   includeDeleted: state.includeDeleted,
                      // ));
                    },
                    onFilterApplied: ([p0]) {},
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void _sortTemplates(List<Entity> sortedTemplates) {
    templatesListBloc.add(TemplateListSorted(
        sortedTemplateList: sortedTemplates
            .map((sortedTemplate) => sortedTemplate as Template)
            .toList()));
  }

  void _selectTemplate(Entity selectedTemplate) {
    templateDetailBloc.add(
        TemplateDetailTemplateLoadedById(templateId: selectedTemplate.id!));
  }
}
