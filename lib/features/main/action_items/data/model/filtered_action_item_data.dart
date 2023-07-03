import '/common_libraries.dart';

class FilteredActionItemData extends Equatable {
  final List<EntityHeader> headers;
  final List<FilteredActionItem> data;
  final int totalRows;
  const FilteredActionItemData({
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

  factory FilteredActionItemData.fromMap(Map<String, dynamic> map) {
    return FilteredActionItemData(
      headers: List<EntityHeader>.from(
        (map['headers']).map<EntityHeader>(
          (x) => EntityHeader.fromMap(x),
        ),
      ),
      totalRows: map['totalRows'],
      data: List<FilteredActionItem>.from(
        (map['data']).map<FilteredActionItem>(
          (x) => FilteredActionItem.fromMap(x),
        ),
      ),
    );
  }

  factory FilteredActionItemData.fromJson(String source) =>
      FilteredActionItemData.fromMap(json.decode(source) as Map<String, dynamic>);
}
