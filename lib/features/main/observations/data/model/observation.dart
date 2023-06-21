import '/common_libraries.dart';

class Observation extends Entity {
  final String statusName;
  final String location;
  final String source;
  final String reportedBy;
  final String reportedAt;
  final String via;
  final String assessed;
  final String assessedBy;
  final String assessedAs;
  final String actionItems;
  const Observation({
    super.id,
    super.name,
    required this.statusName,
    required this.location,
    required this.source,
    required this.reportedBy,
    required this.reportedAt,
    required this.via,
    required this.assessed,
    required this.assessedBy,
    required this.assessedAs,
    required this.actionItems,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        statusName,
        location,
        source,
        reportedBy,
        reportedAt,
        via,
        assessed,
        assessedBy,
        assessedAs,
        actionItems,
      ];

  @override
  Map<String, dynamic> tableItemsToMap() {
    return {
      'Observation': name,
      'Status': statusName,
      'Source': source,
      'Reported By': reportedBy,
      'Reported At': reportedAt,
      'Assessed?': assessed,
      'Assessed By': assessedBy,
    };
  }

  @override
  Map<String, dynamic> sideDetailItemsToMap() {
    return {
      'Observation': {'content': name},
      'Location': {'content': location},
      'Reported By': reportedBy,
      'Reported At': reportedAt,
      'Via': via,
      'Assessor': assessedBy,
      'Assessed?': assessed,
      'Assessed As': assessedAs,
      'Action Items': {'content': actionItems}
    };
  }

  @override
  Map<String, dynamic> detailItemsToMap() {
    return {
      'Template Description': name,
    };
  }

  Observation copyWith({
    String? statusName,
    String? location,
    String? source,
    String? reportedBy,
    String? reportedAt,
    String? via,
    String? assessed,
    String? assessedBy,
    String? assessedAs,
    String? actionItems,
  }) {
    return Observation(
      statusName: statusName ?? this.statusName,
      location: location ?? this.location,
      source: source ?? this.source,
      reportedBy: reportedBy ?? this.reportedBy,
      reportedAt: reportedAt ?? this.reportedAt,
      via: via ?? this.via,
      assessed: assessed ?? this.assessed,
      assessedBy: assessedBy ?? this.assessedBy,
      assessedAs: assessedAs ?? this.assessedAs,
      actionItems: actionItems ?? this.actionItems,
    );
  }

  factory Observation.fromMap(Map<String, dynamic> map) {
    return Observation(
      statusName: map['statusName'] as String,
      location: map['location'] as String,
      source: map['source'] as String,
      reportedBy: map['reportedBy'] as String,
      reportedAt: map['reportedAt'] as String,
      via: map['via'] as String,
      assessed: map['assessed'] as String,
      assessedBy: map['assessedBy'] as String,
      assessedAs: map['assessedAs'] as String,
      actionItems: map['actionItems'] as String,
    );
  }

  factory Observation.fromJson(String source) =>
      Observation.fromMap(json.decode(source) as Map<String, dynamic>);
}
