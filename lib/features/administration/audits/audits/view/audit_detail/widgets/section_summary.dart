import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '/common_libraries.dart';

class SectionSummaryView extends StatelessWidget {
  const SectionSummaryView({super.key});
  static List<String> columns = [
    'Section',
    'Questions',
    'Max Score',
  ];

  List<GridColumn> _buildColumns() {
    return [
      ...columns
          .map(
            (column) => GridColumn(
              columnName: column,
              label: Container(
                alignment: Alignment.centerLeft,
                padding: insetx12,
                child: Text(
                  column,
                  style: textSemiBold14.copyWith(color: primaryColor),
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
    return Card(
      elevation: 3,
      child: BlocBuilder<AuditDetailBloc, AuditDetailState>(
        builder: (context, state) {
          return SfDataGridTheme(
            data: SfDataGridThemeData(
              headerColor: lightBlueAccent,
              rowHoverColor: lightTeal,
            ),
            child: SfDataGrid(
              source: AuditSectionDataSource(
                auditSectionList: state.auditSectionList,
                columns: columns,
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
        },
      ),
    );
  }
}

class AuditSectionDataSource extends DataGridSource {
  final List<AuditSection> auditSectionList;
  final List<String> columns;

  AuditSectionDataSource({
    required this.auditSectionList,
    required this.columns,
  }) {
    _entityData = auditSectionList
        .map((auditSection) => DataGridRow(
              cells: [
                DataGridCell(columnName: columns[0], value: auditSection.name),
                DataGridCell(
                    columnName: columns[1], value: auditSection.questionCount),
                DataGridCell(
                    columnName: columns[2], value: auditSection.maxScore),
              ],
            ))
        .toList();
    if (auditSectionList.isNotEmpty) {
      _entityData.add(DataGridRow(
        cells: [
          DataGridCell(columnName: columns[0], value: 'Total:'),
          DataGridCell(
              columnName: columns[1],
              value: auditSectionList
                  .map((e) => e.questionCount)
                  .reduce((value, element) => value + element)),
          DataGridCell(
              columnName: columns[2],
              value: auditSectionList
                  .map((e) => e.maxScore)
                  .reduce((value, element) => value + element)),
        ],
      ));
    }
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
        return lightBlueAccent;
      }
      int index = effectiveRows.indexOf(row);
      if (index % 2 == 0) {
        return Colors.transparent;
      } else {
        return const Color(0xfff8f9fc);
      }
    }

    Widget getItem(String value, int index) {
      if (index == 0) {
        return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            value,
            style: textSemiBold14,
          ),
        );
      } else {
        return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(value),
        );
      }
    }

    return DataGridRowAdapter(color: getColor(), cells: [
      for (int i = 0; i < cells.length; i++)
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: getItem(cells[i].value.toString(), i),
        )
    ]);
  }
}
