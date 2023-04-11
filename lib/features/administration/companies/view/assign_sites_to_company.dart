import 'package:awesome_dialog/awesome_dialog.dart';
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
  const AssignSitesToCompanyView({
    super.key,
    required this.companyId,
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
      ..add(CompanySitesRetrieved(companyId: widget.companyId));
    super.initState();
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
      text: 'Show Site',
      onClick: () {
        GoRouter.of(context).go('/sites/show/${widget.companyId}');
      },
    );
  }

  CustomButton _buildGoToListButton(BuildContext context) {
    return CustomButton(
      backgroundColor: primaryColor,
      hoverBackgroundColor: primarHoverColor,
      iconData: PhosphorIcons.listNumbers,
      text: 'Sites List',
      onClick: () {
        GoRouter.of(context).go('/sites');
      },
    );
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
                        Padding(
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
                                      'The company \' ${widget.companyId} \' has been created.',
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
                        ),
                        const CustomDivider(),
                        SizedBox(
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              title: 'Confirm',
                                              description:
                                                  'Do you really want to remove this template from site?',
                                              btnOkText: 'Remove',
                                              btnOkOnPress: () {
                                                
                                              },
                                              dialogType: DialogType.question,
                                            );
                                          },
                                        ),
                                      ),
                                      // ...List.from(auditTemplate
                                      //         .toTableDetailMap()
                                      //         .values)
                                      //     .map(
                                      //       (detail) => DataCell(
                                      //         CustomDataCell(
                                      //           data: detail,
                                      //         ),
                                      //       ),
                                      //     )
                                      //     .toList()
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
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
                          'Templates can be assigned to this site by selecting from the list below.',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const CustomDivider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: CustomTextField(
                            hintText: 'Filter unassigned sites by name..',
                            onChanged: (value) {},
                            controller: filterController,
                            suffixIconData: PhosphorIcons.funnel,
                          ),
                        ),
                        const CustomDivider(),
                        SizedBox(
                          child: DataTable(columns: const [
                            DataColumn(
                              label: Text('Assigned?'),
                            ),
                            DataColumn(
                              label: Text(
                                'Site Name',
                              ),
                            ),
                          ], rows: []
                              // state.selectedCompany!.sites
                              //     .where(
                              //         (auditTemplate) => !auditTemplate.assigned)
                              //     .map(
                              //       (auditTemplate) => DataRow(
                              //         cells: [
                              //           DataCell(
                              //             CustomSwitch(
                              //               trueString: 'Yes',
                              //               falseString: 'No',
                              //               textColor: darkTeal,
                              //               switchValue: auditTemplate.assigned,
                              //               onChanged: (value) {
                              //                 sitesBloc.add(
                              //                   AuditTemplateAssignedToSite(
                              //                     auditTemplateId:
                              //                         auditTemplate.id,
                              //                   ),
                              //                 );
                              //               },
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
                        ),
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
}
