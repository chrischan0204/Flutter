import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:safety_eta/features/administration/companies/view/widgets/filter_textfield.dart';

import '/data/model/model.dart';
import '/utils/utils.dart';
import '/constants/color.dart';
import '/global_widgets/global_widget.dart';
import '/data/bloc/bloc.dart';

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
  TextEditingController filterController = TextEditingController(text: '');

  @override
  void initState() {
    companiesBloc = context.read<CompaniesBloc>()
      ..add(const FilterTextForUnassignedSitesChanged(filterText: ''));
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAssignedSitesTableViewHeader(state),
                        const CustomDivider(),
                        _buildAssignedSitesTableView(state, context),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 150,
                  ),
                  Expanded(
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
                        _buildFilterTextField(state),
                        const CustomDivider(),
                        _buildUnassignedSitesTableView(state),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Padding _buildAssignedSitesTableViewHeader(CompaniesState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontFamily: 'OpenSans',
          ),
          children: <TextSpan>[
            TextSpan(
              text:
                  'The company \'${widget.companyName}\' has been ${widget.view == 'created' ? 'created' : 'updated'}.',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const TextSpan(
              text:
                  ' Sites can be assigned from list on right. Once assigned they will show here in this list below.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnassignedSitesTableView(CompaniesState state) {
    return SizedBox(
      child: BlocBuilder<RolesBloc, RolesState>(
        builder: (context, rolesState) {
          return BlocListener<CompaniesBloc, CompaniesState>(
            listener: (context, state) {
              if (state.siteToCompanyUnassignedStatus == EntityStatus.success) {
                CustomNotification(
                  context: context,
                  notifyType: NotifyType.success,
                  content: state.message,
                ).showNotification();
                _refetchCompanySites(state.filterText);
              } else if (state.siteToCompanyUnassignedStatus ==
                  EntityStatus.failure) {
                CustomNotification(
                  context: context,
                  notifyType: NotifyType.error,
                  content: state.message,
                ).showNotification();
              }
            },
            listenWhen: (previous, current) =>
                previous.siteToCompanyUnassignedStatus !=
                current.siteToCompanyUnassignedStatus,
            child: DataTable(
              columns: const [
                DataColumn(
                  label: Text('Assigned?'),
                ),
                DataColumn(
                  label: Text(
                    'Site Name',
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Role',
                  ),
                ),
              ],
              rows: state.unassignedCompanySites
                  .map(
                    (unassignedCompanySite) => DataRow(
                      cells: [
                        DataCell(
                          CustomSwitch(
                            trueString: 'Yes',
                            falseString: 'No',
                            textColor: darkTeal,
                            switchValue: false,
                            onChanged: (value) =>
                                _assignSiteToCompany(unassignedCompanySite),
                          ),
                        ),
                        DataCell(
                          CustomDataCell(
                            data: unassignedCompanySite.siteName,
                          ),
                        ),
                        DataCell(
                          CustomSingleSelect(
                            items: {}..addEntries(rolesState.roles
                                .map((role) => MapEntry(role.name, role))),
                            hint: 'Select Role',
                            selectedValue: rolesState.roles.isNotEmpty
                                ? unassignedCompanySite.roleName.isNotEmpty
                                    ? unassignedCompanySite.roleName
                                    : null
                                : null,
                            onChanged: (role) => companiesBloc
                                .add(UnAssignedCompanySiteRoleSelected(
                              role: role.value,
                              companySiteIndex: state.unassignedCompanySites
                                  .indexOf(unassignedCompanySite),
                            )),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          );
        },
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
            _refetchCompanySites(state.filterText);
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
          columns: const [
            DataColumn(
              label: Text('Assigned?'),
            ),
            DataColumn(
              label: Text(
                'Site Name',
              ),
            ),
            DataColumn(
              label: Text(
                'Role Name',
              ),
            ),
          ],
          rows: List<CompanySite>.from(state.assignedCompanySites)
              .map(
                (assignedCompanySite) => DataRow(
                  cells: [
                    DataCell(
                      CustomSwitch(
                        switchValue: true,
                        trueString: 'Yes',
                        falseString: 'No',
                        textColor: darkTeal,
                        onChanged: (value) =>
                            _unassignFromCompany(assignedCompanySite.id!),
                      ),
                    ),
                    DataCell(
                      CustomDataCell(
                        data: assignedCompanySite.siteName,
                      ),
                    ),
                    DataCell(
                      CustomDataCell(
                        data: assignedCompanySite.roleName,
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
    if (companySite.roleId.contains('00000000')) {
      CustomAlert(
        context: context,
        width: MediaQuery.of(context).size.width / 4,
        title: 'Notification',
        description: 'Please select a role for the company first.',
        btnOkText: 'OK',
        btnOkOnPress: () {},
        dialogType: DialogType.warning,
      ).show();
    } else {
      companiesBloc.add(SiteToCompanyAssigned(
          companySiteUpdation: companySite.toCompanySiteUpdation()));
    }
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

  Padding _buildFilterTextField(CompaniesState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: FilterTextField(
        hintText: 'Filter unassigned sites by name..',
        label: 'sites',
        filterController: filterController,
        filterIconClick: (filtered) {
          if (filtered) {
            _applyFilter(state);
          } else {
            _cancelFilter();
          }
        },
        onChange: (value) => companiesBloc
            .add(FilterTextForUnassignedSitesChanged(filterText: value)),
      ),
    );
  }

  _applyFilter(CompaniesState state) {
    companiesBloc.add(UnassignedCompanySitesRetrieved(
      companyId: widget.companyId,
      name: state.filterText,
    ));
  }

  _cancelFilter() {
    companiesBloc
        .add(UnassignedCompanySitesRetrieved(companyId: widget.companyId));
  }

  _refetchCompanySites(String filterText) {
    companiesBloc
      ..add(AssignedCompanySitesRetrieved(companyId: widget.companyId))
      ..add(UnassignedCompanySitesRetrieved(
        companyId: widget.companyId,
        name: filterText,
      ));
  }
}
