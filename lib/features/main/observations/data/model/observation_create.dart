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
  final String? auditId;
  final String? auditSectionItemId;
  final String? reportedBy;

  const ObservationCreate({
    required this.name,
    required this.siteId,
    required this.location,
    required this.response,
    required this.priorityLevelId,
    required this.observationTypeId,
    this.auditId,
    this.auditSectionItemId,
    this.reportedBy,
  });

  @override
  List<Object?> get props => [
        siteId,
        location,
        response,
        priorityLevelId,
        observationTypeId,
        auditId,
        auditSectionItemId,
        reportedBy,
      ];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'siteId': siteId,
      'userReportedPriorityLevelId': priorityLevelId,
      'userReportedObservationTypeId': observationTypeId,
      'response': response,
      'base64Image': '',
      'description': name,
      'area': location,
      'reportedVia': kIsWeb
          ? 'Web'
          : !kIsWeb &&
                  (defaultTargetPlatform == TargetPlatform.android ||
                      defaultTargetPlatform == TargetPlatform.iOS)
              ? 'TapIn'
              : 'Kiosk',
    };

    if (auditId != null && auditSectionItemId != null) {
      map.addAll({
        'auditId': auditId,
        'auditSectionItemId': auditSectionItemId,
      });
    }

    if (reportedBy != null) {
      map.addAll({'reportedBy': reportedBy});
    }

    return map;
  }

  String toJson() => json.encode(toMap());

  ObservationCreate copyWith({
    String? name,
    String? siteId,
    String? location,
    String? response,
    String? priorityLevelId,
    String? observationTypeId,
    String? auditId,
    String? auditSectionItemId,
  }) {
    return ObservationCreate(
      name: name ?? this.name,
      siteId: siteId ?? this.siteId,
      location: location ?? this.location,
      response: response ?? this.response,
      priorityLevelId: priorityLevelId ?? this.priorityLevelId,
      observationTypeId: observationTypeId ?? this.observationTypeId,
      auditId: auditId ?? this.auditId,
      auditSectionItemId: auditSectionItemId ?? this.auditSectionItemId,
    );
  }
}
