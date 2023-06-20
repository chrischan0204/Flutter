import '/common_libraries.dart';

class FilteredAuditData extends Equatable {
  final List<EntityHeader> headers;
  final List<FilteredAudit> data;
  final int totalRows;
  const FilteredAuditData({
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

  factory FilteredAuditData.fromMap(Map<String, dynamic> map) {
    return FilteredAuditData(
      headers: List<EntityHeader>.from(
        (map['headers']).map<EntityHeader>(
          (x) => EntityHeader.fromMap(x),
        ),
      ),
      totalRows: map['totalRows'],
      data: List<FilteredAudit>.from(
        (map['data']).map<FilteredAudit>(
          (x) => FilteredAudit.fromMap(x),
        ),
      ),
    );
  }

  factory FilteredAuditData.fromJson(String source) =>
      FilteredAuditData.fromMap(json.decode(source) as Map<String, dynamic>);
}
