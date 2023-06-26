import '/common_libraries.dart';

class ShowCompanyView extends StatefulWidget {
  final String companyId;
  const ShowCompanyView({
    super.key,
    required this.companyId,
  });

  @override
  State<ShowCompanyView> createState() => _ShowCompanyViewState();
}

class _ShowCompanyViewState extends State<ShowCompanyView> {
  late CompaniesBloc companiesBloc;

  static String pageTitle = 'Company';
  static String pageLabel = 'company';
  static String descriptionForDelete =
      'This item can not be deleted as it has sites assigned to it.';

  @override
  void initState() {
    companiesBloc = context.read<CompaniesBloc>()
      ..add(CompanySelectedById(companyId: widget.companyId))
      ..add(AssignedCompanySitesRetrieved(companyId: widget.companyId))
      ..add(AssignedProjectCompaniesRetrieved(companyId: widget.companyId))
      ..add(AuditTrailsRetrievedByCompanyId(companyId: widget.companyId));
    super.initState();
  }

  _deleteCompany(CompaniesState state) {
    companiesBloc.add(CompanyDeleted(companyId: widget.companyId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompaniesBloc, CompaniesState>(
      listener: (context, state) => _checkDeleteCompanyStatus(state, context),
      builder: (context, state) {
        return EntityShowTemplate(
          title: pageTitle,
          label: pageLabel,
          deleteEntity: () => _deleteCompany(state),
          tabItems: _buildTabs(state),
          entity: state.selectedCompany,
          crudStatus: state.companyCrudStatus,
          deletable: state.deletable,
          descriptionForDelete: descriptionForDelete,
        );
      },
    );
  }

  Map<String, Widget> _buildTabs(CompaniesState state) {
    return {
      'Sites': _buildAssociatedSites(state),
      'Projects': _buildAssociatedProjects(state),
      'Audit Trail': _builAuditTrails(state),
    };
  }

  Widget _buildAssociatedSites(CompaniesState state) {
    var rows = state.assignedCompanySites
        .map(
          (companySite) => companySite
              .toTableDetailMap()
              .values
              .map((detail) => CustomDataCell(data: detail))
              .toList(),
        )
        .toList();
    var columns = const ['Site', 'Added By', 'Added on'];
    return state.assignedCompanySitesRetrievedStatus == EntityStatus.loading
        ? const Padding(
            padding: EdgeInsets.only(top: 300),
            child: Center(child: Loader()),
          )
        : Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                state.assignedCompanySites.isNotEmpty
                    ? Padding(
                        padding: insetx20,
                        child: const Text(
                          'The following sites are associated with this company. Edit company to associate/ remove sites from this company',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    : Container(),
                state.assignedCompanySites.isNotEmpty
                    ? const CustomDivider()
                    : Container(),
                Container(
                  child: state.assignedCompanySites.isNotEmpty
                      ? TableView(
                          height: MediaQuery.of(context).size.height - 460,
                          columns: columns,
                          rows: rows,
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: insetx20,
                              child: const Text(
                                'This company has no sites assigned to it yet.',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const CustomDivider(),
                            Padding(
                              padding: insetx20,
                              child: const Text(
                                'Sites can be assigned by editing the company and going to the sites tab to select from available companies',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const CustomDivider(),
                          ],
                        ),
                ),
              ],
            ),
          );
  }

  Widget _buildAssociatedProjects(CompaniesState state) {
    var rows = state.assignedProjectCompanies
        .map(
          (projectCompany) => [
            CustomDataCell(data: projectCompany.projectName),
            CustomDataCell(data: projectCompany.siteName),
            CustomDataCell(data: projectCompany.roleName),
            CustomDataCell(data: projectCompany.createdByUserName),
            CustomDataCell(data: projectCompany.createdOn),
          ],
        )
        .toList();
    var columns = const ['Project', 'Site', 'Role', 'Added By', 'Added on'];
    return state.assignedProjectCompaniesRetrievedStatus == EntityStatus.loading
        ? const Padding(
            padding: EdgeInsets.only(top: 300),
            child: Center(child: Loader()),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              state.assignedProjectCompanies.isNotEmpty
                  ? Padding(
                      padding: insetx20,
                      child: const Text(
                        'The following projects are associated with this company. Edit company to associate/ remove projects from this company',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  : Container(),
              state.assignedProjectCompanies.isNotEmpty
                  ? const CustomDivider()
                  : Container(),
              Container(
                child: state.assignedProjectCompanies.isNotEmpty
                    ? TableView(
                        height: MediaQuery.of(context).size.height - 460,
                        columns: columns,
                        rows: rows,
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: insetx20,
                            child: const Text(
                              'This company has no projects assigned to it yet.',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const CustomDivider(),
                          Padding(
                            padding: insetx20,
                            child: const Text(
                              'Projects can be assigned by editing the company and going to the projects tab to select from available companies',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const CustomDivider(),
                        ],
                      ),
              ),
            ],
          );
  }

  Widget _builAuditTrails(CompaniesState state) {
    var rows = state.auditTrails
        .map(
          (companySite) => companySite
              .toTableDetailMap()
              .values
              .map((detail) => CustomDataCell(data: detail))
              .toList(),
        )
        .toList();
    var columns = const ['Change', 'From', 'To', 'Changed By', 'Changed On'];
    return state.auditTrailsRerievedStatus == EntityStatus.loading
        ? const Padding(
            padding: EdgeInsets.only(top: 300),
            child: Center(child: Loader()),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              state.auditTrails.isNotEmpty
                  ? Padding(
                      padding: insetx20,
                      child: const Text(
                        'The following table shows the audit trail on this company.',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    )
                  : Container(),
              state.auditTrails.isNotEmpty
                  ? const CustomDivider()
                  : Container(),
              Container(
                child: state.auditTrails.isNotEmpty
                    ? TableView(
                        height: MediaQuery.of(context).size.height - 460,
                        columns: columns,
                        rows: rows,
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: insetx20,
                            child: const Text(
                              'No audit trail information available.',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const CustomDivider(),
                        ],
                      ),
              ),
            ],
          );
  }

  void _checkDeleteCompanyStatus(CompaniesState state, BuildContext context) {
    if (state.companyCrudStatus.isSuccess) {
      companiesBloc.add(CompaniesStatusInited());
      CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: state.message,
      ).showNotification();

      GoRouter.of(context).go('/companies');
    }
    if (state.companyCrudStatus.isFailure) {
      companiesBloc.add(CompaniesStatusInited());
      CustomNotification(
        context: context,
        notifyType: NotifyType.error,
        content: state.message,
      ).showNotification();
    }
  }
}
