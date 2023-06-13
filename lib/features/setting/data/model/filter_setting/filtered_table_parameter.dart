import '/common_libraries.dart';

class FilteredTableParameter extends Equatable {
  final String filterId;
  final bool includeDeleted;
  final int pageNum;
  final int pageSize;
  final UserFilter? filterOption;
  const FilteredTableParameter({
    required this.filterId,
    required this.includeDeleted,
    required this.pageNum,
    required this.pageSize,
    this.filterOption,
  });
  @override
  List<Object?> get props => [
        filterId,
        includeDeleted,
        pageNum,
        pageSize,
        filterOption,
      ];

  FilteredTableParameter copyWith({
    String? filterId,
    bool? includeDeleted,
    int? pageNum,
    int? pageSize,
    UserFilter? filterOption,
  }) {
    return FilteredTableParameter(
      filterId: filterId ?? this.filterId,
      includeDeleted: includeDeleted ?? this.includeDeleted,
      pageNum: pageNum ?? this.pageNum,
      pageSize: pageSize ?? this.pageSize,
      filterOption: filterOption ?? this.filterOption,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'filterId': filterId,
      'includeDeleted': includeDeleted,
      'pageNum': pageNum,
      'pageSize': pageSize,
      'filterOption': filterOption?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());
}
