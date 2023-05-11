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

  factory FilterSetting.fromJson(String source) =>
      FilterSetting.fromMap(json.decode(source) as Map<String, dynamic>);

  FilterSetting copyWith({
    String? id,
    String? viewName,
    String? columnName,
    String? columnType,
    List<String>? columnValues,
    String? columnValueURL,
    String? controlType,
  }) {
    return FilterSetting(
      id: id ?? this.id,
      viewName: viewName ?? this.viewName,
      columnName: columnName ?? this.columnName,
      columnType: columnType ?? this.columnType,
      columnValues: columnValues ?? this.columnValues,
      columnValueURL: columnValueURL ?? this.columnValueURL,
      controlType: controlType ?? this.controlType,
    );
  }
}
