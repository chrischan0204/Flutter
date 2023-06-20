import '/common_libraries.dart';

class FilteredObservationData extends Equatable {
  final List<EntityHeader> headers;
  final List<FilteredObservation> data;
  final int totalRows;
  const FilteredObservationData({
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

  factory FilteredObservationData.fromMap(Map<String, dynamic> map) {
    return FilteredObservationData(
      headers: List<EntityHeader>.from(
        (map['headers']).map<EntityHeader>(
          (x) => EntityHeader.fromMap(x),
        ),
      ),
      totalRows: map['totalRows'],
      data: List<FilteredObservation>.from(
        (map['data']).map<FilteredObservation>(
          (x) => FilteredObservation.fromMap(x),
        ),
      ),
    );
  }

  factory FilteredObservationData.fromJson(String source) =>
      FilteredObservationData.fromMap(json.decode(source) as Map<String, dynamic>);
}
