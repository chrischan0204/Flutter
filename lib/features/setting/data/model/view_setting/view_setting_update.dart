import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'view_setting_column_update.dart';

class ViewSettingUpdate extends Equatable {
  final String viewName;
  final List<ViewSettingColumnUpdate> displayColumns;
  final List<ViewSettingColumnUpdate> sortingColumns;
  const ViewSettingUpdate({
    required this.viewName,
    required this.displayColumns,
    required this.sortingColumns,
  });

  @override
  List<Object?> get props => [
        viewName,
        displayColumns,
        sortingColumns,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'viewName': viewName,
      'displayColumns': displayColumns.map((x) => x.toMap()).toList(),
      'sortingColumns': sortingColumns.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
}
