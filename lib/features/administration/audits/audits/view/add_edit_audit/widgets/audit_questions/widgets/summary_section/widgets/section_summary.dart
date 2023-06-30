import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '/common_libraries.dart';

class SectionSummaryView extends StatefulWidget {
  final String auditId;
  const SectionSummaryView({
    super.key,
    required this.auditId,
  });

  @override
  State<SectionSummaryView> createState() => _SectionSummaryViewState();
}

class _SectionSummaryViewState extends State<SectionSummaryView> {
  @override
  void initState() {
    context
        .read<AuditDetailBloc>()
        .add(AuditDetailAuditSectionListLoaded(auditId: widget.auditId));
    super.initState();
  }

  static List<String> columns = [
    'Section',
    'Total Q\'s',
    'Included Q\'s',
    'Max Score',
  ];
  List<GridColumn> _buildColumns() {
    return [
      ...columns
          .map(
            (column) => column == 'Section'
                ? GridColumn(
                    // width: ,
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
                  )
                : GridColumn(
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
              source: EntityDataSource(
                auditSectionAndQuestionList: state.auditSectionAndQuestionList,
                columns: columns,
              ),
              columnWidthMode: ColumnWidthMode.lastColumnFill,
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

class EntityDataSource extends DataGridSource {
  final List<AuditSectionAndQuestion> auditSectionAndQuestionList;
  final List<String> columns;

  EntityDataSource({
    required this.auditSectionAndQuestionList,
    required this.columns,
  }) {
    _entityData = auditSectionAndQuestionList
        .map((templateSnapshot) => DataGridRow(
              cells: [
                DataGridCell(
                    columnName: columns[0],
                    value: templateSnapshot.auditSectionName),
                DataGridCell(
                    columnName: columns[1], value: templateSnapshot.questions),
                DataGridCell(
                    columnName: columns[2],
                    value: templateSnapshot.questions -
                        templateSnapshot.excludedQuestions),
                DataGridCell(
                    columnName: columns[3], value: templateSnapshot.maxScore),
              ],
            ))
        .toList();
    if (auditSectionAndQuestionList.isNotEmpty) {
      _entityData.add(DataGridRow(
        cells: [
          DataGridCell(columnName: columns[0], value: 'Total:'),
          DataGridCell(
              columnName: columns[1],
              value: auditSectionAndQuestionList
                  .map((e) => e.questions)
                  .reduce((value, element) => value + element)),
          DataGridCell(
              columnName: columns[2],
              value: auditSectionAndQuestionList
                  .map((e) => (e.questions - e.excludedQuestions))
                  .reduce((value, element) => value + element)),
          DataGridCell(
              columnName: columns[3],
              value: auditSectionAndQuestionList
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
        return const Color(0xffD0EFFF);
      }

      int index = effectiveRows.indexOf(row);
      if (index % 2 == 0) {
        return Colors.transparent;
      } else {
        return const Color(0xfff8f9fc);
      }
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
