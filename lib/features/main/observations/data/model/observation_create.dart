// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import '/common_libraries.dart';

class ObservationCreate extends Equatable {
  final String name;
  final String siteId;
  final String location;
  final String response;
  final String priorityLevelId;
  final String observationTypeId;
  final List<Uint8List> images;

  const ObservationCreate({
    required this.name,
    required this.siteId,
    required this.location,
    required this.response,
    required this.priorityLevelId,
    required this.observationTypeId,
    this.images = const [],
  });

  @override
  List<Object?> get props => [
        siteId,
        location,
        response,
        priorityLevelId,
        observationTypeId,
        images,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'siteId': siteId,
      'userReportedPriorityLevelId': priorityLevelId,
      'userReportedObservationTypeId': observationTypeId,
      'response': response,
      'base64Image': base64.encode(images[0]),
      'description': name,
      'area': location,
    };
  }

  String toJson() => json.encode(toMap());

  ObservationCreate copyWith({
    String? name,
    String? siteId,
    String? location,
    String? response,
    String? priorityLevelId,
    String? observationTypeId,
    List<Uint8List>? images,
  }) {
    return ObservationCreate(
      name: name ?? this.name,
      siteId: siteId ?? this.siteId,
      location: location ?? this.location,
      response: response ?? this.response,
      priorityLevelId: priorityLevelId ?? this.priorityLevelId,
      observationTypeId: observationTypeId ?? this.observationTypeId,
      images: images ?? this.images,
    );
  }
}
