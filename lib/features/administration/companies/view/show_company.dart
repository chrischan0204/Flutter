import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/utils/custom_notification.dart';
import '/data/model/model.dart';
import '/global_widgets/global_widget.dart';
import '/data/bloc/bloc.dart';

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

  @override
  void initState() {
    companiesBloc = context.read<CompaniesBloc>()
      ..add(CompanySelectedById(companyId: widget.companyId))
      ..add(AssignedCompanySitesRetrieved(companyId: widget.companyId))
      ..add(AssignedProjectCompaniesRetrieved(companyId: widget.companyId));
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
        );
      },
    );
  }

  Map<String, Widget> _buildTabs(CompaniesState state) {
    return {
      'Details': Container(),
      'Sites': _buildAssociatedSites(state),
      'Projects': _buildAssociatedProjects(state),
      'Audit Trail': Container(),
    };
  }

  Column _buildAssociatedSites(CompaniesState state) {
    var rows = state.assignedCompanySites
        .map(
          (companySite) => DataRow(
            cells: companySite
                .toTableDetailMap()
                .values
                .map(
                  (detail) => DataCell(
                    CustomDataCell(data: detail),
                  ),
                )
                .toList(),
          ),
        )
        .toList();
    var columns = const [
      DataColumn(
        label: Text(
          'Site',
        ),
      ),
      DataColumn(
        label: Text(
          'Role',
        ),
      ),
      DataColumn(
        label: Text(
          'Added By',
        ),
      ),
      DataColumn(
        label: Text(
          'Added on',
        ),
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        state.assignedCompanySites.isNotEmpty
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'The following sites are associated with this project. Edit company to associate/ remove sites from this company',
                  style: TextStyle(
                    fontSize: 14,
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
          child: state.assignedProjectCompaniesRetrievedStatus ==
                  EntityStatus.loading
              ? const Padding(
                  padding: EdgeInsets.only(top: 300),
                  child: CircularProgressIndicator(),
                )
              : state.assignedCompanySites.isNotEmpty
                  ? DataTable(
                      columns: columns,
                      rows: rows,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'This company has no sites assigned to it yet.',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        CustomDivider(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Sites can be assigned by editing the company and going to the sites tab to select from available companies',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        CustomDivider(),
                      ],
                    ),
        ),
      ],
    );
  }

  Column _buildAssociatedProjects(CompaniesState state) {
    var rows = state.assignedProjectCompanies
        .map(
          (projectCompany) => DataRow(
            cells: projectCompany
                .toTableDetailMap()
                .values
                .map(
                  (detail) => DataCell(
                    CustomDataCell(data: detail),
                  ),
                )
                .toList(),
          ),
        )
        .toList();
    var columns = const [
      DataColumn(
        label: Text(
          'Project',
        ),
      ),
      DataColumn(
        label: Text(
          'Site',
        ),
      ),
      DataColumn(
        label: Text(
          'Role',
        ),
      ),
      DataColumn(
        label: Text(
          'Added By',
        ),
      ),
      DataColumn(
        label: Text(
          'Added on',
        ),
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        state.assignedCompanySites.isNotEmpty
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'The following projects are associated with this company. Edit company to associate/ remove sites from this company',
                  style: TextStyle(
                    fontSize: 14,
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
          child:
              state.assignedCompanySitesRetrievedStatus == EntityStatus.loading
                  ? const Padding(
                      padding: EdgeInsets.only(top: 300),
                      child: CircularProgressIndicator(),
                    )
                  : state.assignedCompanySites.isNotEmpty
                      ? DataTable(
                          columns: columns,
                          rows: rows,
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                'This company has no projects assigned to it yet.',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            CustomDivider(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                'Projects can be assigned by editing the company and going to the projects tab to select from available companies',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            CustomDivider(),
                          ],
                        ),
        ),
      ],
    );
  }

  void _checkDeleteCompanyStatus(CompaniesState state, BuildContext context) {
    if (state.companyCrudStatus == EntityStatus.success) {
      companiesBloc.add(CompaniesStatusInited());
      CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: state.message,
      ).showNotification();

      GoRouter.of(context).go('/companies');
    }
    if (state.companyCrudStatus == EntityStatus.failure) {
      companiesBloc.add(CompaniesStatusInited());
      CustomNotification(
        context: context,
        notifyType: NotifyType.error,
        content: state.message,
      ).showNotification();
    }
  }
}
