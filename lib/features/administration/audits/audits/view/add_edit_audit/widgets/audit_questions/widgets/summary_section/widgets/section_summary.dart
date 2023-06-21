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

  List<String> columns = [
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
      child: BlocBuilder<TemplateDetailBloc, TemplateDetailState>(
        builder: (context, state) {
          return SfDataGrid(
            source: EntityDataSource(
              templateSnapshotList: state.templateSnapshotList,
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
  final List<TemplateSnapshot> templateSnapshotList;
  final List<String> columns;

  EntityDataSource({
    required this.templateSnapshotList,
    required this.columns,
  }) {
    _entityData = templateSnapshotList
        .map((templateSnapshot) => DataGridRow(
              cells: [
                DataGridCell(
                    columnName: columns[0], value: templateSnapshot.name),
                DataGridCell(
                    columnName: columns[1], value: templateSnapshot.questions),
                DataGridCell(
                    columnName: columns[2], value: templateSnapshot.maxScore),
                DataGridCell(
                    columnName: columns[2], value: templateSnapshot.maxScore),
                DataGridCell(
                    columnName: columns[2], value: templateSnapshot.maxScore),
              ],
            ))
        .toList();
    if (templateSnapshotList.isNotEmpty) {
      _entityData.add(DataGridRow(
        cells: [
          DataGridCell(columnName: columns[0], value: 'Total:'),
          DataGridCell(columnName: columns[1], value: ''),
          DataGridCell(columnName: columns[2], value: ''),
          DataGridCell(columnName: columns[3], value: ''),
          DataGridCell(columnName: columns[4], value: ''),
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
