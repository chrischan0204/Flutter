import '/common_libraries.dart';

class AssessmentCreate {
  final bool notificationSent;
  // final String observerId;
  // final String assessorId;
  final String reportedVia;
  // final String kioskId;
  final String assessmentAwarenessCategoryId;
  final String assessmentObservationTypeId;
  final String assessmentPriorityLevelId;
  final String assessmentFollowupComment;
  final String assessmentCompanyId;
  final String assessmentProjectId;
  final String assessmentSiteId;
  final String userReportedObservationTypeId;

  const AssessmentCreate({
    required this.notificationSent,
    // required this.observerId,
    // required this.assessorId,
    required this.reportedVia,
    // required this.kioskId,
    required this.assessmentAwarenessCategoryId,
    required this.assessmentObservationTypeId,
    required this.assessmentPriorityLevelId,
    required this.assessmentFollowupComment,
    required this.assessmentCompanyId,
    required this.assessmentProjectId,
    required this.assessmentSiteId,
    required this.userReportedObservationTypeId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'notificationSent': notificationSent,
      // 'observerId': observerId,
      // 'assessorId': assessorId,
      'reportedVia': reportedVia,
      // 'kioskId': kioskId,
      'assessmentAwarenessCategoryId': assessmentAwarenessCategoryId,
      'assessmentObservationTypeId': assessmentObservationTypeId,
      'assessmentPriorityLevelId': assessmentPriorityLevelId,
      'assessmentFollowupComment': assessmentFollowupComment,
      'assessmentCompanyId': assessmentCompanyId,
      'assessmentProjectId': assessmentProjectId,
      'assessmentSiteId': assessmentSiteId,
      'userReportedObservationTypeId': userReportedObservationTypeId,
    };
  }

  String toJson() => json.encode(toMap());

  AssessmentCreate copyWith({
    bool? notificationSent,
    String? observerId,
    String? assessorId,
    String? reportedVia,
    String? kioskId,
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
      // observerId: observerId ?? this.observerId,
      // assessorId: assessorId ?? this.assessorId,
      reportedVia: reportedVia ?? this.reportedVia,
      // kioskId: kioskId ?? this.kioskId,
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
      userReportedObservationTypeId:
          userReportedObservationTypeId ?? this.userReportedObservationTypeId,
    );
  }
}
