import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuditCompletedQuestionsWithFollowups extends Equatable {
  final String auditId;
  final String auditSectionId;
  final String? section;
  final int sectionOrder;
  final String sectionItemId;
  final int itemTypeId;
  final String? parentId;
  final int level;
  final int questionOrder;
  final String? question;
  final int questionStatus;
  final String? response;
  final double score;

  const AuditCompletedQuestionsWithFollowups({
    required this.auditId,
    required this.auditSectionId,
    this.section,
    required this.sectionOrder,
    required this.sectionItemId,
    required this.itemTypeId,
    this.parentId,
    required this.level,
    required this.questionOrder,
    this.question,
    required this.questionStatus,
    this.response,
    required this.score,
  });

  @override
  List<Object?> get props => [
        auditId,
        auditSectionId,
        section,
        sectionOrder,
        sectionItemId,
        itemTypeId,
        parentId,
        level,
        questionOrder,
        question,
        questionStatus,
        response,
        score,
      ];

  factory AuditCompletedQuestionsWithFollowups.fromMap(
      Map<String, dynamic> map) {
    return AuditCompletedQuestionsWithFollowups(
      auditId: map['auditId'] as String,
      auditSectionId: map['auditSectionId'] as String,
      section: map['section'],
      question: map['question'],
      sectionOrder: map['sectionOrder'] as int,
      sectionItemId: map['sectionItemId'] as String,
      itemTypeId: map['itemTypeId'] as int,
      parentId: map['parentId'],
      level: map['level'] as int,
      questionOrder: map['questionOrder'] as int,
      questionStatus: map['questionStatus'] as int,
      response: map['response'],
      score: map['score'] as double,
    );
  }

  factory AuditCompletedQuestionsWithFollowups.fromJson(String source) =>
      AuditCompletedQuestionsWithFollowups.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
