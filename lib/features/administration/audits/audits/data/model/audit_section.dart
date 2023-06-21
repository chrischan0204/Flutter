// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final int questionCount;
  final double maxScore;
  final AuditSectionStatus status;
  final List<AuditQuestion> auditQuestionList;

  const AuditSection({
    required this.id,
    required this.name,
    required this.status,
    required this.questionCount,
    required this.maxScore,
    this.auditQuestionList = const [],
  });

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        auditQuestionList,
        questionCount,
        maxScore,
      ];

  AuditSection copyWith({
    String? id,
    String? name,
    int? questionCount,
    double? maxScore,
    AuditSectionStatus? status,
    List<AuditQuestion>? auditQuestionList,
  }) {
    return AuditSection(
      id: id ?? this.id,
      name: name ?? this.name,
      questionCount: questionCount ?? this.questionCount,
      maxScore: maxScore ?? this.maxScore,
      status: status ?? this.status,
      auditQuestionList: auditQuestionList ?? this.auditQuestionList,
    );
  }
}
