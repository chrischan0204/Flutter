import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:safety_eta/utils/custom_alert.dart';

import '/constants/constants.dart';
import '/data/model/model.dart';
import '/data/bloc/bloc.dart';
import '/global_widgets/global_widget.dart';

class AssignTemplatesToSiteView extends StatefulWidget {
  final String siteId;
  final String siteName;
  const AssignTemplatesToSiteView({
    super.key,
    required this.siteId,
    required this.siteName,
  });

  @override
  State<AssignTemplatesToSiteView> createState() =>
      _AssignTemplatesToSiteViewState();
}

class _AssignTemplatesToSiteViewState extends State<AssignTemplatesToSiteView> {
  late SitesBloc sitesBloc;
  TextEditingController filterController = TextEditingController(text: '');

  @override
  void initState() {
    sitesBloc = context.read<SitesBloc>()..add(AuditTemplatesRetrieved());
    super.initState();
  }

  Widget _buildTitle() {
    return const PageTitle(
      title: 'Assign templates to site',
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
      iconData: PhosphorIcons.regular.notePencil,
      text: 'Show Site',
      onClick: () {
        GoRouter.of(context).go('/sites/show/${widget.siteId}');
      },
    );
  }

  CustomButton _buildGoToListButton(BuildContext context) {
    return CustomButton(
      backgroundColor: primaryColor,
      hoverBackgroundColor: primaryHoverColor,
      iconData: PhosphorIcons.regular.listNumbers,
      text: 'Sites List',
      onClick: () {
        GoRouter.of(context).go('/sites');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SitesBloc, SitesState>(
      builder: (context, state) {
        return Container();
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
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Templates can be assigned to this site by selecting from the list below.',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const CustomDivider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: CustomTextField(
                            hintText: 'Filter unassigned sites by name..',
                            onChanged: (value) {},
                            controller: filterController,
                            suffixIconData: PhosphorIcons.regular.funnel,
                          ),
                        ),
                        const CustomDivider(),
                        SizedBox(
                          child: DataTable(
                            headingTextStyle: tableHeadingTextStyle,
                            dataTextStyle: tableDataTextStyle,
                            columns: const [
                              DataColumn(
                                label: Text('Assigned?'),
                              ),
                              DataColumn(
                                label: Text(
                                  'Template Name',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Created By',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Last Revised on',
                                ),
                              ),
                            ],
                            rows: state.templates
                                .where(
                                    (auditTemplate) => !auditTemplate.assigned)
                                .map(
                                  (auditTemplate) => DataRow(
                                    cells: [
                                      DataCell(
                                        CustomSwitch(
                                          trueString: 'Yes',
                                          falseString: 'No',
                                          textColor: darkTeal,
                                          switchValue: auditTemplate.assigned,
                                          onChanged: (value) {
                                            sitesBloc.add(
                                              AuditTemplateAssignedToSite(
                                                auditTemplateId:
                                                    auditTemplate.id,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      ...auditTemplate
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'OpenSans',
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      'Sites can be assigned from list on left. Once assigned they will show here in this list below.',
                                ),
                              ],
                            ),
                          ),
                        ),
                        const CustomDivider(),
                        SizedBox(
                          width: double.infinity,
                          child: DataTable(
                            headingTextStyle: tableHeadingTextStyle,
                            dataTextStyle: tableDataTextStyle,
                            columns: const [
                              DataColumn(
                                label: Text('Assigned?'),
                              ),
                              DataColumn(
                                label: Text(
                                  'Template Name',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Created By',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Last Revised on',
                                ),
                              ),
                            ],
                            rows: List<AuditTemplate>.from(state.templates)
                                .where(
                                    (auditTemplate) => auditTemplate.assigned)
                                .map(
                                  (auditTemplate) => DataRow(
                                    cells: [
                                      DataCell(
                                        CustomSwitch(
                                          switchValue: auditTemplate.assigned,
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
                                                sitesBloc.add(
                                                  AuditTemplateAssignedToSite(
                                                    auditTemplateId:
                                                        auditTemplate.id,
                                                  ),
                                                );
                                              },
                                              dialogType: DialogType.question,
                                            );
                                          },
                                        ),
                                      ),
                                      ...List.from(auditTemplate
                                              .toTableDetailMap()
                                              .values)
                                          .map(
                                            (detail) => DataCell(
                                              CustomDataCell(
                                                data: detail,
                                              ),
                                            ),
                                          )
                                          .toList()
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
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
}
