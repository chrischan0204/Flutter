import 'package:flutter/foundation.dart';

import '/common_libraries.dart';

class ObservationCreate extends Equatable {
  final String name;
  final String siteId;
  final String location;
  final String response;
  final List<Uint8List> images;

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
    List<Uint8List>? images,
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
      'siteId': siteId,
      'userReportedPriorityLevelId': 'bfd6e228-d9a8-417f-88b5-4c5f60d75f36',
      'userReportedObservationTypeId': 'b0c92972-d4f5-4c96-9871-bdf244af1a9d',
      'response': response,
      'base64Image': base64.encode(images[0]),
      'description': name,
      'area': location,
    };
  }

  String toJson() => json.encode(toMap());
}
