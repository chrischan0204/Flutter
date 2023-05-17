import 'dart:convert';

import 'package:equatable/equatable.dart';

class FilterSetting extends Equatable {
  final String id;
  final String viewName;
  final String columnName;
  final String columnType;
  final String columnTitle;
  final List<String> columnValues;
  final String columnValueURL;
  final String controlType;
  const FilterSetting({
    this.id = '00000000-0000-0000-0000-000000000000',
    this.viewName = '',
    this.columnName = '',
    this.columnType = '',
    this.columnTitle = '',
    this.columnValues = const [],
    this.columnValueURL = '',
    this.controlType = '',
  });
  @override
  List<Object?> get props => [
        id,
        viewName,
        columnName,
        columnType,
        columnTitle,
        columnValues,
        columnValueURL,
        controlType,
        isNew
      ];

  bool get isNew => id == '00000000-0000-0000-0000-000000000000';

  FilterSetting copyWith({
    String? id,
    String? viewName,
    String? columnName,
    String? columnType,
    String? columnTitle,
    List<String>? columnValues,
    String? columnValueURL,
    String? controlType,
  }) {
    return FilterSetting(
      id: id ?? this.id,
      viewName: viewName ?? this.viewName,
      columnName: columnName ?? this.columnName,
      columnType: columnType ?? this.columnType,
      columnTitle: columnTitle ?? this.columnTitle,
      columnValues: columnValues ?? this.columnValues,
      columnValueURL: columnValueURL ?? this.columnValueURL,
      controlType: controlType ?? this.controlType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'viewName': viewName,
      'columnName': columnName,
      'columnType': columnType,
      'columnTitle': columnTitle,
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
      columnTitle: map['columnTitle'] as String,
      columnValues: List.from(map['columnValues'])
          .map((columnValue) => columnValue as String)
          .toList(),
      columnValueURL: map['columnValueURL'] as String,
      controlType: map['controlType'] as String,
    );
  }

  factory FilterSetting.fromJson(String source) =>
      FilterSetting.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());
}
