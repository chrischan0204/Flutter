import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '/data/model/model.dart';
import '/utils/utils.dart';
import '/constants/color.dart';
import '/global_widgets/global_widget.dart';
import '/data/bloc/bloc.dart';

class AssignProjectsToCompanyView extends StatefulWidget {
  final String companyId;
  final String companyName;
  const AssignProjectsToCompanyView({
    super.key,
    required this.companyId,
    required this.companyName,
  });

  @override
  State<AssignProjectsToCompanyView> createState() =>
      _AssignProjectsToCompanyViewState();
}

class _AssignProjectsToCompanyViewState
    extends State<AssignProjectsToCompanyView> {
  late CompaniesBloc companiesBloc;
  TextEditingController filterController = TextEditingController(
    text: '',
  );

  @override
  void initState() {
    companiesBloc = context.read<CompaniesBloc>()
      ..add(AssignedProjectCompaniesRetrieved(companyId: widget.companyId))
      ..add(UnassignedProjectCompaniesRetrieved(companyId: widget.companyId));
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
                        _buildAssignedProjectsTableViewHeader(),
                        const CustomDivider(),
                        _buildAssignedProjectsTableView(state, context),
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
                        _buildUnassignedProjectsTableViewHeader(),
                        const CustomDivider(),
                        _buildFilterProjectView(),
                        const CustomDivider(),
                        _buildUnassignedProjectsTableView(state),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Text _buildUnassignedProjectsTableViewHeader() {
    return const Text(
      'Projects can be assigned to this company by selecting from the list below. Projects list can be filtered by name or by site.',
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildAssignedProjectsTableView(
      CompaniesState state, BuildContext context) {
    return state.assignedProjectCompaniesRetrievedStatus == EntityStatus.loading
        ? const Padding(
            padding: EdgeInsets.only(top: 300),
            child: CircularProgressIndicator(),
          )
        : SizedBox(
            width: double.infinity,
            child: DataTable(
              columns: tableColumns,
              rows: List<CompanySite>.from(state.assignedProjectCompanies)
                  .map(
                    (projectCompany) => DataRow(
                      cells: [
                        DataCell(
                          CustomSwitch(
                            switchValue: true,
                            trueString: 'Yes',
                            falseString: 'No',
                            textColor: darkTeal,
                            onChanged: (value) =>
                                _unassignProjectFromCompany(projectCompany.id),
                          ),
                        ),
                        DataCell(
                          CustomDataCell(
                            data: projectCompany.siteName,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          );
  }

  Widget _buildUnassignedProjectsTableView(CompaniesState state) {
    return state.unassignedProjectCompaniesRetrievedStatus ==
            EntityStatus.loading
        ? const Padding(
            padding: EdgeInsets.only(top: 300),
            child: CircularProgressIndicator(),
          )
        : SizedBox(
            child: DataTable(
              columns: tableColumns,
              rows: state.unassignedProjectCompanies
                  .map(
                    (unassignedProjectCompany) => DataRow(
                      cells: [
                        DataCell(
                          CustomSwitch(
                            trueString: 'Yes',
                            falseString: 'No',
                            textColor: darkTeal,
                            switchValue: false,
                            onChanged: (value) => _assignProjectToCompany(
                                unassignedProjectCompany),
                          ),
                        ),
                        ...unassignedProjectCompany
                            .toTableDetailMap()
                            .values
                            .map(
                              (detail) => DataCell(
                                CustomDataCell(data: detail),
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  )
                  .toList(),
            ),
          );
  }

  List<DataColumn> get tableColumns {
    return const [
      DataColumn(
        label: Text('Assigned?'),
      ),
      DataColumn(
        label: Text(
          'Project Name',
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
    ];
  }

  Widget _buildFilterProjectView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          _buildFilterProjectTextField(),
          const SizedBox(
            width: 50,
          ),
          _buildSiteSelectField(),
        ],
      ),
    );
  }

  Expanded _buildFilterProjectTextField() {
    return Expanded(
      child: CustomTextField(
        hintText: 'Filter unassigned projects by name..',
        onChanged: (value) {},
        controller: filterController,
        suffixIconData: PhosphorIcons.funnel,
        onSuffixIconClick: () => _filterApply(),
      ),
    );
  }

  Widget _buildSiteSelectField() {
    return BlocBuilder<CompaniesBloc, CompaniesState>(
      builder: (context, state) {
        return SizedBox(
          width: 150,
          child: CustomMultiSelect(
            items: {},
            selectedItems: [],
            hint: 'Filter by site',
            onChanged: (sites) {
              // filterSites = sites.map((site) => site as Site).toList();
            },
          ),
        );
      },
    );
  }

  Padding _buildAssignedProjectsTableViewHeader() {
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
              text: 'Projects can be assigned to \' ${widget.companyName} \'',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const TextSpan(
              text:
                  '  Projects are listed as per the sites assigned to this company.',
            ),
          ],
        ),
      ),
    );
  }

  void _assignProjectToCompany(ProjectCompany projectCompany) {
    companiesBloc.add(ProjectToCompanyAssigned(
        projectCompanyAssignment: projectCompany.toProjectCompanyAssignment()));
  }

  void _unassignProjectFromCompany(String projectCompanyId) {
    CustomAlert(
      context: context,
      width: MediaQuery.of(context).size.width / 4,
      title: 'Confirm',
      description: 'Do you really want to remove this project from company?',
      btnOkText: 'Remove',
      btnOkOnPress: () {
        companiesBloc.add(ProjectFromCompanyUnassigned(
            projectCompanyAssignmentId: projectCompanyId));
      },
      dialogType: DialogType.question,
    );
  }

  _filterApply() {
    filterController.text =
        'Showing companies matching \'${filterController.text}\' below..';
    companiesBloc.add(UnassignedCompanySitesRetrieved(
      companyId: widget.companyId,
      name: filterController.text,
    ));
  }
}
