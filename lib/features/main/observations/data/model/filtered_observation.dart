import '/common_libraries.dart';

class FilteredObservation extends FilteredEntity {
  final String name;
  final String site;
  final String reportedVia;
  final bool markedAsClosed;
  final String reportedBy;
  DateTime? reportedAt;
  final String area;
  final String reportedPriorityLevel;
  final String reportedObservationType;
  final String response;
  final String assessedBy;
  final String assessedOn;
  final String assessmentAwarenessCategory;
  final String assessmentComment;
  final String assessmentObservationType;
  final String assessmentPriorityLevel;
  final String company;
  final int imageCount;
  final String notificationSentVia;
  final String notificationSentAt;
  final String project;
  final String region;

  FilteredObservation({
    required this.name,
    required this.site,
    required this.reportedVia,
    required this.markedAsClosed,
    required this.reportedBy,
    this.reportedAt,
    required this.area,
    required this.reportedPriorityLevel,
    required this.reportedObservationType,
    required this.response,
    required this.assessedBy,
    required this.assessedOn,
    required this.assessmentAwarenessCategory,
    required this.assessmentComment,
    required this.assessmentObservationType,
    required this.assessmentPriorityLevel,
    required this.company,
    required this.imageCount,
    required this.notificationSentVia,
    required this.notificationSentAt,
    required this.project,
    required this.region,
    super.id,
    super.createdBy,
    super.createdById,
    super.createdOn,
    super.lastModifiedByUserName,
    super.lastModifiedOn,
    super.deleted,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        name,
        site,
        reportedVia,
        markedAsClosed,
        reportedBy,
        reportedAt,
        area,
        reportedPriorityLevel,
        reportedObservationType,
        response,
        assessedBy,
        assessedOn,
        assessmentAwarenessCategory,
        assessmentComment,
        assessmentObservationType,
        assessmentPriorityLevel,
        company,
        imageCount,
        notificationSentVia,
        notificationSentAt,
        project,
        region,
      ];

  Observation get observation => Observation(
        id: id,
        name: name,
        site: site,
        reportedVia: reportedVia,
        markedAsClosed: markedAsClosed,
        reportedAt: reportedAt,
        reportedBy: reportedBy,
        area: area,
        reportedPriorityLevel: reportedPriorityLevel,
        reportedObservationType: reportedObservationType,
        response: response,
        createdByUserName: createdBy,
        createdOn: createdOn,
        lastModifiedOn: lastModifiedOn,
        lastModifiedByUserName: lastModifiedByUserName,
        deleted: deleted,
        assessedBy: assessedBy,
        assessedOn: assessedOn,
        assessmentAwarenessCategory: assessmentAwarenessCategory,
        assessmentComment: assessmentComment,
        assessmentPriorityLevel: assessmentPriorityLevel,
        assessmentObservationType: assessmentObservationType,
        company: company,
        imageCount: 0,
        notificationSentAt: notificationSentAt,
        notificationSentVia: notificationSentVia,
        project: project,
        region: region,
      );

  factory FilteredObservation.fromMap(Map<String, dynamic> map) {
    FilteredEntity entity = FilteredEntity.fromMap(map);
    return FilteredObservation(
      id: entity.id,
      name: map['observation'] ?? '',
      site: map['site'] ?? '',
      reportedVia: map['reported_Via'] ?? '',
      markedAsClosed: map['marked_As_Closed'] ?? '',
      reportedBy: map['reported_By'] ?? '',
      reportedAt: map['reported_At'] != null
          ? DateTime.parse(map['reported_At'])
          : null,
      area: map['area'] ?? '',
      reportedPriorityLevel: map['reported_Priority_Level'] ?? '',
      reportedObservationType: map['reported_Observation_Type'] ?? '',
      response: map['response'] ?? '',
      createdBy: entity.createdBy,
      createdOn: entity.createdOn,
      lastModifiedOn: entity.lastModifiedOn,
      lastModifiedByUserName: entity.lastModifiedByUserName,
      deleted: entity.deleted,
      assessedBy: map['assessed_By'] ?? '',
      assessedOn: map['assessed_On'] ?? '',
      assessmentComment: map['assessment_Comment'] ?? '',
      assessmentAwarenessCategory: map['assessment_Awareness_Category'] ?? '',
      assessmentObservationType: map['assessment_Observation_Type'] ?? '',
      assessmentPriorityLevel: map['assessment_Priority_Level'] ?? '',
      company: map['company'] ?? '',
      imageCount: map['image_Count'] ?? 0,
      notificationSentAt: map['notification_Sent_At'] ?? '',
      notificationSentVia: map['notification_Sent_Via'] ?? '',
      project: map['project'] ?? map['project'] ?? '',
      region: map['region'] ?? map['region'] ?? '',
    );
  }

  factory FilteredObservation.fromJson(String source) =>
      FilteredObservation.fromMap(json.decode(source) as Map<String, dynamic>);

  FilteredObservation copyWith({
    String? name,
    String? site,
    String? reportedVia,
    bool? markedAsClosed,
    String? reportedBy,
    DateTime? reportedAt,
    String? area,
    String? reportedPriorityLevel,
    String? reportedObservationType,
    String? response,
    String? assessedBy,
    String? assessedOn,
    String? assessmentAwarenessCategory,
    String? assessmentComment,
    String? assessmentObservationType,
    String? assessmentPriorityLevel,
    String? company,
    int? imageCount,
    String? notificationSentVia,
    String? notificationSentAt,
    String? project,
    String? region,
    String? createdBy,
    String? createdOn,
    String? lastModifiedOn,
    String? lastModifiedByUserName,
    bool? deleted,
  }) {
    return FilteredObservation(
      name: name ?? this.name,
      site: site ?? this.site,
      reportedVia: reportedVia ?? this.reportedVia,
      markedAsClosed: markedAsClosed ?? this.markedAsClosed,
      reportedBy: reportedBy ?? this.reportedBy,
      reportedAt: reportedAt ?? this.reportedAt,
      area: area ?? this.area,
      reportedPriorityLevel:
          reportedPriorityLevel ?? this.reportedPriorityLevel,
      reportedObservationType:
          reportedObservationType ?? this.reportedObservationType,
      response: response ?? this.response,
      assessedBy: assessedBy ?? this.assessedBy,
      assessedOn: assessedOn ?? this.assessedOn,
      assessmentAwarenessCategory:
          assessmentAwarenessCategory ?? this.assessmentAwarenessCategory,
      assessmentComment: assessmentComment ?? this.assessmentComment,
      assessmentObservationType:
          assessmentObservationType ?? this.assessmentObservationType,
      assessmentPriorityLevel:
          assessmentPriorityLevel ?? this.assessmentPriorityLevel,
      company: company ?? this.company,
      imageCount: imageCount ?? this.imageCount,
      notificationSentVia: notificationSentVia ?? this.notificationSentVia,
      notificationSentAt: notificationSentAt ?? this.notificationSentAt,
      project: project ?? this.project,
      region: region ?? this.region,
      createdBy: createdBy ?? this.createdBy,
      createdOn: createdOn ?? this.createdOn,
      lastModifiedOn: lastModifiedOn ?? this.lastModifiedOn,
      lastModifiedByUserName:
          lastModifiedByUserName ?? this.lastModifiedByUserName,
      deleted: deleted ?? this.deleted,
    );
  }
}
