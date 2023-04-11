import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '/data/model/model.dart';
import '/utils/utils.dart';
import '/constants/color.dart';
import '/global_widgets/global_widget.dart';
import '/data/bloc/bloc.dart';

class AssignSitesToCompanyView extends StatefulWidget {
  final String companyId;
  final String companyName;
  const AssignSitesToCompanyView({
    super.key,
    required this.companyId,
    required this.companyName,
  });

  @override
  State<AssignSitesToCompanyView> createState() =>
      _AssignSitesToCompanyViewState();
}

class _AssignSitesToCompanyViewState extends State<AssignSitesToCompanyView> {
  late CompaniesBloc sitesBloc;
  TextEditingController filterController = TextEditingController(
    text: '',
  );

  @override
  void initState() {
    sitesBloc = context.read<CompaniesBloc>()
      ..add(CompanySitesRetrieved(companyId: widget.companyId))
      ..add(CompanySelectedById(companyId: widget.companyId));
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
                        _buildFilterTextField(),
                        const CustomDivider(),
                        _buildUnassignedSitesTableView(),
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
              text: 'The company \'${widget.companyName}\' has been created.',
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

  Widget _buildTitle() {
    return const PageTitle(
      title: 'Assign sites to company',
    );
  }

  Row _buildCrudButtons(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAssignProjectsButton(context),
        const SizedBox(
          width: 50,
        ),
      ],
    );
  }

  CustomButton _buildAssignProjectsButton(BuildContext context) {
    return CustomButton(
      backgroundColor: primaryColor,
      hoverBackgroundColor: primarHoverColor,
      iconData: PhosphorIcons.arrowRight,
      text: 'Assign Projects',
      onClick: () {
        GoRouter.of(context).go(
            '/companies/assign-projects?companyId=${widget.companyId}&companyName=${widget.companyName}');
      },
    );
  }

  SizedBox _buildUnassignedSitesTableView() {
    return SizedBox(
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
        ],
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

  SizedBox _buildAssignedSitesTableView(
      CompaniesState state, BuildContext context) {
    return SizedBox(
      width: double.infinity,
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
        ],
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
                              'Do you really want to remove this site from company?',
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

  Padding _buildFilterTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CustomTextField(
        hintText: 'Filter unassigned sites by name..',
        onChanged: (value) {},
        controller: filterController,
        suffixIconData: PhosphorIcons.funnel,
      ),
    );
  }
}
