import '/common_libraries.dart';

class FilteredUserData extends Equatable {
  final List<EntityHeader> headers;
  final List<FilteredUser> data;
  final int totalRows;
  const FilteredUserData({
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

  factory FilteredUserData.fromMap(Map<String, dynamic> map) {
    return FilteredUserData(
      headers: List<EntityHeader>.from(
        (map['headers']).map<EntityHeader>(
          (x) => EntityHeader.fromMap(x),
        ),
      ),
      totalRows: map['totalRows'],
      data: List<FilteredUser>.from(
        (map['data']).map<FilteredUser>(
          (x) => FilteredUser.fromMap(x),
        ),
      ),
    );
  }

  factory FilteredUserData.fromJson(String source) =>
      FilteredUserData.fromMap(json.decode(source) as Map<String, dynamic>);
}
