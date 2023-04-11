import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      ..add(ProjectCompaniesRetrieved(companyId: widget.companyId));
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildTitle(),
                    const SizedBox(
                      width: 15,
                    ),
                    _buildCrudButtons(context),
                  ],
                ),
              ),
              const CustomDivider(),
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
                        _buildUnassignedProjectsTableView(),
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

  Widget _buildTitle() {
    return const PageTitle(
      title: 'Assign projects to company',
    );
  }

  Row _buildCrudButtons(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildGoToListButton(context),
        SizedBox(
          width: MediaQuery.of(context).size.width / 40,
        ),
        _buildShowButton(context),
        const SizedBox(
          width: 50,
        )
      ],
    );
  }

  CustomButton _buildShowButton(BuildContext context) {
    return CustomButton(
      backgroundColor: const Color(0xff8e70c1),
      hoverBackgroundColor: const Color(0xff8065ae),
      iconData: PhosphorIcons.notePencil,
      text: 'Company Details',
      onClick: () {
        GoRouter.of(context).go('/companies/show/${widget.companyId}');
      },
    );
  }

  CustomButton _buildGoToListButton(BuildContext context) {
    return CustomButton(
      backgroundColor: primaryColor,
      hoverBackgroundColor: primarHoverColor,
      iconData: PhosphorIcons.listNumbers,
      text: 'Companies List',
      onClick: () {
        GoRouter.of(context).go('/companies');
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

  SizedBox _buildAssignedProjectsTableView(
      CompaniesState state, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
        columns: tableColumns,
        rows: List<CompanySite>.from(state.companySites)
            .map(
              (companySite) => DataRow(
                cells: [
                  DataCell(
                    CustomSwitch(
                      switchValue: true,
                      trueString: 'Yes',
                      falseString: 'No',
                      textColor: darkTeal,
                      onChanged: (value) {
                        CustomAlert(
                          context: context,
                          width: MediaQuery.of(context).size.width / 4,
                          title: 'Confirm',
                          description:
                              'Do you really want to remove this project from company?',
                          btnOkText: 'Remove',
                          btnOkOnPress: () {},
                          dialogType: DialogType.question,
                        );
                      },
                    ),
                  ),
                  DataCell(
                    CustomDataCell(
                      data: companySite.siteName,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  SizedBox _buildUnassignedProjectsTableView() {
    return SizedBox(
      child: DataTable(
        columns: tableColumns,
        rows: [],
        // state.selectedCompany!.sites
        //     .map(
        //       (auditTemplate) => DataRow(
        //         cells: [
        //           DataCell(
        //             CustomSwitch(
        //               trueString: 'Yes',
        //               falseString: 'No',
        //               textColor: darkTeal,
        //               switchValue: false,
        //               onChanged: (value) {},
        //             ),
        //           ),
        //           ...auditTemplate
        //               .toTableDetailMap()
        //               .values
        //               .map(
        //                 (detail) => DataCell(
        //                   CustomDataCell(data: detail),
        //                 ),
        //               )
        //               .toList(),
        //         ],
        //       ),
        //     )
        //     .toList(),
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
        onSuffixIconClick: () => _filterApplied(),
      ),
    );
  }

  void _filterApplied() {
    filterController.text =
        'Showing companies matching \'${filterController.text}\' below..';
  }

  Widget _buildSiteSelectField() {
    return BlocBuilder<CompaniesBloc, CompaniesState>(
      builder: (context, state) {
        return SizedBox(
          width: 150,
          child: CustomMultiSelect(
            items: state.selectedCompany != null
                ? (<String, Site>{}..addEntries(
                    state.selectedCompany!.sites.map(
                      (site) => MapEntry(site.name!, site),
                    ),
                  ))
                : {},
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
}
