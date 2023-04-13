import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '/constants/color.dart';
import '/data/model/model.dart';
import '/data/bloc/bloc.dart';
import '/global_widgets/global_widget.dart';

class AssignCompaniesToProjectView extends StatefulWidget {
  final String projectId;
  final String projectName;
  const AssignCompaniesToProjectView({
    super.key,
    required this.projectId,
    required this.projectName,
  });

  @override
  State<AssignCompaniesToProjectView> createState() =>
      _AssignCompaniesToProjectViewState();
}

class _AssignCompaniesToProjectViewState
    extends State<AssignCompaniesToProjectView> {
  TextEditingController filterController = TextEditingController(
    text: '',
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SitesBloc, SitesState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Then project \' ${widget.projectId} \' has been created.',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                'Companies can be assigned from list on right. Once assigned they will show here in this list.',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
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
                                          onChanged: (value) {},
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
                          child: DataTable(
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
                                          onChanged: (value) {},
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
