import 'package:intl/intl.dart';
import 'package:safety_eta/common_libraries.dart';

class ActionItemDetail extends Equatable {
  final String id;
  final String? status;
  final String? source;
  final String? description;
  final DateTime? dueBy;
  final String assigneeId;
  final String? assigneeName;
  final String? awarenessCategoryId;
  final String? awarenessCategoryName;
  final String? companyId;
  final String? companyName;
  final String? projectId;
  final String? projectName;
  final String? siteId;
  final String? siteName;
  final String? observationId;
  final String? observationName;
  final String? auditSectionItemId;
  final String? auditSectionName;
  final String? auditId;
  final String? auditName;
  final String? area;
  final String? notes;
  final String? closedBy;
  final String? closedByName;
  final bool? isClosed;
  final DateTime? closedOn;
  final DateTime createdOn;
  final String? createdBy;

  const ActionItemDetail({
    required this.id,
    this.status,
    this.source,
    this.description,
    this.dueBy,
    required this.assigneeId,
    this.assigneeName,
    this.awarenessCategoryId,
    this.awarenessCategoryName,
    this.companyId,
    this.companyName,
    this.projectId,
    this.projectName,
    this.siteId,
    this.siteName,
    this.observationId,
    this.observationName,
    this.auditSectionItemId,
    this.auditSectionName,
    this.auditId,
    this.auditName,
    this.area,
    this.notes,
    this.closedBy,
    this.closedByName,
    this.isClosed,
    this.closedOn,
    required this.createdOn,
    this.createdBy,
  });

  @override
  List<Object?> get props => [
        id,
        status,
        source,
        description,
        dueBy,
        assigneeId,
        assigneeName,
        awarenessCategoryId,
        awarenessCategoryName,
        companyId,
        companyName,
        projectId,
        projectName,
        siteId,
        siteName,
        observationId,
        observationName,
        auditSectionItemId,
        auditSectionName,
        auditId,
        auditName,
        area,
        notes,
        closedBy,
        closedByName,
        isClosed,
        closedOn,
        createdOn,
        createdBy,
      ];

  String get formatedDueBy =>
      dueBy != null ? DateFormat('MM/dd/yyyy').format(dueBy!) : '--';

  ActionItemDetail copyWith({
    String? id,
    String? status,
    String? source,
    String? description,
    DateTime? dueBy,
    String? assigneeId,
    String? assigneeName,
    String? awarenessCategoryId,
    String? awarenessCategoryName,
    String? companyId,
    String? companyName,
    String? projectId,
    String? projectName,
    String? siteId,
    String? siteName,
    String? observationId,
    String? observationName,
    String? auditSectionItemId,
    String? auditSectionName,
    String? auditId,
    String? auditName,
    String? area,
    String? notes,
    String? closedBy,
    String? closedByName,
    bool? isClosed,
    DateTime? closedOn,
    DateTime? createdOn,
    String? createdBy,
  }) {
    return ActionItemDetail(
      id: id ?? this.id,
      status: status ?? this.status,
      source: source ?? this.source,
      description: description ?? this.description,
      dueBy: dueBy ?? this.dueBy,
      assigneeId: assigneeId ?? this.assigneeId,
      assigneeName: assigneeName ?? this.assigneeName,
      awarenessCategoryId: awarenessCategoryId ?? this.awarenessCategoryId,
      awarenessCategoryName:
          awarenessCategoryName ?? this.awarenessCategoryName,
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      projectId: projectId ?? this.projectId,
      projectName: projectName ?? this.projectName,
      siteId: siteId ?? this.siteId,
      siteName: siteName ?? this.siteName,
      observationId: observationId ?? this.observationId,
      observationName: observationName ?? this.observationName,
      auditSectionItemId: auditSectionItemId ?? this.auditSectionItemId,
      auditSectionName: auditSectionName ?? this.auditSectionName,
      auditId: auditId ?? this.auditId,
      auditName: auditName ?? this.auditName,
      area: area ?? this.area,
      notes: notes ?? this.notes,
      closedBy: closedBy ?? this.closedBy,
      closedByName: closedByName ?? this.closedByName,
      isClosed: isClosed ?? this.isClosed,
      closedOn: closedOn ?? this.closedOn,
      createdOn: createdOn ?? this.createdOn,
      createdBy: createdBy ?? this.createdBy,
    );
  }

  factory ActionItemDetail.fromMap(Map<String, dynamic> map) {
    return ActionItemDetail(
      id: map['id'] as String,
      status: map['status'] != null ? map['status'] as String : null,
      source: map['source'] != null ? map['source'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      dueBy: map['dueBy'] != null ? DateTime.parse(map['dueBy']) : null,
      assigneeId: map['assigneeId'] as String,
      assigneeName:
          map['assigneeName'] != null ? map['assigneeName'] as String : null,
      awarenessCategoryId: map['awarenessCategoryId'] != null
          ? map['awarenessCategoryId'] as String
          : null,
      awarenessCategoryName: map['awarenessCategoryName'] != null
          ? map['awarenessCategoryName'] as String
          : null,
      companyId: map['companyId'] != null ? map['companyId'] as String : null,
      companyName:
          map['companyName'] != null ? map['companyName'] as String : null,
      projectId: map['projectId'] != null ? map['projectId'] as String : null,
      projectName:
          map['projectName'] != null ? map['projectName'] as String : null,
      siteId: map['siteId'] != null ? map['siteId'] as String : null,
      siteName: map['siteName'] != null ? map['siteName'] as String : null,
      observationId:
          map['observationId'] != null ? map['observationId'] as String : null,
      observationName: map['observationName'] != null
          ? map['observationName'] as String
          : null,
      auditSectionItemId: map['auditSectionItemId'] != null
          ? map['auditSectionItemId'] as String
          : null,
      auditSectionName: map['auditSectionName'] != null
          ? map['auditSectionName'] as String
          : null,
      auditId: map['auditId'] != null ? map['auditId'] as String : null,
      auditName: map['auditName'] != null ? map['auditName'] as String : null,
      area: map['area'] != null ? map['area'] as String : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
      closedBy: map['closedBy'] != null ? map['closedBy'] as String : null,
      closedByName:
          map['closedByName'] != null ? map['closedByName'] as String : null,
      isClosed: map['isClosed'] != null ? map['isClosed'] as bool : null,
      closedOn:
          map['closedOn'] != null ? DateTime.parse(map['closedOn']) : null,
      createdOn: DateTime.parse(map['createdOn']),
      createdBy: map['createdBy'] != null ? map['createdBy'] as String : null,
    );
  }

  factory ActionItemDetail.fromJson(String source) =>
      ActionItemDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}
