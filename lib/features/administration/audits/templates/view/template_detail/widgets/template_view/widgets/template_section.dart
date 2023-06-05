import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '/common_libraries.dart';

class TemplateSectionView extends StatefulWidget {
  const TemplateSectionView({super.key});

  @override
  State<TemplateSectionView> createState() => _TemplateSectionViewState();
}

class _TemplateSectionViewState extends State<TemplateSectionView> {
  @override
  void initState() {
    super.initState();
  }

  List<GridColumn> _buildColumns() {
    List<String> columns = ['Section', 'Questions', 'Max Score', 'Legend'];
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
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    fontFamily: 'OpenSans',
                    color: primaryColor,
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
    return SizedBox(
      height: 400,
      child: SfDataGrid(
        source: EntityDataSource(
            // entityData: ,
            ),
        columnWidthMode: ColumnWidthMode.fill,
        columnResizeMode: ColumnResizeMode.onResize,
        allowColumnsResizing: true,
        gridLinesVisibility: GridLinesVisibility.none,
        headerGridLinesVisibility: GridLinesVisibility.none,
        headerRowHeight: 52,
        rowHeight: 46,
        columns: _buildColumns(),
      ),
    );
  }
}

class EntityDataSource extends DataGridSource {
  EntityDataSource() {
    _entityData = [
      DataGridRow(
        cells: [
          DataGridCell(columnName: 'Section', value: 'Electric Inspection'),
          DataGridCell(columnName: 'Questions', value: 8),
          DataGridCell(columnName: 'Max Score', value: 32),
          DataGridCell(columnName: 'Legend', value: Color(0xffff6384)),
        ],
      ),
      DataGridRow(
        cells: [
          DataGridCell(columnName: 'Section', value: 'Signage Inspection'),
          DataGridCell(columnName: 'Questions', value: 12),
          DataGridCell(columnName: 'Max Score', value: 41),
          DataGridCell(columnName: 'Legend', value: Color(0xffFF9F40)),
        ],
      ),
      DataGridRow(
        cells: [
          DataGridCell(columnName: 'Section', value: 'Housekeeping interviews'),
          DataGridCell(columnName: 'Questions', value: 4),
          DataGridCell(columnName: 'Max Score', value: 20),
          DataGridCell(columnName: 'Legend', value: Color(0xffFFCD56)),
        ],
      ),
      DataGridRow(
        cells: [
          DataGridCell(
              columnName: 'Section', value: 'Cafe supplies inspection'),
          DataGridCell(columnName: 'Questions', value: 11),
          DataGridCell(columnName: 'Max Score', value: 28),
          DataGridCell(columnName: 'Legend', value: Color(0xff4bc0c0)),
        ],
      ),
      DataGridRow(
        cells: [
          DataGridCell(columnName: 'Section', value: 'Total:'),
          DataGridCell(columnName: 'Questions', value: 33),
          DataGridCell(columnName: 'Max Score', value: 112),
          DataGridCell(columnName: 'Legend', value: ''),
        ],
      ),
    ];
  }

  List<DataGridRow> _entityData = [];

  @override
  List<DataGridRow> get rows => _entityData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final cells = row.getCells();

    Color? getColor() {
      if (cells.first.value is String &&
          cells.first.value.toString().contains('Total')) {
        return const Color(0xffD0EFFF);
      }

      return null;
    }

    return DataGridRowAdapter(color: getColor(), cells: [
      for (int i = 0; i < cells.length; i++)
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TemplateSectionItemView(value: cells[i].value),
        )
    ]);
  }
}

class TemplateSectionItemView extends StatelessWidget {
  final dynamic value;
  const TemplateSectionItemView({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    if (value is int || value is String) {
      return Text(
        value.toString(),
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      );
    }
    return Container(
      width: 18,
      height: 18,
      color: value,
    );
  }
}
