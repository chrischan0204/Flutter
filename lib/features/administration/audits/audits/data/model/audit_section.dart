// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '/common_libraries.dart';

enum AuditSectionStatus {
  done,
  partial,
  inProgress,
  notStarted;

  @override
  String toString() {
    switch (this) {
      case AuditSectionStatus.done:
        return 'Done';
      case AuditSectionStatus.partial:
        return 'Partial';
      case AuditSectionStatus.inProgress:
        return 'In Progress';
      case AuditSectionStatus.notStarted:
        return 'Not Started';
    }
  }

  Color toColor() {
    switch (this) {
      case AuditSectionStatus.done:
        return successColor;
      case AuditSectionStatus.partial:
        return Colors.blueGrey;
      case AuditSectionStatus.inProgress:
        return primaryColor;
      case AuditSectionStatus.notStarted:
        return warnColor;
    }
  }
}

class AuditSection extends Equatable {
  final String id;
  final String name;
  final int order;
  final bool isIncluded;
  final int questionCount;
  final double maxScore;
  final AuditSectionStatus status;
  final List<AuditQuestion> auditQuestionList;

  const AuditSection({
    this.id = emptyGuid,
    this.name = '',
    this.order = 0,
    this.isIncluded = true,
    this.status = AuditSectionStatus.done,
    this.questionCount = 0,
    this.maxScore = 0,
    this.auditQuestionList = const [],
  });

  bool get isNoIncluded =>
      auditQuestionList.where((element) => element.questionIncluded).isEmpty;

  @override
  List<Object?> get props => [
        id,
        name,
        order,
        isIncluded,
        status,
        auditQuestionList,
        questionCount,
        maxScore,
      ];

  AuditSection copyWith({
    String? id,
    String? name,
    int? order,
    bool? isIncluded,
    int? questionCount,
    double? maxScore,
    AuditSectionStatus? status,
    List<AuditQuestion>? auditQuestionList,
  }) {
    return AuditSection(
      id: id ?? this.id,
      name: name ?? this.name,
      order: order ?? this.order,
      isIncluded: isIncluded ?? this.isIncluded,
      questionCount: questionCount ?? this.questionCount,
      maxScore: maxScore ?? this.maxScore,
      status: status ?? this.status,
      auditQuestionList: auditQuestionList ?? this.auditQuestionList,
    );
  }

  factory AuditSection.fromMap(Map<String, dynamic> map) {
    return AuditSection(
      id: map['id'],
      name: map['name'],
      order: map['order'],
      isIncluded: map['isIncluded'],
      questionCount: map['questionCount'] ?? 0,
      maxScore: map['maxScore'] ?? 0,
      status: AuditSectionStatus.done,
      auditQuestionList: [],
    );
  }

  factory AuditSection.fromJson(String source) =>
      AuditSection.fromMap(json.decode(source) as Map<String, dynamic>);
}
