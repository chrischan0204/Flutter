import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/common_libraries.dart';

class FilteredCompanyData extends Equatable {
  final List<EntityHeader> headers;
  final List<FilteredCompany> data;
  const FilteredCompanyData({
    required this.headers,
    required this.data,
  });

  @override
  List<Object?> get props => [
        headers,
        data,
      ];

  factory FilteredCompanyData.fromMap(Map<String, dynamic> map) {
    return FilteredCompanyData(
      headers: List<EntityHeader>.from(
        (map['headers']).map<EntityHeader>(
          (x) => EntityHeader.fromMap(x),
        ),
      ),
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
