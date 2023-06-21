import '/common_libraries.dart';

class ObservationCreate extends Equatable {
  final String name;
  final String siteId;
  final String location;
  final String response;
  final List<dynamic> images;

  const ObservationCreate({
    required this.name,
    required this.siteId,
    required this.location,
    required this.response,
    this.images = const [],
  });

  @override
  List<Object?> get props => [
        siteId,
        location,
        response,
        images,
      ];

  ObservationCreate copyWith({
    String? name,
    String? siteId,
    String? location,
    String? response,
    List<dynamic>? images,
  }) {
    return ObservationCreate(
      name: name ?? this.name,
      siteId: siteId ?? this.siteId,
      location: location ?? this.location,
      response: response ?? this.response,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'siteId': siteId,
      'location': location,
      'response': response,
      'images': images,
    };
  }

  String toJson() => json.encode(toMap());
}
