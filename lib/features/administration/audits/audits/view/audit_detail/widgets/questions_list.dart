import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '/common_libraries.dart';

class QuestionsListView extends StatelessWidget {
  const QuestionsListView({super.key});

  static List<String> columnList = const [
    'Q.No',
    'Score',
    'Question',
    'Scale',
    'Status'
  ];
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: BlocBuilder<AuditDetailBloc, AuditDetailState>(
        builder: (context, state) {
          if (state.selectedAuditSection == null) {
            return Container();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomBottomBorderContainer(
                padding: inset20,
                child: Text(
                  'Questions for ${state.selectedAuditSection!.name}',
                  style: textSemiBold14,
                ),
              ),
              Padding(
                padding: insetx10y20,
                child: SfDataGridTheme(
                  data: SfDataGridThemeData(
                    headerColor: lightBlueAccent,
                    rowHoverColor: lightTeal,
                  ),
                  child: SfDataGrid(
                    source: AuditQuestionDataSource(
                      auditQuestionList:
                          state.selectedAuditSection!.auditQuestionList,
                      columns: columnList,
                    ),
                    columnWidthMode: ColumnWidthMode.lastColumnFill,
                    columnResizeMode: ColumnResizeMode.onResize,
                    allowColumnsResizing: true,
                    gridLinesVisibility: GridLinesVisibility.none,
                    headerGridLinesVisibility: GridLinesVisibility.none,
                    headerRowHeight: 52,
                    rowHeight: 46,
                    columns: columnList
                        .map((e) => GridColumn(
                            columnName: e,
                            label: Padding(
                              padding: inset10,
                              child: Text(
                                e,
                                style: textSemiBold14,
                              ),
                            )))
                        .toList(),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class AuditQuestionDataSource extends DataGridSource {
  final List<AuditQuestion> auditQuestionList;
  final List<String> columns;

  AuditQuestionDataSource({
    required this.auditQuestionList,
    required this.columns,
  }) {
    _entityData = auditQuestionList
        .map((auditQuestion) => DataGridRow(
              cells: [
                DataGridCell(columnName: columns[0], value: auditQuestion.no),
                DataGridCell(
                    columnName: columns[1], value: auditQuestion.score),
                DataGridCell(
                    columnName: columns[2], value: auditQuestion.question),
                DataGridCell(
                    columnName: columns[3], value: auditQuestion.scale),
                DataGridCell(
                    columnName: columns[4], value: auditQuestion.answered),
              ],
            ))
        .toList();
  }

  List<DataGridRow> _entityData = [];

  @override
  List<DataGridRow> get rows => _entityData;
  Widget _buildItem(dynamic value) {
    if (value is bool) {
      return CustomBadge(
        label: value ? 'Answered' : 'Unanswered',
        color: value ? primaryColor : warnColor,
      );
    }
    return Text(value.toString());
  }

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

    return DataGridRowAdapter(
      color: getColor(),
      cells: [
        for (int i = 0; i < cells.length; i++)
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _buildItem(cells[i].value),
          )
      ],
    );
  }
}
