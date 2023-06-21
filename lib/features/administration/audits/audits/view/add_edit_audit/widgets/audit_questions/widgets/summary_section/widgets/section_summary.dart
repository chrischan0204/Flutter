import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '/common_libraries.dart';

class SectionSummaryView extends StatelessWidget {
  const SectionSummaryView({super.key});
  static List<String> columns = [
    'Section',
    'Total \'s',
    'Included Q\'s',
    'Max Score',
    'Included Score'
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
    return SizedBox(
      height: 400,
      child: BlocBuilder<AuditQuestionsBloc, AuditQuestionsState>(
        builder: (context, state) {
          return SfDataGrid(
            source: EntityDataSource(
              auditQuestionSnapshotList: state.auditQuestionSnapshotList,
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
          );
        },
      ),
    );
  }
}

class EntityDataSource extends DataGridSource {
  final List<AuditQuestionSnapshot> auditQuestionSnapshotList;
  final List<String> columns;

  EntityDataSource({
    required this.auditQuestionSnapshotList,
    required this.columns,
  }) {
    _entityData = auditQuestionSnapshotList
        .map((templateSnapshot) => DataGridRow(
              cells: [
                DataGridCell(
                    columnName: columns[0], value: templateSnapshot.section),
                DataGridCell(
                    columnName: columns[1],
                    value: templateSnapshot.totalQuestionCount),
                DataGridCell(
                    columnName: columns[2],
                    value: templateSnapshot.includedQuestionCount),
                DataGridCell(
                    columnName: columns[3], value: templateSnapshot.maxScore),
                DataGridCell(
                    columnName: columns[4],
                    value: templateSnapshot.includedScore),
              ],
            ))
        .toList();
    if (auditQuestionSnapshotList.isNotEmpty) {
      _entityData.add(DataGridRow(
        cells: [
          DataGridCell(columnName: columns[0], value: 'Total:'),
          DataGridCell(
              columnName: columns[1],
              value: auditQuestionSnapshotList
                  .map((e) => e.totalQuestionCount)
                  .reduce((value, element) => value + element)),
          DataGridCell(
              columnName: columns[2],
              value: auditQuestionSnapshotList
                  .map((e) => e.includedQuestionCount)
                  .reduce((value, element) => value + element)),
          DataGridCell(
              columnName: columns[3],
              value: auditQuestionSnapshotList
                  .map((e) => e.maxScore)
                  .reduce((value, element) => value + element)),
          DataGridCell(
              columnName: columns[4],
              value: auditQuestionSnapshotList
                  .map((e) => e.includedScore)
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
        return const Color(0xffD0EFFF);
      }

      return null;
    }

    return DataGridRowAdapter(color: getColor(), cells: [
      for (int i = 0; i < cells.length; i++)
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(cells[i].value.toString()),
        )
    ]);
  }
}
