import 'dart:convert';

import 'package:equatable/equatable.dart';

class FilterSetting extends Equatable {
  final String id;
  final String viewName;
  final String columnName;
  final String columnType;
  final List<String> columnValues;
  final String columnValueURL;
  final String controlType;
  const FilterSetting({
    required this.id,
    required this.viewName,
    required this.columnName,
    required this.columnType,
    required this.columnValues,
    required this.columnValueURL,
    required this.controlType,
  });
  @override
  List<Object?> get props => [
        id,
        viewName,
        columnName,
        columnType,
        columnValues,
        columnValueURL,
        controlType,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'viewName': viewName,
      'columnName': columnName,
      'columnType': columnType,
      'columnValues': columnValues,
      'columnValueURL': columnValueURL,
      'controlType': controlType,
    };
  }

  factory FilterSetting.fromMap(Map<String, dynamic> map) {
    return FilterSetting(
      id: map['id'] as String,
      viewName: map['viewName'] as String,
      columnName: map['columnName'] as String,
      columnType: map['columnType'] as String,
      columnValues: List.from(map['columnValues'])
          .map((columnValue) => columnValue as String)
          .toList(),
      columnValueURL: map['columnValueURL'] as String,
      controlType: map['controlType'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FilterSetting.fromJson(String source) =>
      FilterSetting.fromMap(json.decode(source) as Map<String, dynamic>);
}
