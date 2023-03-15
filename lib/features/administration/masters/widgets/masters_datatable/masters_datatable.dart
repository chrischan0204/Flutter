import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'widgets/custom_select.dart';
import '/global_widgets/global_widget.dart';
import '/data/model/entity.dart';
import '../../../../theme/view/widgets/sidebar/sidebar_style.dart';
import 'widgets/custom_multi_select.dart';
import 'widgets/custom_switch.dart';
import 'widgets/notify.dart';
import 'widgets/page_title.dart';

class MasterTable extends StatefulWidget {
  const MasterTable({
    super.key,
    this.entities = const [],
    required this.description,
    required this.title,
    required this.label,
  });
  final List<Entity> entities;
  final String title;
  final String description;
  final String label;

  @override
  State<MasterTable> createState() => _CrudState();
}

class _CrudState extends State<MasterTable> {
  bool isEdit = false;

  List<DataColumn> _buildColumns() {
    if (widget.entities.isNotEmpty) {
      return [
        ...widget.entities[0]
            .tableItemsToMap()
            .keys
            .map(
              (key) => DataColumn(
                label: Expanded(
                  child: Text(
                    key,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      // color: Color(0xff1f2937),
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
              ),
            )
            .toList(),
        const DataColumn(
          label: Expanded(
            child: Text(
              'Action',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        )
      ];
    }
    return [];
  }

  List<DataRow> _buildRows() {
    return widget.entities
        .map(
          (entity) => DataRow(
            color: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (entity.tableItemsToMap().containsKey('Active') &&
                  !entity.tableItemsToMap()['Active']) {
                return const Color(0xffe6e7e8);
              }
              return null; // Use the default value.
            }),
            cells: [
              ...entity
                  .tableItemsToMap()
                  .values
                  .map((value) => DataCell(_buildCell(value)))
                  .toList(),
              DataCell(
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isEdit = true;
                      });
                    },
                    child: const Icon(
                      PhosphorIcons.caretDoubleRight,
                      size: 20,
                      color: Color(0xff0c83ff),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
        .toList();
  }

  Widget _buildCell(dynamic data) {
    if (data is bool) {
      return Text(
        data ? 'Yes' : 'No',
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xff1f2937),
          fontWeight: FontWeight.w400,
          fontFamily: 'OpenSans',
        ),
      );
    } else if (data is Color) {
      return Container(
        width: double.infinity,
        height: 25,
        decoration: BoxDecoration(color: data),
      );
    } else if (data is List) {
      return Text(
        data.join(', '),
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xff1f2937),
          fontWeight: FontWeight.w400,
          fontFamily: 'OpenSans',
        ),
      );
    }
    return Text(
      data.toString(),
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xff1f2937),
        fontWeight: FontWeight.w400,
        fontFamily: 'OpenSans',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Notify(
          content: 'Region been successfully added....',
          type: NotifyType.success,
        ),
        const Notify(
          content:
              'There was an error while adding. Our team has been notified. Please wait a few minutes and try again....',
          type: NotifyType.failture,
        ),
        PageTitle(
          title: widget.title,
        ),
        const CustomDivider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 5,
              child: Container(
                width: double.infinity,
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Description(
                      description: widget.description,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1,
                            color: sidebarColor,
                          ),
                        ),
                      ),
                      child: widget.entities.isNotEmpty
                          ? DataTable(
                              headingRowHeight: 46,
                              dataRowHeight: 46,
                              columns: _buildColumns(),
                              rows: _buildRows(),
                            )
                          : Container(),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              flex: 2,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 5 / 6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CrudTitle(
                      label: widget.label,
                      type: isEdit ? 'Edit/Remove' : 'Add new',
                    ),
                    const CustomDivider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Flexible(
                            flex: 3,
                            child: Text(
                              'Region(*)',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 7,
                            child: CustomSelect(
                              items: [
                                'Africa',
                                'Central America',
                                'Middle East',
                                'North America - South East',
                                'Oceania',
                                'South America',
                                'The Carribean',
                              ],
                              hint: 'Select Region',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const CustomDivider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Flexible(
                            flex: 3,
                            child: Text(
                              'Timezone(*)',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 7,
                            child: CustomMultiSelect(
                              items: [
                                'Eastern Standard Time | EST | UTC -5',
                                'Central Standard Time | CST | UTC -6',
                                'Mountain Standard Time | MST | UTC -7',
                                'Pacific Standard Time | PST | UTC -8',
                                'Alaska Standard Time | AST | UTC -9',
                                'Hawaii Standard Time | HST | UTC -10',
                              ],
                              hint: 'Select Time Zone',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const CustomDivider(),
                    ...(isEdit
                        ? [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'This region has 2 sites associated & cannot be deleted. Only time zone can be changed or this region can be deactivated. After deactivation it wont be available for any further site allocations. The current sites will be maintained as is.',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const CustomDivider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Flexible(
                                    flex: 3,
                                    child: Text(
                                      'Deactivate?',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 7,
                                    child: CustomSwitch(
                                      label: 'region',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const CustomDivider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Flexible(
                                    flex: 3,
                                    child: Text(
                                      'Deactivated:',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 7,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30.0),
                                      child: Text(
                                        'By: Andrew Sully on 12th Jan 2023',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'OpenSans',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const CustomDivider(),
                          ]
                        : []),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: Row(
                        children: [
                          isEdit
                              ? CustomButton(
                                  backgroundColor: const Color(
                                    0xfff58646,
                                  ),
                                  iconData: PhosphorIcons.pencilLine,
                                  onClick: () {},
                                  text: 'Edit Region',
                                )
                              : CustomButton(
                                  backgroundColor: const Color(
                                    0xff059669,
                                  ),
                                  iconData: PhosphorIcons.plus,
                                  onClick: () {},
                                  text: 'Add Region',
                                ),
                          const SizedBox(
                            width: 30,
                          ),
                          isEdit
                              ? CustomButton(
                                  backgroundColor: const Color(
                                    0xfff58686,
                                  ),
                                  iconData: PhosphorIcons.trashSimple,
                                  onClick: () {},
                                  text: 'Delete',
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Description extends StatelessWidget {
  const Description({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17),
      child: Text(
        description,
        style: const TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }
}

class CrudTitle extends StatelessWidget {
  const CrudTitle({
    super.key,
    required this.label,
    this.type = 'Add new',
  });

  final String label;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 20,
      ),
      child: Text(
        '$type $label',
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
