import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '/constants/color.dart';
import '/data/model/model.dart';
import '/data/bloc/bloc.dart';
import '/global_widgets/global_widget.dart';

class AssignCompaniesToProjectView extends StatefulWidget {
  final String projectId;
  const AssignCompaniesToProjectView({
    super.key,
    required this.projectId,
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

  Widget _buildTitle() {
    return const PageTitle(
      title: 'Assign Companies',
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
      text: 'Project Details',
      onClick: () {
        GoRouter.of(context).go('/projects/show/${widget.projectId}');
      },
    );
  }

  CustomButton _buildGoToListButton(BuildContext context) {
    return CustomButton(
      backgroundColor: primaryColor,
      hoverBackgroundColor: primaryHoverColor,
      iconData: PhosphorIcons.listNumbers,
      text: 'Projects List',
      onClick: () {
        GoRouter.of(context).go('/projects');
      },
    );
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
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Expanded(
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //             child: Row(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(
              //                   'Then project \' ${widget.projectId} \' has been created.',
              //                   style: const TextStyle(
              //                     fontSize: 12,
              //                     fontWeight: FontWeight.w600,
              //                   ),
              //                 ),
              //                 const Text(
              //                   'Companies can be assigned from list on right. Once assigned they will show here in this list.',
              //                   style: TextStyle(
              //                     fontSize: 12,
              //                     fontWeight: FontWeight.w400,
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ),
              //           const CustomDivider(),
              //           SizedBox(
              //             width: double.infinity,
              //             child: DataTable(
              //               columns: const [
              //                 DataColumn(
              //                   label: Text('Assigned?'),
              //                 ),
              //                 DataColumn(
              //                   label: Text(
              //                     'Template Name',
              //                   ),
              //                 ),
              //                 DataColumn(
              //                   label: Text(
              //                     'Created By',
              //                   ),
              //                 ),
              //                 DataColumn(
              //                   label: Text(
              //                     'Last Revised on',
              //                   ),
              //                 ),
              //               ],
              //               rows: List<AuditTemplate>.from(state.templates)
              //                   .where(
              //                       (auditTemplate) => auditTemplate.assigned)
              //                   .map(
              //                     (auditTemplate) => DataRow(
              //                       cells: [
              //                         DataCell(
              //                           CustomSwitch(
              //                             switchValue: auditTemplate.assigned,
              //                             trueString: 'Yes',
              //                             falseString: 'No',
              //                             textColor: darkTeal,
              //                             onChanged: (value) {
              //                               AwesomeDialog(
              //                                 context: context,
              //                                 width: MediaQuery.of(context)
              //                                         .size
              //                                         .width /
              //                                     4,
              //                                 dialogType: DialogType.question,
              //                                 headerAnimationLoop: false,
              //                                 animType: AnimType.bottomSlide,
              //                                 title: 'Confirm',
              //                                 dialogBorderRadius:
              //                                     BorderRadius.circular(5),
              //                                 desc:
              //                                     'Do you really want to remove this template from site?',
              //                                 buttonsTextStyle: const TextStyle(
              //                                   color: Colors.white,
              //                                 ),
              //                                 showCloseIcon: true,
              //                                 btnCancelOnPress: () {},
              //                                 btnOkOnPress: () {},
              //                                 btnOkText: 'Remove',
              //                                 buttonsBorderRadius:
              //                                     BorderRadius.circular(3),
              //                                 padding: const EdgeInsets.all(10),
              //                               ).show();
              //                             },
              //                           ),
              //                         ),
              //                         ...List.from(auditTemplate
              //                                 .toTableDetailMap()
              //                                 .values)
              //                             .map(
              //                               (detail) => DataCell(
              //                                 CustomDataCell(
              //                                   data: detail,
              //                                 ),
              //                               ),
              //                             )
              //                             .toList()
              //                       ],
              //                     ),
              //                   )
              //                   .toList(),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 150,
              //     ),
              //     Expanded(
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           const Text(
              //             'Templates can be assigned to this site by selecting from the list below.',
              //             style: TextStyle(
              //               fontSize: 12,
              //               fontWeight: FontWeight.w400,
              //             ),
              //           ),
              //           const CustomDivider(),
              //           Padding(
              //             padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //             child: CustomTextField(
              //               hintText: 'Filter unassigned sites by name..',
              //               onChanged: (value) {},
              //               controller: filterController,
              //               suffixIconData: PhosphorIcons.funnel,
              //             ),
              //           ),
              //           const CustomDivider(),
              //           SizedBox(
              //             child: DataTable(
              //               columns: const [
              //                 DataColumn(
              //                   label: Text('Assigned?'),
              //                 ),
              //                 DataColumn(
              //                   label: Text(
              //                     'Template Name',
              //                   ),
              //                 ),
              //                 DataColumn(
              //                   label: Text(
              //                     'Created By',
              //                   ),
              //                 ),
              //                 DataColumn(
              //                   label: Text(
              //                     'Last Revised on',
              //                   ),
              //                 ),
              //               ],
              //               rows: state.templates
              //                   .where(
              //                       (auditTemplate) => !auditTemplate.assigned)
              //                   .map(
              //                     (auditTemplate) => DataRow(
              //                       cells: [
              //                         DataCell(
              //                           CustomSwitch(
              //                             trueString: 'Yes',
              //                             falseString: 'No',
              //                             textColor: darkTeal,
              //                             switchValue: auditTemplate.assigned,
              //                             onChanged: (value) {},
              //                           ),
              //                         ),
              //                         ...auditTemplate
              //                             .toTableDetailMap()
              //                             .values
              //                             .map(
              //                               (detail) => DataCell(
              //                                 CustomDataCell(data: detail),
              //                               ),
              //                             )
              //                             .toList(),
              //                       ],
              //                     ),
              //                   )
              //                   .toList(),
              //             ),
              //           ),
              //         ],
              //       ),
              //     )
              //   ],
              // ),
            ],
          ),
        );
      },
    );
  }
}
