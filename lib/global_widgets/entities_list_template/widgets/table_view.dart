import 'package:flutter/material.dart';
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
              onCellTap: (details) {
                int rowIndex = details.rowColumnIndex.rowIndex;
                if (rowIndex > 0) {
                  widget.onRowClick(widget.entities[rowIndex - 1]);
                }
              },
              columnWidthMode: ColumnWidthMode.fill,
              columnResizeMode: ColumnResizeMode.onResize,
              allowColumnsResizing: true,
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
        cells: [
          ...(columns.isEmpty
              ? entityData[index]
                  .tableItemsToMap()
                  .entries
                  .map(
                    (value) => DataGridCell(
                      columnName: value.key,
                      value: {
                        'value': CustomDataCell(
                          data: value.value,
                          onRowClick: () => onRowClick(entityData[index]),
                        ),
                        'deleted': entityData[index].deleted,
                      },
                    ),
                  )
                  .toList()
              : columns
                  .map(
                    (column) => DataGridCell(
                      columnName: column,
                      value: {
                        'value': CustomDataCell(
                          data: entityData[index].tableItemsToMap()[column],
                          onRowClick: () => onRowClick(entityData[index]),
                        ),
                        'deleted': entityData[index].deleted,
                      },
                    ),
                  )
                  .toList()),
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
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: e.value['value'],
            ),
          );
        }).toList());
  }
}
