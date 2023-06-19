import '/common_libraries.dart';

class AssignSitesToCompanyView extends StatefulWidget {
  final String companyId;
  const AssignSitesToCompanyView({
    super.key,
    required this.companyId,
  });

  @override
  State<AssignSitesToCompanyView> createState() =>
      _AssignSitesToCompanyViewState();
}

class _AssignSitesToCompanyViewState extends State<AssignSitesToCompanyView> {
  late CompaniesBloc companiesBloc;

  @override
  void initState() {
    companiesBloc = context.read<CompaniesBloc>()
      ..add(const FilterTextForAssignedChanged(filterText: ''))
      ..add(const FilterTextForUnassignedChanged(filterText: ''))
      ..add(AssignedCompanySitesRetrieved(companyId: widget.companyId))
      ..add(UnassignedCompanySitesRetrieved(companyId: widget.companyId));

    context.read<FormDirtyBloc>().add(const FormDirtyChanged(isDirty: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompaniesBloc, CompaniesState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: _buildUnassignedSitesTableHeaderView()),
                  const SizedBox(width: 100),
                  Expanded(child: _buildAssignedSitesTableViewHeader()),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUnassignedSitesView(state),
                  const SizedBox(width: 100),
                  _buildAssignedSitesView(state, context),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Expanded _buildUnassignedSitesView(CompaniesState state) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomDivider(),
          _buildFilterTextFieldForUnassignedSites(state),
          const CustomDivider(),
          _buildUnassignedSitesTableView(state),
        ],
      ),
    );
  }

  Padding _buildUnassignedSitesTableHeaderView() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'Sites can be assigned to this company by selecting from the list below.',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Expanded _buildAssignedSitesView(CompaniesState state, BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomDivider(),
          _buildFilterTextFieldForAssignedSites(state),
          const CustomDivider(),
          _buildAssignedSitesTableView(state, context),
        ],
      ),
    );
  }

  Padding _buildAssignedSitesTableViewHeader() {
    return Padding(
      padding: insetx20,
      child: const Text(
        'Sites can be assigned from list on left. Once assigned they will show here in this list below.',
        style: TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontFamily: 'OpenSans',
        ),
      ),
    );
  }

  Widget _buildUnassignedSitesTableView(CompaniesState state) {
    return SizedBox(
      width: double.infinity,
      child: BlocListener<CompaniesBloc, CompaniesState>(
        listener: (context, state) {
          if (state.siteFromCompanyUnassignedStatus == EntityStatus.success) {
            CustomNotification(
              context: context,
              notifyType: NotifyType.success,
              content: state.message,
            ).showNotification();
            _refetchCompanySites(
                state.filterTextForAssigned, state.filterTextForUnassigned);
          } else if (state.siteFromCompanyUnassignedStatus ==
              EntityStatus.failure) {
            CustomNotification(
              context: context,
              notifyType: NotifyType.error,
              content: state.message,
            ).showNotification();
          }
        },
        listenWhen: (previous, current) =>
            previous.siteFromCompanyUnassignedStatus !=
            current.siteFromCompanyUnassignedStatus,
        child: TableView(
          height: MediaQuery.of(context).size.height - 460,
          columns: const ['Site Name', 'Assigned?'],
          rows: state.unassignedCompanySites
              .map(
                (unassignedCompanySite) => [
                  CustomDataCell(
                    data: unassignedCompanySite.siteName,
                  ),
                  CustomSwitch(
                    trueString: 'Yes',
                    falseString: 'No',
                    textColor: darkTeal,
                    switchValue: unassignedCompanySite.assigned,
                    onChanged: (value) {
                      _assignSiteToCompany(unassignedCompanySite);
                    },
                  ),
                ],
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildAssignedSitesTableView(
      CompaniesState state, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocListener<CompaniesBloc, CompaniesState>(
        listener: (context, state) {
          if (state.siteToCompanyAssignedStatus == EntityStatus.success) {
            CustomNotification(
              context: context,
              notifyType: NotifyType.success,
              content: state.message,
            ).showNotification();
            _refetchCompanySites(
                state.filterTextForAssigned, state.filterTextForUnassigned);
          } else if (state.siteToCompanyAssignedStatus ==
              EntityStatus.failure) {
            CustomNotification(
              context: context,
              notifyType: NotifyType.error,
              content: state.message,
            ).showNotification();
          }
        },
        listenWhen: (previous, current) =>
            previous.siteToCompanyAssignedStatus !=
            current.siteToCompanyAssignedStatus,
        child: TableView(
          height: MediaQuery.of(context).size.height - 460,
          columns: const ['Site Name', 'Assigned?'],
          rows: List<CompanySite>.from(state.assignedCompanySites)
              .map(
                (assignedCompanySite) => [
                  CustomDataCell(
                    data: assignedCompanySite.siteName,
                  ),
                  CustomSwitch(
                    switchValue: assignedCompanySite.assigned,
                    trueString: 'Yes',
                    falseString: 'No',
                    textColor: darkTeal,
                    onChanged: (value) =>
                        _unassignFromCompany(assignedCompanySite.id!),
                  ),
                ],
              )
              .toList(),
        ),
      ),
    );
  }

  void _assignSiteToCompany(CompanySite companySite) {
    companiesBloc.add(SiteToCompanyAssigned(
        companySiteUpdation: companySite.toCompanySiteUpdation()));
  }

  void _unassignFromCompany(String companySiteId) {
    CustomAlert(
      context: context,
      width: MediaQuery.of(context).size.width / 4,
      title: 'Confirm',
      description: 'Do you really want to remove this site from company?',
      btnOkText: 'Remove',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        companiesBloc.add(
            SiteFromCompanyUnassigned(companySiteUpdationId: companySiteId));
      },
      dialogType: DialogType.question,
    ).show();
  }

  Padding _buildFilterTextFieldForUnassignedSites(CompaniesState state) {
    return Padding(
      padding: insetx20,
      child: FilterTextField(
        hintText: 'Filter unassigned sites by name.',
        label: 'sites',
        applyFilter: () {
          companiesBloc.add(UnassignedCompanySitesRetrieved(
            companyId: widget.companyId,
            name: state.filterTextForUnassigned,
          ));
        },
        clearFilter: () {
          companiesBloc
            ..add(UnassignedCompanySitesRetrieved(companyId: widget.companyId))
            ..add(const FilterTextForUnassignedChanged(filterText: ''));
        },
        onChange: (value) => companiesBloc
            .add(FilterTextForUnassignedChanged(filterText: value)),
      ),
    );
  }

  Padding _buildFilterTextFieldForAssignedSites(CompaniesState state) {
    return Padding(
      padding: insetx20,
      child: FilterTextField(
        hintText: 'Filter assigned sites by name.',
        label: 'sites',
        applyFilter: () {
          companiesBloc.add(AssignedCompanySitesRetrieved(
            companyId: widget.companyId,
            name: state.filterTextForAssigned,
          ));
        },
        clearFilter: () {
          companiesBloc
            ..add(AssignedCompanySitesRetrieved(companyId: widget.companyId))
            ..add(const FilterTextForAssignedChanged(filterText: ''));
        },
        onChange: (value) =>
            companiesBloc.add(FilterTextForAssignedChanged(filterText: value)),
      ),
    );
  }

  _refetchCompanySites(
      String filterTextForAssigned, String filterTextForUnassigned) {
    companiesBloc
      ..add(AssignedCompanySitesRetrieved(
          companyId: widget.companyId, name: filterTextForAssigned))
      ..add(UnassignedCompanySitesRetrieved(
        companyId: widget.companyId,
        name: filterTextForUnassigned,
      ));
  }
}
