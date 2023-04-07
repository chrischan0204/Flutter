import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '/constants/color.dart';
import '../../custom_data_cell.dart';
import '/data/model/entity.dart';

class DataTableView extends StatefulWidget {
  final ValueChanged<Entity> onRowClick;
  final String emptyMessage;
  final ValueChanged<MapEntry<String, bool>>? onTableSort;
  const DataTableView({
    super.key,
    this.entities = const [],
    required this.onRowClick,
    this.emptyMessage = '',
    this.onTableSort,
  });
  final List<Entity> entities;

  @override
  State<DataTableView> createState() => _DataTableViewState();
}

class _DataTableViewState extends State<DataTableView> {
  int? selectedColumnIndex;
  bool sortType = true;

  List<DataColumn> _buildColumns() {
    if (widget.entities.isNotEmpty) {
      List<String> columns = widget.entities[0].tableItemsToMap().keys.toList();
      return [
        ...columns
            .map(
              (column) => DataColumn(
                label: Builder(
                  builder: (context) {
                    int index = columns.indexOf(column);
                    return GestureDetector(
                      onTap: () {
                        if (widget.onTableSort != null) {
                          if (selectedColumnIndex == index) {
                            setState(() {
                              sortType = !sortType;
                            });
                          } else {
                            setState(() {
                              selectedColumnIndex = index;
                              sortType = true;
                            });
                          }
                          widget.onTableSort!(MapEntry(column, sortType));
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            column,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              fontFamily: 'OpenSans',
                            ),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                          index == selectedColumnIndex
                              ? const SizedBox(
                                  width: 10,
                                )
                              : Container(),
                          index == selectedColumnIndex
                              ? Icon(
                                  sortType
                                      ? PhosphorIcons.arrowUp
                                      : PhosphorIcons.arrowDown,
                                  size: 20,
                                  color: primaryColor,
                                )
                              : Container(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
            .toList(),
        const DataColumn(
          label: Text(
            'Details',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              fontFamily: 'OpenSans',
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
                  .map((value) => DataCell(CustomDataCell(
                        data: value,
                      )))
                  .toList(),
              DataCell(
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      widget.onRowClick(entity);
                    },
                    child: Icon(
                      PhosphorIcons.caretDoubleRight,
                      size: 20,
                      color: primaryColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return widget.entities.isNotEmpty
        ? DataTable(
            headingRowHeight: 54.5,
            dataRowHeight: 53.35,
            columns: _buildColumns(),
            rows: _buildRows(),
          )
        : Container(
            margin: const EdgeInsets.only(
              top: 200,
            ),
            child: Center(
              child: Text(
                widget.emptyMessage,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          );
  }
}
