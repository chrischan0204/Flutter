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
  final bool excluded;
  final int questionCount;
  final double maxScore;
  final AuditSectionStatus status;
  final List<AuditQuestion> auditQuestionList;

  const AuditSection({
    required this.id,
    required this.name,
    required this.order,
    required this.excluded,
    required this.status,
    required this.questionCount,
    required this.maxScore,
    this.auditQuestionList = const [],
  });

  bool get isNoIncluded =>
      auditQuestionList.where((element) => element.included).isEmpty;

  @override
  List<Object?> get props => [
        id,
        name,
        order,
        excluded,
        status,
        auditQuestionList,
        questionCount,
        maxScore,
      ];

  AuditSection copyWith({
    String? id,
    String? name,
    int? order,
    bool? excluded,
    int? questionCount,
    double? maxScore,
    AuditSectionStatus? status,
    List<AuditQuestion>? auditQuestionList,
  }) {
    return AuditSection(
      id: id ?? this.id,
      name: name ?? this.name,
      order: order ?? this.order,
      excluded: excluded ?? this.excluded,
      questionCount: questionCount ?? this.questionCount,
      maxScore: maxScore ?? this.maxScore,
      status: status ?? this.status,
      auditQuestionList: auditQuestionList ?? this.auditQuestionList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'order': order,
      'excluded': excluded,
      'questionCount': questionCount,
      'maxScore': maxScore,
      'auditQuestionList': auditQuestionList.map((x) => x.toMap()).toList(),
    };
  }

  factory AuditSection.fromMap(Map<String, dynamic> map) {
    return AuditSection(
      id: map['id'] as String,
      name: map['name'] as String,
      order: map['order'] as int,
      excluded: map['excluded'] as bool,
      questionCount: map['questionCount'] ?? 0,
      maxScore: map['maxScore'] ?? 0,
      status: AuditSectionStatus.done,
      auditQuestionList: [],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuditSection.fromJson(String source) =>
      AuditSection.fromMap(json.decode(source) as Map<String, dynamic>);
}
