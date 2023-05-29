import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/common_libraries.dart';

class FilteredProjectData extends Equatable {
  final List<EntityHeader> headers;
  final List<FilteredProject> data;
  final int totalRows;
  const FilteredProjectData({
    required this.headers,
    required this.data,
    required this.totalRows,
  });

  @override
  List<Object?> get props => [
        headers,
        data,
        totalRows,
      ];

  factory FilteredProjectData.fromMap(Map<String, dynamic> map) {
    return FilteredProjectData(
      headers: List<EntityHeader>.from(
        (map['headers']).map<EntityHeader>(
          (x) => EntityHeader.fromMap(x),
        ),
      ),
      totalRows: map['totalRows'] ?? 0,
      data: List<FilteredProject>.from(
        (map['data']).map<FilteredProject>(
          (x) => FilteredProject.fromMap(x),
        ),
      ),
    );
  }

  factory FilteredProjectData.fromJson(String source) =>
      FilteredProjectData.fromMap(json.decode(source) as Map<String, dynamic>);
}
