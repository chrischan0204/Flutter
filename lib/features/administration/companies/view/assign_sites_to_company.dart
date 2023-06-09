import '/common_libraries.dart';

class AssignSitesToCompanyView extends StatefulWidget {
  final String companyId;
  final String companyName;
  final String? view;
  const AssignSitesToCompanyView({
    super.key,
    required this.companyId,
    this.companyName = '',
    this.view,
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
      ..add(const FilterTextChangedForAssigned(filterText: ''))
      ..add(AssignedCompanySitesRetrieved(companyId: widget.companyId))
      ..add(UnassignedCompanySitesRetrieved(companyId: widget.companyId));
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUnassignedSitesView(state),
                  const SizedBox(
                    width: 150,
                  ),
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
          const Text(
            'Sites can be assigned to this company by selecting from the list below.',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const CustomDivider(),
          _buildFilterTextFieldForUnassignedSites(state),
          const CustomDivider(),
          _buildUnassignedSitesTableView(state),
        ],
      ),
    );
  }

  Expanded _buildAssignedSitesView(CompaniesState state, BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAssignedSitesTableViewHeader(state),
          const CustomDivider(),
          _buildFilterTextFieldForAssignedSites(state),
          const CustomDivider(),
          _buildAssignedSitesTableView(state, context),
        ],
      ),
    );
  }

  Padding _buildAssignedSitesTableViewHeader(CompaniesState state) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
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
        child: DataTable(
          headingTextStyle: tableHeadingTextStyle,
          dataTextStyle: tableDataTextStyle,
          columns: const [
            DataColumn(
              label: Text(
                'Site Name',
              ),
            ),
            DataColumn(
              label: Text('Assigned?'),
            ),
          ],
          rows: state.unassignedCompanySites
              .map(
                (unassignedCompanySite) => DataRow(
                  cells: [
                    DataCell(
                      CustomDataCell(
                        data: unassignedCompanySite.siteName,
                      ),
                    ),
                    DataCell(
                      CustomSwitch(
                        trueString: 'Yes',
                        falseString: 'No',
                        textColor: darkTeal,
                        switchValue: unassignedCompanySite.assigned,
                        onChanged: (value) {
                          _assignSiteToCompany(unassignedCompanySite);
                        },
                      ),
                    ),
                  ],
                ),
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
        child: DataTable(
          headingTextStyle: tableHeadingTextStyle,
          dataTextStyle: tableDataTextStyle,
          columns: const [
            DataColumn(
              label: Text(
                'Site Name',
              ),
            ),
            DataColumn(
              label: Text('Assigned?'),
            ),
          ],
          rows: List<CompanySite>.from(state.assignedCompanySites)
              .map(
                (assignedCompanySite) => DataRow(
                  cells: [
                    DataCell(
                      CustomDataCell(
                        data: assignedCompanySite.siteName,
                      ),
                    ),
                    DataCell(
                      CustomSwitch(
                        switchValue: assignedCompanySite.assigned,
                        trueString: 'Yes',
                        falseString: 'No',
                        textColor: darkTeal,
                        onChanged: (value) =>
                            _unassignFromCompany(assignedCompanySite.id!),
                      ),
                    ),
                  ],
                ),
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
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: FilterTextField(
        hintText: 'Filter unassigned sites by name.',
        label: 'sites',
        filterIconClick: (filtered) {
          if (filtered) {
            companiesBloc.add(UnassignedCompanySitesRetrieved(
              companyId: widget.companyId,
              name: state.filterTextForUnassigned,
            ));
          } else {
            companiesBloc
              ..add(
                  UnassignedCompanySitesRetrieved(companyId: widget.companyId))
              ..add(const FilterTextChangedForUnassigned(filterText: ''));
          }
        },
        onChange: (value) => companiesBloc
            .add(FilterTextChangedForUnassigned(filterText: value)),
      ),
    );
  }

  Padding _buildFilterTextFieldForAssignedSites(CompaniesState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: FilterTextField(
        hintText: 'Filter assigned sites by name.',
        label: 'sites',
        filterIconClick: (filtered) {
          if (filtered) {
            companiesBloc.add(AssignedCompanySitesRetrieved(
              companyId: widget.companyId,
              name: state.filterTextForAssigned,
            ));
          } else {
            companiesBloc
              ..add(AssignedCompanySitesRetrieved(companyId: widget.companyId))
              ..add(const FilterTextChangedForAssigned(filterText: ''));
          }
        },
        onChange: (value) =>
            companiesBloc.add(FilterTextChangedForAssigned(filterText: value)),
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
