

import '/common_libraries.dart';

class FilteredSiteData extends Equatable {
  final List<EntityHeader> headers;
  final List<FilteredSite> data;
  final int totalRows;
  const FilteredSiteData({
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

  factory FilteredSiteData.fromMap(Map<String, dynamic> map) {
    return FilteredSiteData(
      headers: List<EntityHeader>.from(
        (map['headers']).map<EntityHeader>(
          (x) => EntityHeader.fromMap(x),
        ),
      ),
      totalRows: map['totalRows'] ?? 0,
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
