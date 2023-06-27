import '/common_libraries.dart';

class Observation extends Entity {
  final String site;
  final String reportedVia;
  final bool markedAsClosed;
  final String reportedBy;
  final String reportedAt;
  final String area;
  final String reportedPriorityLevel;
  final String reportedObservationType;
  final String response;
  final bool assessed;
  final String assessedAs;
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
  final String actionItems;

  const Observation({
    super.id,
    super.name,
    this.site = '',
    this.reportedVia = '',
    this.markedAsClosed = true,
    this.reportedAt = '',
    this.reportedBy = '',
    this.area = '',
    this.reportedPriorityLevel = '',
    this.reportedObservationType = '',
    this.response = '',
    this.assessed = true,
    this.assessedAs = '',
    this.assessedBy = '',
    this.assessedOn = '',
    this.assessmentAwarenessCategory = '',
    this.assessmentComment = '',
    this.assessmentObservationType = '',
    this.assessmentPriorityLevel = '',
    this.company = '',
    this.imageCount = 0,
    this.notificationSentVia = '',
    this.notificationSentAt = '',
    this.project = '',
    this.region = '',
    super.createdByUserName,
    super.createdOn,
    super.lastModifiedByUserName,
    super.lastModifiedOn,
    super.columns,
    super.deleted,
    this.actionItems = '',
  });

  @override
  List<Object?> get props => [
        ...super.props,
        site,
        reportedVia,
        markedAsClosed,
        reportedBy,
        reportedAt,
        area,
        reportedPriorityLevel,
        reportedObservationType,
        response,
        assessed,
        assessedBy,
        assessedAs,
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
        actionItems,
      ];

  Observation copyWith({
    String? id,
    String? name,
    String? site,
    String? reportedVia,
    bool? markedAsClosed,
    String? reportedBy,
    String? reportedAt,
    String? area,
    String? reportedPriorityLevel,
    String? reportedObservationType,
    String? response,
    bool? assessed,
    String? assessedAs,
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
    String? actionItems,
    List<String>? columns,
    String? createdByUserName,
    String? createdOn,
    String? lastModifiedOn,
    String? lastModifiedByUserName,
    bool? deleted,
  }) {
    return Observation(
      id: id ?? this.id,
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
      assessed: assessed ?? this.assessed,
      assessedAs: assessedAs ?? this.assessedAs,
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
      actionItems: actionItems ?? this.actionItems,
      createdByUserName: createdByUserName ?? this.createdByUserName,
      createdOn: createdOn ?? this.createdOn,
      lastModifiedOn: lastModifiedOn ?? this.lastModifiedOn,
      lastModifiedByUserName:
          lastModifiedByUserName ?? this.lastModifiedByUserName,
      deleted: deleted ?? this.deleted,
      columns: columns ?? this.columns,
    );
  }

  factory Observation.fromMap(Map<String, dynamic> map) {
    return Observation(
      id: map['id'] ?? '',
      name: map['description'] ?? '',
      site: map['siteName'] ?? '',
      area: map['area'] ?? '',
      reportedAt: map['reportedAt'] ?? '',
      reportedBy: map['reportedByUserName'] ?? '',
      reportedVia: map['reportedVia'] ?? '',
      assessedBy: map['assessor'] ?? '',
      assessed: map['assessed'] ?? true,
      actionItems: map['actionItems'] ?? '',
      assessedAs: map['assessedAs'] ?? '',
    );
  }

  factory Observation.fromJson(String source) =>
      Observation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  Map<String, dynamic> tableItemsToMap() {
    return {
      'Observation': name,
      'Site': site,
      'Reported Via': reportedVia,
      'Marked As Closed': markedAsClosed,
      'Reported By': reportedBy,
      'Reported At': reportedAt,
      'Area': area,
      'Reported Observation Type': reportedObservationType,
      'Reported Priority Level': reportedPriorityLevel,
      'Response': response,
      'Assessed By': assessedBy,
      'Assessed On': assessedOn,
      'Assessment Awareness Category': assessmentAwarenessCategory,
      'Assessment Comment': assessmentComment,
      'Assessment Observation Type': assessmentObservationType,
      'Assessment Priority Level': assessmentPriorityLevel,
      'Company': company,
      'Image Count': imageCount,
      'Notification Sent At': notificationSentAt,
      'Notification Sent Via': notificationSentVia,
      'Project': project,
      'Region': region,
    };
  }

  @override
  Map<String, dynamic> sideDetailItemsToMap() {
    return {
      'Observation': {'content': name},
      'Location': {'content': area},
      'Reported By': reportedBy,
      'Reported At': reportedAt,
      'Via': reportedVia,
      'Assessor': assessedBy,
      'Assessed?': assessmentComment,
      'Assessed As': assessed,
      'Action Items': {'content': actionItems}
    };
  }

  @override
  Map<String, dynamic> detailItemsToMap() {
    return {
      'Template Description': name,
    };
  }
}
