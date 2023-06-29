import '/common_libraries.dart';

class AuditSectionAndQuestion extends Equatable {
  final String auditId;
  final String auditSectionId;
  final String auditSectionName;
  final int order;
  final int questions;
  final double maxScore;
  final int excludedQuestions;
  final int unAnsweredQuestions;
  final int answeredQuestions;
  final int skippedQuestions;
  final String sectionStatus;
  final List<AuditQuestion> auditQuestions;

  const AuditSectionAndQuestion({
    required this.auditId,
    required this.auditSectionId,
    required this.auditSectionName,
    required this.order,
    required this.questions,
    required this.maxScore,
    required this.excludedQuestions,
    required this.unAnsweredQuestions,
    required this.answeredQuestions,
    required this.skippedQuestions,
    required this.sectionStatus,
    required this.auditQuestions,
  });

  @override
  List<Object?> get props => [
        auditId,
        auditSectionId,
        auditSectionName,
        order,
        questions,
        maxScore,
        excludedQuestions,
        unAnsweredQuestions,
        answeredQuestions,
        skippedQuestions,
        sectionStatus,
        auditQuestions,
      ];

  AuditSectionAndQuestion copyWith({
    String? auditId,
    String? auditSectionId,
    String? auditSectionName,
    int? order,
    int? questions,
    double? maxScore,
    int? excludedQuestions,
    int? unAnsweredQuestions,
    int? answeredQuestions,
    int? skippedQuestions,
    String? sectionStatus,
    List<AuditQuestion>? auditQuestions,
  }) {
    return AuditSectionAndQuestion(
      auditId: auditId ?? this.auditId,
      auditSectionId: auditSectionId ?? this.auditSectionId,
      auditSectionName: auditSectionName ?? this.auditSectionName,
      order: order ?? this.order,
      questions: questions ?? this.questions,
      maxScore: maxScore ?? this.maxScore,
      excludedQuestions: excludedQuestions ?? this.excludedQuestions,
      unAnsweredQuestions: unAnsweredQuestions ?? this.unAnsweredQuestions,
      answeredQuestions: answeredQuestions ?? this.answeredQuestions,
      skippedQuestions: skippedQuestions ?? this.skippedQuestions,
      sectionStatus: sectionStatus ?? this.sectionStatus,
      auditQuestions: auditQuestions ?? this.auditQuestions,
    );
  }

  factory AuditSectionAndQuestion.fromMap(Map<String, dynamic> map) {
    return AuditSectionAndQuestion(
      auditId: map['auditId'] as String,
      auditSectionId: map['auditSectionId'] as String,
      auditSectionName: map['auditSectionName'] as String,
      order: map['order'] as int,
      questions: map['questions'] as int,
      maxScore: map['maxscore'] as double,
      excludedQuestions: map['excludedQuestions'] as int,
      unAnsweredQuestions: map['unAnsweredQuestions'] as int,
      answeredQuestions: map['answeredQuestions'] as int,
      skippedQuestions: map['skippedQuestions'] as int,
      sectionStatus: map['sectionStatus'] as String,
      auditQuestions: List<AuditQuestion>.from(
        (map['auditQuestions']).map<AuditQuestion>(
          (x) => AuditQuestion.fromMap(x),
        ),
      ),
    );
  }

  factory AuditSectionAndQuestion.fromJson(String source) =>
      AuditSectionAndQuestion.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
