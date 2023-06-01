import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/common_libraries.dart';

class FilteredCompanyData extends Equatable {
  final List<EntityHeader> headers;
  final List<FilteredCompany> data;
  final int totalRows;
  const FilteredCompanyData({
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

  factory FilteredCompanyData.fromMap(Map<String, dynamic> map) {
    return FilteredCompanyData(
      headers: List<EntityHeader>.from(
        (map['headers']).map<EntityHeader>(
          (x) => EntityHeader.fromMap(x),
        ),
      ),
      totalRows: map['totalRows'] ?? 0,
      data: List<FilteredCompany>.from(
        (map['data']).map<FilteredCompany>(
          (x) => FilteredCompany.fromMap(x),
        ),
      ),
    );
  }

  factory FilteredCompanyData.fromJson(String source) =>
      FilteredCompanyData.fromMap(json.decode(source) as Map<String, dynamic>);
}
