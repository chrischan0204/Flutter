import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '/common_libraries.dart';

class QuestionsListView extends StatelessWidget {
  const QuestionsListView({super.key});

  static List<String> columnList = const [
    'Question',
    'Scale',
    'Score',
    'Status'
  ];

  static List<double> columnWidth = [double.nan, 200, 100, 120];
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
                  'Questions for ${state.selectedAuditSection!.auditSectionName}',
                  style: textSemiBold14,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: insetx10y20,
                  child: SfDataGridTheme(
                    data: SfDataGridThemeData(
                      headerColor: lightBlueAccent,
                      rowHoverColor: lightTeal,
                    ),
                    child: SfDataGrid(
                      source: AuditQuestionDataSource(
                        auditQuestionList:
                            state.selectedAuditSection!.auditQuestions,
                        columns: columnList,
                      ),
                      columnWidthMode: ColumnWidthMode.fill,
                      gridLinesVisibility: GridLinesVisibility.none,
                      headerGridLinesVisibility: GridLinesVisibility.none,
                      headerRowHeight: 52,
                      rowHeight: 46,
                      columns: [
                        for (int i = 0; i < columnList.length; i++)
                          GridColumn(
                              width: columnWidth[i],
                              columnName: columnList[i],
                              label: Padding(
                                padding: inset10,
                                child: Text(
                                  columnList[i],
                                  style: textSemiBold14,
                                ),
                              ))
                      ],
                    ),
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
                DataGridCell(
                    columnName: columns[0], value: auditQuestion.question),
                DataGridCell(
                    columnName: columns[1],
                    value: auditQuestion.responseScaleName),
                DataGridCell(
                    columnName: columns[2],
                    value:
                        '${auditQuestion.questionScore} + ${auditQuestion.maxScore - auditQuestion.questionScore}'),
                DataGridCell(
                    columnName: columns[3],
                    value: !(auditQuestion.questionStatus == 0)),
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
