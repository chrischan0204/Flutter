import '/common_libraries.dart';

class FilteredObservation extends FilteredEntity {
  final String observation;
  final String siteId;
  final String location;
  final String response;
  final List<dynamic> images;

  const FilteredObservation({
    super.id,
    required this.observation,
    required this.siteId,
    required this.location,
    required this.response,
    this.images = const [],
    super.createdOn,
    super.deleted,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        siteId,
        observation,
        location,
        response,
        images,
      ];

  Observation toObservation() {
    return Observation(
      observation: observation,
      siteId: siteId,
      location: location,
      response: response,
    );
  }

  FilteredObservation copyWith({
    String? id,
    String? name,
    String? siteId,
    String? observation,
    String? response,
    String? location,
    List<dynamic>? images,
    bool? active,
    String? createdOn,
    String? createdByUserName,
    bool? deleted,
    List<String>? columns,
  }) {
    return FilteredObservation(
      id: id ?? this.id,
      siteId: siteId ?? this.siteId,
      observation: observation ?? this.observation,
      response: response ?? this.response,
      location: location ?? this.location,
      createdOn: createdOn ?? this.createdOn,
      deleted: deleted ?? this.deleted,
    );
  }

  factory FilteredObservation.fromMap(Map<String, dynamic> map) {
    return FilteredObservation(
      observation: map['observation'] as String,
      siteId: map['siteId'] as String,
      location: map['location'] as String,
      response: map['response'] as String,
      images: List<dynamic>.from((map['images'] as List<dynamic>)),
    );
  }

  factory FilteredObservation.fromJson(String source) =>
      FilteredObservation.fromMap(json.decode(source) as Map<String, dynamic>);
}
