import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '/common_libraries.dart';

class TableView extends StatefulWidget {
  final double? height;
  final List<String> columns;
  final List<List<Widget>> rows;
  const TableView({
    super.key,
    this.height,
    this.columns = const [],
    this.rows = const [],
  });

  @override
  State<TableView> createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  late Map<String, double> columnWidths = {};

  List<GridColumn> _buildColumns() => widget.columns
      .map(
        (column) => GridColumn(
          columnName: column,
          minimumWidth: column.contains('Assigned')
              ? 80.0
              : column.contains('Role')
                  ? 100
                  : 60.0,
          width: columnWidths[column] ?? double.nan,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Tooltip(
              message: column,
              preferBelow: false,
              child: Text(
                column,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  fontFamily: 'OpenSans',
                ),
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      )
      .toList();

  @override
  void initState() {
    setState(() {
      for (final column in widget.columns) {
        columnWidths.addAll({column: double.nan});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: SfDataGridTheme(
        data: SfDataGridThemeData(
          headerColor: lightTeal,
          rowHoverColor: const Color(0xffe7f9fc),
        ),
        child: SfDataGrid(
          source: DataSource(columns: widget.columns, data: widget.rows),
          columnWidthMode: ColumnWidthMode.fill,
          columnResizeMode: ColumnResizeMode.onResize,
          onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
            setState(() {
              columnWidths[details.column.columnName] = details.width;
            });
            return true;
          },
          allowColumnsResizing: true,
          gridLinesVisibility: GridLinesVisibility.none,
          headerGridLinesVisibility: GridLinesVisibility.none,
          headerRowHeight: 52,
          rowHeight: 46,
          columns: _buildColumns(),
        ),
      ),
    );
  }
}

class DataSource extends DataGridSource {
  DataSource({
    required List<List<Widget>> data,
    required List<String> columns,
  }) {
    _entityData = List.generate(
      data.length,
      (index) => DataGridRow(
        cells: [
          for (int i = 0; i < columns.length; i++)
            DataGridCell(
              columnName: columns[i],
              value: data[index][i],
            )
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
      int index = effectiveRows.indexOf(row);
      if (index % 2 == 0) {
        return Colors.transparent;
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
              child: e.value,
            ),
          );
        }).toList());
  }
}
