import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '/common_libraries.dart';

class QuestionsListBodyView extends StatelessWidget {
  const QuestionsListBodyView({super.key});

  static List<String> columnList = const [
    'Included?',
    'Question',
    'Score',
    'Status'
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuditQuestionsBloc, AuditQuestionsState>(
      builder: (context, state) {
        if (state.selectedAuditSectionId == null) {
          return Container();
        }
        return SfDataGridTheme(
          data: SfDataGridThemeData(
            headerColor: lightBlueAccent,
            rowHoverColor: lightTeal,
          ),
          child: SfDataGrid(
            source: AuditQuestionDataSource(
              auditQuestionList: state.auditQuestionList,
              columns: columnList,
              context: context,
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
        );
      },
    );
  }
}

class AuditQuestionDataSource extends DataGridSource {
  final List<AuditQuestion> auditQuestionList;
  final List<String> columns;
  final BuildContext context;

  AuditQuestionDataSource({
    required this.auditQuestionList,
    required this.columns,
    required this.context,
  }) {
    _entityData = auditQuestionList
        .map((auditQuestion) => DataGridRow(
              cells: [
                DataGridCell(columnName: columns[0], value: {
                  'id': auditQuestion.id,
                  'included': auditQuestion.questionIncluded,
                }),
                DataGridCell(
                    columnName: columns[1], value: auditQuestion.question),
                DataGridCell(
                    columnName: columns[2], value: auditQuestion.questionScore),
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

  void _changeIncluded(String id, bool isIncluded) {
    context.read<AuditQuestionsBloc>().add(AuditQuestionsIncludedChanged(
          questionId: id,
          isIncluded: !isIncluded,
        ));
  }

  Widget _buildItem(
      dynamic value, int index, List<DataGridCell<dynamic>> cells) {
    if (index == 0 && value is Map) {
      return Checkbox(
        value: value['included'] as bool,
        onChanged: (_) => cells.last.value == true && value['included'] == true
            ? CustomAlert(
                context: context,
                width: MediaQuery.of(context).size.width / 4,
                title: 'Confirm',
                description:
                    'This question has already been answered. Are you sure you would like to exclude from audit?',
                btnOkText: 'OK',
                btnCancelOnPress: () {},
                btnOkOnPress: () => _changeIncluded(value['id'], value['included']),
                dialogType: DialogType.question,
              ).show()
            : _changeIncluded(value['id'], value['included']),
      );
    }

    if (value is bool) {
      return CustomBadge(
        label: cells.first.value['included'] == false
            ? 'Excluded'
            : value
                ? 'Answered'
                : 'Unanswered',
        color: cells.first.value['included'] == false
            ? Colors.red
            : value
                ? successColor
                : primaryColor,
      );
    }
    return Text(value.toString());
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final cells = row.getCells();

    Color? getColor(dynamic value) {
      if (value is Map && value['included'] == false) {
        return const Color(0xfff7f2f2);
      }

      int index = effectiveRows.indexOf(row);
      if (index % 2 == 0) {
        return Colors.transparent;
      } else {
        return const Color(0xfff8f9fc);
      }
    }

    return DataGridRowAdapter(
      color: getColor(cells.first.value),
      cells: [
        for (int i = 0; i < cells.length; i++)
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _buildItem(cells[i].value, i, cells),
          )
      ],
    );
  }
}
