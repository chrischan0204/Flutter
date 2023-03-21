import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '/data/bloc/bloc.dart';

import '/data/model/entity.dart';

class DataTableView extends StatefulWidget {
  final ValueChanged<Entity> onRowClick;
  const DataTableView({
    super.key,
    this.entities = const [],
    required this.onRowClick,
  });
  final List<Entity> entities;

  @override
  State<DataTableView> createState() => _DataTableViewState();
}

class _DataTableViewState extends State<DataTableView> {
  List<DataColumn> _buildColumns() {
    if (widget.entities.isNotEmpty) {
      return [
        ...widget.entities[0]
            .tableItemsToMap()
            .keys
            .map(
              (key) => DataColumn(
                label: Text(
                  key,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    fontFamily: 'OpenSans',
                  ),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
            .toList(),
        const DataColumn(
          label: Text(
            'Action',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              fontFamily: 'OpenSans',
            ),
          ),
        )
      ];
    }
    return [];
  }

  List<DataRow> _buildRows() {
    return widget.entities
        .map(
          (entity) => DataRow(
            color: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (entity.tableItemsToMap().containsKey('Active') &&
                  !entity.tableItemsToMap()['Active']) {
                return const Color(0xffe6e7e8);
              }
              return null; // Use the default value.
            }),
            cells: [
              ...entity
                  .tableItemsToMap()
                  .values
                  .map((value) => DataCell(_buildCell(value)))
                  .toList(),
              DataCell(
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      context.read<MastersTemplateBloc>().add(
                            const MastersTemplateCrudTypeChanged(
                              crudType: CrudType.editOrDelete,
                            ),
                          );
                      widget.onRowClick(entity);
                    },
                    child: const Icon(
                      PhosphorIcons.caretDoubleRight,
                      size: 20,
                      color: Color(0xff0c83ff),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
        .toList();
  }

  Widget _buildCell(dynamic data) {
    String content = data.toString();
    if (data is bool) {
      content = data ? 'Yes' : 'No';
    } else if (data is Color) {
      return Container(
        width: double.infinity,
        height: 25,
        decoration: BoxDecoration(color: data),
      );
    } else if (data is List) {
      content = data.join(', ');
    }
    return Text(
      content,
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xff1f2937),
        fontWeight: FontWeight.w400,
        fontFamily: 'OpenSans',
      ),
      maxLines: 2,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.entities.isNotEmpty
        ? DataTable(
            headingRowHeight: 46,
            dataRowHeight: 46,
            columns: _buildColumns(),
            rows: _buildRows(),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
