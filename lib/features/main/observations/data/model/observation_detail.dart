import 'package:intl/intl.dart';
import 'package:safety_eta/common_libraries.dart';

class ObservationDetail extends Equatable {
  final String id;
  final String createdBy;
  final DateTime createdOn;
  final String? lastModifiedBy;
  final DateTime? lastModifiedOn;
  final bool deleted;
  final String? description;
  final String? userReportedSiteId;
  final String? userReportedSiteName;
  final String? reportedVia;
  final String? reportedByUserId;
  final String? reportedBy;
  final DateTime? reportedAt;
  final String? area;
  final String? userReportedCompany;
  final String userReportedPriorityLevelId;
  final String? userReportedPriorityLevelName;
  final String userReportedObservationTypeId;
  final String? userReportedObservationTypeName;
  final String? response;
  final String? assessorId;
  final String? assessedByName;
  final DateTime? assessedOn;
  final DateTime? notificationSentAt;
  final String? notificationSentVia;
  final String? notificationSentTo;
  final String? regionName;
  final String? assessmentCompanyId;
  final String? assessmentCompanyName;
  final String? assessmentProjectId;
  final String? assessmentProjectName;
  final String? assessmentAwarenessCategoryId;
  final String? assessmentAwarenessCategoryName;
  final String? assessmentPriorityLevelId;
  final String? assessmentPriorityLevelName;
  final String? assessmentObservationTypeId;
  final String? assessmentObservationTypeName;
  final String? assessmentSiteId;
  final String? assessmentSiteName;
  final String? assessmentFollowupComment;
  final int imageCount;
  final String? createdByUserName;
  final String? lastModifiedByUserName;
  final String? deviceId;
  final bool? isClosed;
  final String? closedById;
  final String? closedByUserName;
  final DateTime? closedOn;
  final bool notificationSent;

  const ObservationDetail({
    required this.id,
    required this.createdBy,
    required this.createdOn,
    this.lastModifiedBy,
    this.lastModifiedOn,
    required this.deleted,
    this.description,
    this.userReportedSiteId,
    this.userReportedSiteName,
    this.reportedVia,
    this.reportedByUserId,
    this.reportedBy,
    this.reportedAt,
    this.area,
    this.userReportedCompany,
    required this.userReportedPriorityLevelId,
    this.userReportedPriorityLevelName,
    required this.userReportedObservationTypeId,
    this.userReportedObservationTypeName,
    this.response,
    this.assessorId,
    this.assessedByName,
    this.assessedOn,
    this.notificationSentAt,
    this.notificationSentVia,
    this.notificationSentTo,
    this.regionName,
    this.assessmentCompanyId,
    this.assessmentCompanyName,
    this.assessmentProjectId,
    this.assessmentProjectName,
    this.assessmentAwarenessCategoryId,
    this.assessmentAwarenessCategoryName,
    this.assessmentPriorityLevelId,
    this.assessmentPriorityLevelName,
    this.assessmentObservationTypeId,
    this.assessmentObservationTypeName,
    this.assessmentSiteId,
    this.assessmentSiteName,
    this.assessmentFollowupComment,
    required this.imageCount,
    this.createdByUserName,
    this.lastModifiedByUserName,
    this.deviceId,
    this.isClosed,
    this.closedById,
    this.closedByUserName,
    this.closedOn,
    required this.notificationSent,
  });

  @override
  List<Object?> get props => [
        id,
        createdBy,
        createdOn,
        lastModifiedBy,
        lastModifiedOn,
        deleted,
        description,
        userReportedSiteId,
        userReportedSiteName,
        reportedVia,
        reportedByUserId,
        reportedBy,
        reportedAt,
        area,
        userReportedCompany,
        userReportedPriorityLevelId,
        userReportedPriorityLevelName,
        userReportedObservationTypeId,
        userReportedObservationTypeName,
        response,
        assessorId,
        assessedByName,
        assessedOn,
        notificationSentAt,
        notificationSentVia,
        notificationSentTo,
        regionName,
        assessmentCompanyId,
        assessmentCompanyName,
        assessmentProjectId,
        assessmentProjectName,
        assessmentAwarenessCategoryId,
        assessmentAwarenessCategoryName,
        assessmentPriorityLevelId,
        assessmentPriorityLevelName,
        assessmentObservationTypeId,
        assessmentObservationTypeName,
        assessmentSiteId,
        assessmentSiteName,
        assessmentFollowupComment,
        imageCount,
        createdByUserName,
        lastModifiedByUserName,
        deviceId,
        isClosed,
        closedById,
        closedByUserName,
        closedOn,
        notificationSent,
      ];

  String? get formatedAssessedOn => assessedOn != null
      ? DateFormat.yMMMMd('en_US').add_jm().format(assessedOn!)
      : null;

  String get formatedClosedOn => closedOn != null
      ? DateFormat.yMMMMd('en_US').add_jm().format(closedOn!)
      : '--';

  String get formatedReportedAt => reportedAt != null
      ? DateFormat.yMMMMd('en_US').add_jm().format(reportedAt!)
      : '--';

  Observation get observation => Observation(
        id: id,
        site: userReportedSiteName ?? '--',
        name: description,
        reportedBy: reportedBy ?? '',
        area: area ?? '',
        reportedAt: reportedAt,
        reportedVia: reportedVia ?? '',
        assessedBy: assessedByName ?? '',
        assessedOn: formatedAssessedOn,
        assessedAs: assessmentObservationTypeName ?? '',
      );

  factory ObservationDetail.fromMap(Map<String, dynamic> map) {
    return ObservationDetail(
      id: map['id'] as String,
      createdBy: map['createdBy'] as String,
      createdOn: DateTime.parse(map['createdOn']),
      lastModifiedBy: map['lastModifiedBy'] != null
          ? map['lastModifiedBy'] as String
          : null,
      lastModifiedOn: map['lastModifiedOn'] != null
          ? DateTime.parse(map['lastModifiedOn'])
          : null,
      deleted: map['deleted'] as bool,
      description:
          map['description'] != null ? map['description'] as String : null,
      userReportedSiteId: map['userReportedSiteId'] != null
          ? map['userReportedSiteId'] as String
          : null,
      userReportedSiteName: map['userReportedSiteName'] != null
          ? map['userReportedSiteName'] as String
          : null,
      reportedVia:
          map['reportedVia'] != null ? map['reportedVia'] as String : null,
      reportedByUserId: map['reportedByUserId'] != null
          ? map['reportedByUserId'] as String
          : null,
      reportedBy:
          map['reportedBy'] != null ? map['reportedBy'] as String : null,
      reportedAt:
          map['reportedAt'] != null ? DateTime.parse(map['reportedAt']) : null,
      area: map['area'] != null ? map['area'] as String : null,
      userReportedCompany: map['userReportedCompany'] != null
          ? map['userReportedCompany'] as String
          : null,
      userReportedPriorityLevelId: map['userReportedPriorityLevelId'] as String,
      userReportedPriorityLevelName:
          map['userReportedPriorityLevelName'] != null
              ? map['userReportedPriorityLevelName'] as String
              : null,
      userReportedObservationTypeId:
          map['userReportedObservationTypeId'] as String,
      userReportedObservationTypeName:
          map['userReportedObservationTypeName'] != null
              ? map['userReportedObservationTypeName'] as String
              : null,
      response: map['response'] != null ? map['response'] as String : null,
      assessorId:
          map['assessorId'] != null ? map['assessorId'] as String : null,
      assessedByName: map['assessedByName'] != null
          ? map['assessedByName'] as String
          : null,
      assessedOn:
          map['assessedOn'] != null ? DateTime.parse(map['assessedOn']) : null,
      notificationSentAt: map['notificationSentAt'] != null
          ? DateTime.parse(map['notificationSentAt'])
          : null,
      notificationSentVia: map['notificationSentVia'] != null
          ? map['notificationSentVia'] as String
          : null,
      notificationSentTo: map['notificationSentTo'] != null
          ? map['notificationSentTo'] as String
          : null,
      regionName:
          map['regionName'] != null ? map['regionName'] as String : null,
      assessmentCompanyId: map['assessmentCompanyId'] != null
          ? map['assessmentCompanyId'] as String
          : null,
      assessmentCompanyName: map['assessmentCompanyName'] != null
          ? map['assessmentCompanyName'] as String
          : null,
      assessmentProjectId: map['assessmentProjectId'] != null
          ? map['assessmentProjectId'] as String
          : null,
      assessmentProjectName: map['assessmentProjectName'] != null
          ? map['assessmentProjectName'] as String
          : null,
      assessmentAwarenessCategoryId:
          map['assessmentAwarenessCategoryId'] != null
              ? map['assessmentAwarenessCategoryId'] as String
              : null,
      assessmentAwarenessCategoryName:
          map['assessmentAwarenessCategoryName'] != null
              ? map['assessmentAwarenessCategoryName'] as String
              : null,
      assessmentPriorityLevelId: map['assessmentPriorityLevelId'] != null
          ? map['assessmentPriorityLevelId'] as String
          : null,
      assessmentPriorityLevelName: map['assessmentPriorityLevelName'] != null
          ? map['assessmentPriorityLevelName'] as String
          : null,
      assessmentObservationTypeId: map['assessmentObservationTypeId'] != null
          ? map['assessmentObservationTypeId'] as String
          : null,
      assessmentObservationTypeName:
          map['assessmentObservationTypeName'] != null
              ? map['assessmentObservationTypeName'] as String
              : null,
      assessmentSiteId: map['assessmentSiteId'] != null
          ? map['assessmentSiteId'] as String
          : null,
      assessmentSiteName: map['assessmentSiteName'] != null
          ? map['assessmentSiteName'] as String
          : null,
      assessmentFollowupComment: map['assessmentFollowupComment'] != null
          ? map['assessmentFollowupComment'] as String
          : null,
      imageCount: map['imageCount'] as int,
      createdByUserName: map['createdByUserName'] != null
          ? map['createdByUserName'] as String
          : null,
      lastModifiedByUserName: map['lastModifiedByUserName'] != null
          ? map['lastModifiedByUserName'] as String
          : null,
      deviceId: map['deviceId'] != null ? map['deviceId'] as String : null,
      isClosed: map['isClosed'] != null ? map['isClosed'] as bool : null,
      closedById:
          map['closedById'] != null ? map['closedById'] as String : null,
      closedByUserName: map['closedByUserName'] != null
          ? map['closedByUserName'] as String
          : null,
      closedOn:
          map['closedOn'] != null ? DateTime.parse(map['closedOn']) : null,
      notificationSent: map['notificationSent'],
    );
  }

  factory ObservationDetail.fromJson(String source) =>
      ObservationDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  ObservationDetail copyWith({
    String? id,
    String? createdBy,
    DateTime? createdOn,
    String? lastModifiedBy,
    DateTime? lastModifiedOn,
    bool? deleted,
    String? description,
    String? userReportedSiteId,
    String? userReportedSiteName,
    String? reportedVia,
    String? reportedByUserId,
    String? reportedBy,
    DateTime? reportedAt,
    String? area,
    String? userReportedCompany,
    String? userReportedPriorityLevelId,
    String? userReportedPriorityLevelName,
    String? userReportedObservationTypeId,
    String? userReportedObservationTypeName,
    String? response,
    String? assessorId,
    String? assessedByName,
    DateTime? assessedOn,
    DateTime? notificationSentAt,
    String? notificationSentVia,
    String? notificationSentTo,
    String? regionName,
    String? assessmentCompanyId,
    String? assessmentCompanyName,
    String? assessmentProjectId,
    String? assessmentProjectName,
    String? assessmentAwarenessCategoryId,
    String? assessmentAwarenessCategoryName,
    String? assessmentPriorityLevelId,
    String? assessmentPriorityLevelName,
    String? assessmentObservationTypeId,
    String? assessmentObservationTypeName,
    String? assessmentSiteId,
    String? assessmentSiteName,
    String? assessmentFollowupComment,
    int? imageCount,
    String? createdByUserName,
    String? lastModifiedByUserName,
    String? deviceId,
    bool? isClosed,
    String? closedById,
    String? closedByUserName,
    DateTime? closedOn,
    bool? notificationSent,
  }) {
    return ObservationDetail(
      id: id ?? this.id,
      createdBy: createdBy ?? this.createdBy,
      createdOn: createdOn ?? this.createdOn,
      lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
      lastModifiedOn: lastModifiedOn ?? this.lastModifiedOn,
      deleted: deleted ?? this.deleted,
      description: description ?? this.description,
      userReportedSiteId: userReportedSiteId ?? this.userReportedSiteId,
      userReportedSiteName: userReportedSiteName ?? this.userReportedSiteName,
      reportedVia: reportedVia ?? this.reportedVia,
      reportedByUserId: reportedByUserId ?? this.reportedByUserId,
      reportedBy: reportedBy ?? this.reportedBy,
      reportedAt: reportedAt ?? this.reportedAt,
      area: area ?? this.area,
      userReportedCompany: userReportedCompany ?? this.userReportedCompany,
      userReportedPriorityLevelId:
          userReportedPriorityLevelId ?? this.userReportedPriorityLevelId,
      userReportedPriorityLevelName:
          userReportedPriorityLevelName ?? this.userReportedPriorityLevelName,
      userReportedObservationTypeId:
          userReportedObservationTypeId ?? this.userReportedObservationTypeId,
      userReportedObservationTypeName: userReportedObservationTypeName ??
          this.userReportedObservationTypeName,
      response: response ?? this.response,
      assessorId: assessorId ?? this.assessorId,
      assessedByName: assessedByName ?? this.assessedByName,
      assessedOn: assessedOn ?? this.assessedOn,
      notificationSentAt: notificationSentAt ?? this.notificationSentAt,
      notificationSentVia: notificationSentVia ?? this.notificationSentVia,
      notificationSentTo: notificationSentTo ?? this.notificationSentTo,
      regionName: regionName ?? this.regionName,
      assessmentCompanyId: assessmentCompanyId ?? this.assessmentCompanyId,
      assessmentCompanyName:
          assessmentCompanyName ?? this.assessmentCompanyName,
      assessmentProjectId: assessmentProjectId ?? this.assessmentProjectId,
      assessmentProjectName:
          assessmentProjectName ?? this.assessmentProjectName,
      assessmentAwarenessCategoryId:
          assessmentAwarenessCategoryId ?? this.assessmentAwarenessCategoryId,
      assessmentAwarenessCategoryName: assessmentAwarenessCategoryName ??
          this.assessmentAwarenessCategoryName,
      assessmentPriorityLevelId:
          assessmentPriorityLevelId ?? this.assessmentPriorityLevelId,
      assessmentPriorityLevelName:
          assessmentPriorityLevelName ?? this.assessmentPriorityLevelName,
      assessmentObservationTypeId:
          assessmentObservationTypeId ?? this.assessmentObservationTypeId,
      assessmentObservationTypeName:
          assessmentObservationTypeName ?? this.assessmentObservationTypeName,
      assessmentSiteId: assessmentSiteId ?? this.assessmentSiteId,
      assessmentSiteName: assessmentSiteName ?? this.assessmentSiteName,
      assessmentFollowupComment:
          assessmentFollowupComment ?? this.assessmentFollowupComment,
      imageCount: imageCount ?? this.imageCount,
      createdByUserName: createdByUserName ?? this.createdByUserName,
      lastModifiedByUserName:
          lastModifiedByUserName ?? this.lastModifiedByUserName,
      deviceId: deviceId ?? this.deviceId,
      isClosed: isClosed ?? this.isClosed,
      closedById: closedById ?? this.closedById,
      closedByUserName: closedByUserName ?? this.closedByUserName,
      closedOn: closedOn ?? this.closedOn,
      notificationSent: notificationSent ?? this.notificationSent,
    );
  }
}
