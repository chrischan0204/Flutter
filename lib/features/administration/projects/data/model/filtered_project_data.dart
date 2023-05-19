import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/common_libraries.dart';

class FilteredProjectData extends Equatable {
  final List<EntityHeader> headers;
  final List<FilteredProject> data;
  const FilteredProjectData({
    required this.headers,
    required this.data,
  });

  @override
  List<Object?> get props => [
        headers,
        data,
      ];

  factory FilteredProjectData.fromMap(Map<String, dynamic> map) {
    return FilteredProjectData(
      headers: List<EntityHeader>.from(
        (map['headers']).map<EntityHeader>(
          (x) => EntityHeader.fromMap(x),
        ),
      ),
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
