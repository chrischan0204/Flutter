// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:safety_eta/common_libraries.dart';

class AuditQuestionOnActionItem extends Equatable {
  final String auditId;
  final String? auditNumber;
  final String? auditName;
  final DateTime auditDate;
  final String auditStatus;
  final String? projectName;
  final String? siteName;
  final String? companies;
  final String? createdBy;
  final DateTime createdOn;
  final String? auditSectionName;
  final String? auditSectionItemId;
  final String? question;
  final int? questionOrder;
  final int questionStatus;

  const AuditQuestionOnActionItem({
    required this.auditId,
    this.auditNumber,
    this.auditName,
    required this.auditDate,
    required this.auditStatus,
    this.projectName,
    this.siteName,
    this.companies,
    this.createdBy,
    required this.createdOn,
    this.auditSectionName,
    this.auditSectionItemId,
    this.question,
    this.questionOrder,
    required this.questionStatus,
  });

  @override
  List<Object?> get props => [
        auditId,
        auditNumber,
        auditName,
        auditDate,
        auditStatus,
        projectName,
        siteName,
        companies,
        createdBy,
        createdOn,
        auditSectionName,
        auditSectionItemId,
        question,
        questionOrder,
        questionStatus,
      ];
  String get formatedAuditDate =>
      DateFormat('MM/d/yyyy - hh:mm a').format(auditDate);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'auditId': auditId,
      'auditNumber': auditNumber,
      'auditName': auditName,
      'auditDate': auditDate.millisecondsSinceEpoch,
      'auditStatus': auditStatus,
      'projectName': projectName,
      'siteName': siteName,
      'companies': companies,
      'createdBy': createdBy,
      'createdOn': createdOn.millisecondsSinceEpoch,
      'auditSectionName': auditSectionName,
      'auditSectionItemId': auditSectionItemId,
      'question': question,
      'questionOrder': questionOrder,
      'questionStatus': questionStatus,
    };
  }

  AuditQuestionOnActionItem copyWith({
    String? auditId,
    String? auditNumber,
    String? auditName,
    DateTime? auditDate,
    String? auditStatus,
    String? projectName,
    String? siteName,
    String? companies,
    String? createdBy,
    DateTime? createdOn,
    String? auditSectionName,
    String? auditSectionItemId,
    String? question,
    int? questionOrder,
    int? questionStatus,
  }) {
    return AuditQuestionOnActionItem(
      auditId: auditId ?? this.auditId,
      auditNumber: auditNumber ?? this.auditNumber,
      auditName: auditName ?? this.auditName,
      auditDate: auditDate ?? this.auditDate,
      auditStatus: auditStatus ?? this.auditStatus,
      projectName: projectName ?? this.projectName,
      siteName: siteName ?? this.siteName,
      companies: companies ?? this.companies,
      createdBy: createdBy ?? this.createdBy,
      createdOn: createdOn ?? this.createdOn,
      auditSectionName: auditSectionName ?? this.auditSectionName,
      auditSectionItemId: auditSectionItemId ?? this.auditSectionItemId,
      question: question ?? this.question,
      questionOrder: questionOrder ?? this.questionOrder,
      questionStatus: questionStatus ?? this.questionStatus,
    );
  }

  factory AuditQuestionOnActionItem.fromMap(Map<String, dynamic> map) {
    return AuditQuestionOnActionItem(
      auditId: map['auditId'] as String,
      auditNumber:
          map['auditNumber'] != null ? map['auditNumber'] as String : null,
      auditName: map['auditName'] != null ? map['auditName'] as String : null,
      auditDate: DateTime.parse(map['auditDate']),
      auditStatus: map['auditStatus'] as String,
      projectName:
          map['projectName'] != null ? map['projectName'] as String : null,
      siteName: map['siteName'] != null ? map['siteName'] as String : null,
      companies: map['companies'] != null ? map['companies'] as String : null,
      createdBy: map['createdBy'] != null ? map['createdBy'] as String : null,
      createdOn: DateTime.parse(map['createdOn']),
      auditSectionName: map['auditSectionName'] != null
          ? map['auditSectionName'] as String
          : null,
      auditSectionItemId: map['auditSectionItemId'] != null
          ? map['auditSectionItemId'] as String
          : null,
      question: map['question'] != null ? map['question'] as String : null,
      questionOrder:
          map['questionOrder'] != null ? map['questionOrder'] as int : null,
      questionStatus: map['questionStatus'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuditQuestionOnActionItem.fromJson(String source) =>
      AuditQuestionOnActionItem.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
