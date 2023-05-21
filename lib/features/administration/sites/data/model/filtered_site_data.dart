import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/common_libraries.dart';

class FilteredSiteData extends Equatable {
  final List<EntityHeader> headers;
  final List<FilteredSite> data;
  const FilteredSiteData({
    required this.headers,
    required this.data,
  });

  @override
  List<Object?> get props => [
        headers,
        data,
      ];

  factory FilteredSiteData.fromMap(Map<String, dynamic> map) {
    return FilteredSiteData(
      headers: List<EntityHeader>.from(
        (map['headers']).map<EntityHeader>(
          (x) => EntityHeader.fromMap(x),
        ),
      ),
      data: List<FilteredSite>.from(
        (map['data']).map<FilteredSite>(
          (x) => FilteredSite.fromMap(x),
        ),
      ),
    );
  }

  factory FilteredSiteData.fromJson(String source) =>
      FilteredSiteData.fromMap(json.decode(source) as Map<String, dynamic>);
}
