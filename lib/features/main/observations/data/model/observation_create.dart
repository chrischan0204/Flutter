import 'package:flutter/foundation.dart';

import '/common_libraries.dart';

class ObservationCreate extends Equatable {
  final String? id;
  final String name;
  final String siteId;
  final String location;
  final String response;
  final String priorityLevelId;
  final String observationTypeId;
  final String? auditId;
  final String? auditSectionItemId;
  final String? reportedBy;
  final String projectId;
  final String companyId;

  const ObservationCreate({
    this.id,
    required this.name,
    required this.siteId,
    required this.location,
    required this.response,
    required this.priorityLevelId,
    required this.observationTypeId,
    this.auditId,
    this.auditSectionItemId,
    this.reportedBy,
    required this.projectId,
    required this.companyId,
  });

  @override
  List<Object?> get props => [
        id,
        siteId,
        location,
        response,
        priorityLevelId,
        observationTypeId,
        auditId,
        auditSectionItemId,
        reportedBy,
        projectId,
        companyId,
      ];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'siteId': siteId,
      'userReportedPriorityLevelId': priorityLevelId,
      'userReportedObservationTypeId': observationTypeId,
      'userReportedProjectId': projectId,
      'userReportedCompanyId': companyId,
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

    if (id != null) {
      map.addAll({'id': id});
    }

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
    String? id,
    String? name,
    String? siteId,
    String? location,
    String? response,
    String? priorityLevelId,
    String? observationTypeId,
    String? auditId,
    String? auditSectionItemId,
    String? reportedBy,
    String? projectId,
    String? company,
    String? companyId,
  }) {
    return ObservationCreate(
      id: id ?? this.id,
      name: name ?? this.name,
      siteId: siteId ?? this.siteId,
      location: location ?? this.location,
      response: response ?? this.response,
      priorityLevelId: priorityLevelId ?? this.priorityLevelId,
      observationTypeId: observationTypeId ?? this.observationTypeId,
      auditId: auditId ?? this.auditId,
      auditSectionItemId: auditSectionItemId ?? this.auditSectionItemId,
      reportedBy: reportedBy ?? this.reportedBy,
      projectId: projectId ?? this.projectId,
      companyId: companyId ?? this.companyId,
    );
  }
}
