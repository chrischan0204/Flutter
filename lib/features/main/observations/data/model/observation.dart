import '/common_libraries.dart';

class Observation extends Entity {
  final String observation;
  final String siteId;
  final String location;
  final String response;
  final List<dynamic> images;

  const Observation({
    super.id,
    super.name,
    required this.observation,
    required this.siteId,
    required this.location,
    required this.response,
    this.images = const [],
    super.active,
    super.createdByUserName,
    super.createdOn,
    super.columns,
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

  @override
  Map<String, dynamic> tableItemsToMap() {
    return {
      'Observation': name,
    };
  }

  @override
  Map<String, dynamic> sideDetailItemsToMap() {
    return {
      'Observation': name,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'observation': observation,
      'siteId': siteId,
      'location': location,
      'response': response,
      'images': images,
    };
  }

  @override
  Map<String, dynamic> detailItemsToMap() {
    return {
      'Template Description': name,
    };
  }

  Observation copyWith({
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
    return Observation(
      id: id ?? this.id,
      name: name ?? this.name,
      siteId: siteId ?? this.siteId,
      observation: observation ?? this.observation,
      response: response ?? this.response,
      location: location ?? this.location,
      active: active ?? this.active,
      createdOn: createdOn ?? this.createdOn,
      createdByUserName: createdByUserName ?? this.createdByUserName,
      deleted: deleted ?? this.deleted,
      columns: columns ?? this.columns,
    );
  }

  factory Observation.fromMap(Map<String, dynamic> map) {
    return Observation(
      observation: map['observation'] as String,
      siteId: map['siteId'] as String,
      location: map['location'] as String,
      response: map['response'] as String,
      images: List<dynamic>.from((map['images'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Observation.fromJson(String source) =>
      Observation.fromMap(json.decode(source) as Map<String, dynamic>);
}
