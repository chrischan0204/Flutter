import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '/constants/constants.dart';

class TableView extends StatelessWidget {
  final double height;
  final List<DataColumn> columns;
  final List<DataRow> rows;
  const TableView({
    super.key,
    required this.height,
    this.columns = const [],
    this.rows = const [],
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        }),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: ScrollController(),
          child: DataTable(
            headingTextStyle: tableHeadingTextStyle,
            dataTextStyle: tableDataTextStyle,
            columns: columns,
            rows: rows,
          ),
        ),
      ),
    );
  }
}
