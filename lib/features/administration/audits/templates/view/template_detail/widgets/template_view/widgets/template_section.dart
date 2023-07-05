import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:uuid/uuid.dart';

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
            footerFrozenRowsCount: 1,
            source: EntityDataSource(
              templateSnapshotList: state.templateSnapshotList,
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

  EntityDataSource({required this.templateSnapshotList}) {
    _entityData = templateSnapshotList
        .map((templateSnapshot) => DataGridRow(
              cells: [
                DataGridCell(
                    columnName: 'Section', value: templateSnapshot.name),
                DataGridCell(
                    columnName: 'Questions', value: templateSnapshot.questions),
                DataGridCell(
                    columnName: 'Max Score', value: templateSnapshot.maxScore),
                DataGridCell(
                    columnName: 'Legend',
                    value: Color.fromARGB(
                        255,
                        Uuid.parse(templateSnapshot.id)[1],
                        Uuid.parse(templateSnapshot.id)[2],
                        Uuid.parse(templateSnapshot.id)[3])),
              ],
            ))
        .toList();
    if (templateSnapshotList.isNotEmpty) {
      _entityData.add(DataGridRow(
        cells: [
          const DataGridCell(columnName: 'Section', value: 'Total:'),
          DataGridCell(
              columnName: 'Questions',
              value: templateSnapshotList.isNotEmpty
                  ? templateSnapshotList
                      .map((e) => e.questions)
                      .reduce((value, element) => value + element)
                  : ''),
          DataGridCell(
              columnName: 'Max Score',
              value: templateSnapshotList.isNotEmpty
                  ? templateSnapshotList
                      .map((e) => e.maxScore)
                      .reduce((value, element) => value + element)
                  : ''),
          const DataGridCell(columnName: 'Legend', value: ''),
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
    if (value is int || value is String || value is double) {
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
