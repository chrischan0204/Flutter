import '/common_libraries.dart';

class AssessmentCreate {
  final bool notificationSent;
  // final String reportedVia;
  final bool isClosed;
  final String assessmentAwarenessCategoryId;
  final String assessmentObservationTypeId;
  final String assessmentPriorityLevelId;
  final String assessmentFollowupComment;
  final String assessmentCompanyId;
  final String assessmentProjectId;
  final String assessmentSiteId;

  const AssessmentCreate({
    required this.notificationSent,
    required this.isClosed,
    // required this.reportedVia,
    required this.assessmentAwarenessCategoryId,
    required this.assessmentObservationTypeId,
    required this.assessmentPriorityLevelId,
    required this.assessmentFollowupComment,
    required this.assessmentCompanyId,
    required this.assessmentProjectId,
    required this.assessmentSiteId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'notificationSent': notificationSent,
      // 'reportedVia': reportedVia,
      'isClosed': isClosed,
      'assessmentAwarenessCategoryId': assessmentAwarenessCategoryId,
      'assessmentObservationTypeId': assessmentObservationTypeId,
      'assessmentPriorityLevelId': assessmentPriorityLevelId,
      'assessmentFollowupComment': assessmentFollowupComment,
      'assessmentCompanyId': assessmentCompanyId,
      'assessmentProjectId': assessmentProjectId,
      'assessmentSiteId': assessmentSiteId,
    };
  }

  String toJson() => json.encode(toMap());

  AssessmentCreate copyWith({
    bool? notificationSent,
    String? reportedVia,
    bool? isClosed,
    String? assessmentAwarenessCategoryId,
    String? assessmentObservationTypeId,
    String? assessmentPriorityLevelId,
    String? assessmentFollowupComment,
    String? assessmentCompanyId,
    String? assessmentProjectId,
    String? assessmentSiteId,
    String? userReportedObservationTypeId,
  }) {
    return AssessmentCreate(
      notificationSent: notificationSent ?? this.notificationSent,
      isClosed: isClosed ?? this.isClosed,
      // reportedVia: reportedVia ?? this.reportedVia,
      assessmentAwarenessCategoryId:
          assessmentAwarenessCategoryId ?? this.assessmentAwarenessCategoryId,
      assessmentObservationTypeId:
          assessmentObservationTypeId ?? this.assessmentObservationTypeId,
      assessmentPriorityLevelId:
          assessmentPriorityLevelId ?? this.assessmentPriorityLevelId,
      assessmentFollowupComment:
          assessmentFollowupComment ?? this.assessmentFollowupComment,
      assessmentCompanyId: assessmentCompanyId ?? this.assessmentCompanyId,
      assessmentProjectId: assessmentProjectId ?? this.assessmentProjectId,
      assessmentSiteId: assessmentSiteId ?? this.assessmentSiteId,
    );
  }
}
