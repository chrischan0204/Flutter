import 'dart:convert';

import 'view_setting_display_column.dart';

class ViewSettingSortingColumn extends ViewSettingDisplayColumn {
  final String sortDirection;
  const ViewSettingSortingColumn({
    required super.id,
    required super.viewSettingId,
    required super.name,
    required super.title,
    required super.order,
    required this.sortDirection,
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ...super.toMap(),
      'sortDirection': sortDirection,
    };
  }

  factory ViewSettingSortingColumn.fromMap(Map<String, dynamic> map) {
    return ViewSettingSortingColumn(
      id: map['id'] as String,
      viewSettingId: map['viewSettingId'] as String,
      name: map['name'] as String,
      title: map['title'] as String,
      order: map['order'] as int,
      sortDirection: map['sortDirection'] as String,
    );
  }

  factory ViewSettingSortingColumn.fromJson(String source) =>
      ViewSettingSortingColumn.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
