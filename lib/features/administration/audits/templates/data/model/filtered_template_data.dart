import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/common_libraries.dart';

class FilteredTemplateData extends Equatable {
  final List<EntityHeader> headers;
  final List<FilteredTemplate> data;
  final int totalRows;
  const FilteredTemplateData({
    required this.headers,
    required this.data,
    required this.totalRows,
  });

  @override
  List<Object?> get props => [
        headers,
        data,
      ];

  factory FilteredTemplateData.fromMap(Map<String, dynamic> map) {
    return FilteredTemplateData(
      headers: List<EntityHeader>.from(
        (map['headers']).map<EntityHeader>(
          (x) => EntityHeader.fromMap(x),
        ),
      ),
      totalRows: map['totalRows'],
      data: List<FilteredTemplate>.from(
        (map['data']).map<FilteredTemplate>(
          (x) => FilteredTemplate.fromMap(x),
        ),
      ),
    );
  }

  factory FilteredTemplateData.fromJson(String source) =>
      FilteredTemplateData.fromMap(json.decode(source) as Map<String, dynamic>);
}
