import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '/constants/constants.dart';
import '../../custom_data_cell.dart';
import '/data/model/entity.dart';

class DataTableView extends StatefulWidget {
  final List<Entity> entities;
  final List<String> columns;
  final ValueChanged<Entity> onRowClick;
  final String emptyMessage;
  final ValueChanged<MapEntry<String, bool>>? onTableSorted;
  const DataTableView({
    super.key,
    this.entities = const [],
    this.columns = const [],
    required this.onRowClick,
    this.emptyMessage = '',
    this.onTableSorted,
  });

  @override
  State<DataTableView> createState() => _DataTableViewState();
}

class _DataTableViewState extends State<DataTableView> {
  int? selectedColumnIndex;
  bool sortType = true;

  List<GridColumn> _buildColumns() {
    List<String> columns = widget.entities[0].columns.isNotEmpty
        ? widget.entities[0].columns
        : widget.entities[0].tableItemsToMap().keys.toList();
    return [
      ...columns
          .map(
            (column) => GridColumn(
              columnName: column,
              label: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  column,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    fontFamily: 'OpenSans',
                  ),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          )
          .toList(),
      GridColumn(
        columnName: 'Details',
        label: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: const Text(
            'Details',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return widget.entities.isNotEmpty
        ? SfDataGridTheme(
            data: SfDataGridThemeData(
              headerColor: lightTeal,
              rowHoverColor: const Color(0xffe7f9fc),
            ),
            child: SfDataGrid(
              source: EntityDataSource(
                entityData: widget.entities,
                onRowClick: widget.onRowClick,
              ),
              columnWidthMode: ColumnWidthMode.fill,
              gridLinesVisibility: GridLinesVisibility.none,
              headerGridLinesVisibility: GridLinesVisibility.none,
              headerRowHeight: 52,
              rowHeight: 46,
              columns: _buildColumns(),
            ),
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

class EntityDataSource extends DataGridSource {
  final ValueChanged<Entity> onRowClick;
  EntityDataSource({
    required List<Entity> entityData,
    required this.onRowClick,
  }) {
    List<String> columns = entityData[0].columns.isNotEmpty
        ? entityData[0].columns
        : entityData[0].tableItemsToMap().keys.toList();
    _entityData = List.generate(
      entityData.length,
      (index) => DataGridRow(
        // color: MaterialStateProperty.resolveWith<Color?>(
        //     (Set<MaterialState> states) {
        //   if ((entityData[index]
        //               .tableItemsToMap()
        //               .containsKey('Active') &&
        //           !entityData[index].tableItemsToMap()['Active']) ||
        //       entityData[index].deleted) {
        //     return const Color(0xffe6e7e8);
        //   }
        //   if (index % 2 == 0) {
        //     return Color(0xfff8f9fc);
        //     return primaryColor.withOpacity(0.05);
        //   }
        //   return null; // Use the default value.
        // }),
        cells: [
          ...(columns.isEmpty
              ? entityData[index]
                  .tableItemsToMap()
                  .entries
                  .map(
                    (value) => DataGridCell(
                      columnName: value.key,
                      value: value.value,
                    ),
                  )
                  .toList()
              : columns
                  .map(
                    (column) => DataGridCell(
                      columnName: column,
                      value: entityData[index].tableItemsToMap()[column],
                    ),
                  )
                  .toList()),
          DataGridCell(
            columnName: 'Details',
            value: {
              'value': MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => onRowClick(entityData[index]),
                  child: Icon(
                    PhosphorIcons.caretDoubleRight,
                    size: 20,
                    color: primaryColor,
                  ),
                ),
              ),
              'deleted': entityData[index].deleted,
            },
          ),
        ],
      ),
    );
  }

  List<DataGridRow> _entityData = [];

  @override
  List<DataGridRow> get rows => _entityData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    Color getBackgroundColor() {
      if (row.getCells().last.value['deleted']) {
        return const Color(0xffe6e7e8);
      }
      int index = effectiveRows.indexOf(row);
      if (index % 2 == 0) {
        return Colors.white;
      } else {
        return const Color(0xfff8f9fc);
      }
    }

    return DataGridRowAdapter(
        color: getBackgroundColor(),
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: e.value is Widget
                ? e.value
                : e.value is! Map
                    ? CustomDataCell(data: e.value)
                    : e.value['value'],
          );
        }).toList());
  }
}
