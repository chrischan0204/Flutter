import 'dart:convert';

import 'view_setting_column.dart';

class ViewSettingDisplayColumn extends ViewSettingColumn {
  final int order;
  const ViewSettingDisplayColumn({
    required super.id,
    required super.viewSettingId,
    required super.name,
    required super.title,
    required this.order,
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ...super.toMap(),
      'order': order,
    };
  }

  factory ViewSettingDisplayColumn.fromMap(Map<String, dynamic> map) {
    return ViewSettingDisplayColumn(
      id: map['id'] as String,
      viewSettingId: map['viewSettingId'] as String,
      name: map['name'] as String,
      title: map['title'] as String,
      order: map['order'] as int,
    );
  }
  @override
  String toJson() => json.encode(toMap());

  factory ViewSettingDisplayColumn.fromJson(String source) =>
      ViewSettingDisplayColumn.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
