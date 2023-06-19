import '/common_libraries.dart';

class AssignTemplatesToSiteView extends StatelessWidget {
  final String siteId;
  const AssignTemplatesToSiteView({
    super.key,
    required this.siteId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssignTemplateToSiteBloc(
        sitesRepository: RepositoryProvider.of(context),
      ),
      child: AssignTemplatesToSiteWidget(siteId: siteId),
    );
  }
}

class AssignTemplatesToSiteWidget extends StatefulWidget {
  final String siteId;
  const AssignTemplatesToSiteWidget({
    super.key,
    required this.siteId,
  });

  @override
  State<AssignTemplatesToSiteWidget> createState() =>
      _AssignTemplatesToSiteWidgetState();
}

class _AssignTemplatesToSiteWidgetState
    extends State<AssignTemplatesToSiteWidget> {
  late AssignTemplateToSiteBloc assignTemplateToSiteBloc;

  static const List<String> columnList = [
    'Template Name',
    'Created By',
    'Last Revised on',
    'Assigned?'
  ];

  @override
  void initState() {
    assignTemplateToSiteBloc = context.read()
      // ..add(const FilterTextForAssignedChanged(filterText: ''))
      // ..add(const FilterTextForUnassignedChanged(filterText: ''))
      ..add(AssignTemplateToSiteAssignedAuditTemplateListLoaded(
          id: widget.siteId))
      ..add(AssignTemplateToSiteUnassignedAuditTemplateListLoaded(
          id: widget.siteId));

    context.read<FormDirtyBloc>().add(const FormDirtyChanged(isDirty: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SitesBloc, SitesState>(
      builder: (context, state) {
        return Padding(
          padding: inset10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: _buildUnassignedTemplatesTableHeaderView()),
                  spacer100,
                  Expanded(child: _buildAssignedTemplatesTableViewHeader()),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUnassignedTemplatesTableView(state),
                  spacer100,
                  _buildAssignedTemplatesTableView(state, context),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Expanded _buildUnassignedTemplatesTableView(SitesState state) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomDivider(),
          _buildFilterTextFieldForUnassignedSites(state),
          const CustomDivider(),
          _buildUnassignedSitesTableView(),
        ],
      ),
    );
  }

  Padding _buildUnassignedTemplatesTableHeaderView() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'Templates can be assigned to this site by selecting from the list below.',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Expanded _buildAssignedTemplatesTableView(
      SitesState state, BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomDivider(),
          _buildFilterTextFieldForAssignedSites(state),
          const CustomDivider(),
          _buildAssignedSitesTableView(),
        ],
      ),
    );
  }

  Padding _buildAssignedTemplatesTableViewHeader() {
    return Padding(
      padding: insetx20,
      child: const Text(
        'Templates can be assigned from list on left. Once assigned they will show here in this list below.',
        style: TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontFamily: 'OpenSans',
        ),
      ),
    );
  }

  Widget _buildUnassignedSitesTableView() {
    return SizedBox(
      width: double.infinity,
      child: BlocConsumer<AssignTemplateToSiteBloc, AssignTemplateToSiteState>(
        listener: (context, state) {
          if (state.status == EntityStatus.success) {
            CustomNotification(
              context: context,
              notifyType: NotifyType.success,
              content: state.message,
            ).showNotification();
            _refetchSiteSites();
          } else if (state.status.isFailure) {
            CustomNotification(
              context: context,
              notifyType: NotifyType.error,
              content: state.message,
            ).showNotification();
          }
        },
        listenWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) => TableView(
          height: MediaQuery.of(context).size.height - 460,
          columns: columnList,
          rows: state.unassignedAuditTemplateList
              .map(
                (unassignedTemplate) => [
                  CustomDataCell(
                    data: unassignedTemplate.name,
                  ),
                  CustomDataCell(
                    data: unassignedTemplate.createdByUserName,
                  ),
                  CustomDataCell(
                    data: unassignedTemplate.formatedRevisionDate,
                  ),
                  CustomSwitch(
                    trueString: 'Yes',
                    falseString: 'No',
                    textColor: darkTeal,
                    switchValue: false,
                    onChanged: (value) {
                      assignTemplateToSiteBloc
                          .add(AssignTemplateToSiteToggleAssigned(
                              templateSiteAssignment: TemplateSiteAssignment(
                        siteId: widget.siteId,
                        templateId: unassignedTemplate.id!,
                        assigned: true,
                      )));
                    },
                  ),
                ],
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildAssignedSitesTableView() {
    return SizedBox(
      width: double.infinity,
      child: BlocConsumer<AssignTemplateToSiteBloc, AssignTemplateToSiteState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            CustomNotification(
              context: context,
              notifyType: NotifyType.success,
              content: state.message,
            ).showNotification();
            _refetchSiteSites();
          } else if (state.status.isFailure) {
            CustomNotification(
              context: context,
              notifyType: NotifyType.error,
              content: state.message,
            ).showNotification();
          }
        },
        listenWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) => TableView(
          height: MediaQuery.of(context).size.height - 460,
          columns: columnList,
          rows: List<Template>.from(state.assignedAuditTemplateList)
              .map(
                (assignedSiteSite) => [
                  CustomDataCell(
                    data: assignedSiteSite.name,
                  ),
                  CustomDataCell(
                    data: assignedSiteSite.createdByUserName,
                  ),
                  CustomDataCell(
                    data: assignedSiteSite.formatedRevisionDate,
                  ),
                  CustomSwitch(
                    switchValue: false,
                    trueString: 'Yes',
                    falseString: 'No',
                    textColor: darkTeal,
                    onChanged: (value) => CustomAlert(
                      context: context,
                      width: MediaQuery.of(context).size.width / 4,
                      title: 'Confirm',
                      description:
                          'Do you really want to remove this site from site?',
                      btnOkText: 'Remove',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                        assignTemplateToSiteBloc
                            .add(AssignTemplateToSiteToggleAssigned(
                                templateSiteAssignment: TemplateSiteAssignment(
                          siteId: widget.siteId,
                          templateId: assignedSiteSite.id!,
                          assigned: false,
                        )));
                      },
                      dialogType: DialogType.question,
                    ).show(),
                  ),
                ],
              )
              .toList(),
        ),
      ),
    );
  }

  Padding _buildFilterTextFieldForUnassignedSites(SitesState state) {
    return Padding(
      padding: insetx20,
      child: FilterTextField(
        hintText: 'Filter unassigned templates by name.',
        label: 'sites',
        applyFilter: () {
          // assignTemplateToSiteBloc.add(UnassignedSiteSitesRetrieved(
          //   siteId: widget.siteId,
          //   name: state.filterTextForUnassigned,
          // ));
        },
        clearFilter: () {
          // assignTemplateToSiteBloc
          //   ..add(UnassignedSiteSitesRetrieved(siteId: widget.siteId))
          //   ..add(const FilterTextForUnassignedChanged(filterText: ''));
        },
        onChange: (value) {
          // assignTemplateToSiteBloc.add(FilterTextForUnassignedChanged(filterText: value));
        },
      ),
    );
  }

  Padding _buildFilterTextFieldForAssignedSites(SitesState state) {
    return Padding(
      padding: insetx20,
      child: FilterTextField(
        hintText: 'Filter assigned templates by name.',
        label: 'sites',
        applyFilter: () {
          // assignTemplateToSiteBloc.add(AssignedSiteSitesRetrieved(
          //   siteId: widget.siteId,
          //   name: state.filterTextForAssigned,
          // ));
        },
        clearFilter: () {
          // assignTemplateToSiteBloc
          //   ..add(AssignedSiteSitesRetrieved(siteId: widget.siteId))
          //   ..add(const FilterTextForAssignedChanged(filterText: ''));
        },
        onChange: (value) {
          // assignTemplateToSiteBloc.add(FilterTextForAssignedChanged(filterText: value))
        },
      ),
    );
  }

  _refetchSiteSites() {
    assignTemplateToSiteBloc
      ..add(AssignTemplateToSiteAssignedAuditTemplateListLoaded(
          id: widget.siteId))
      ..add(AssignTemplateToSiteUnassignedAuditTemplateListLoaded(
          id: widget.siteId));
  }
}
