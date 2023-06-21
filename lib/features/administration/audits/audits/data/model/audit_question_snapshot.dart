import '/common_libraries.dart';

class AuditQuestionSnapshot extends Equatable {
  final String section;
  final int totalQuestionCount;
  final int includedQuestionCount;
  final double maxScore;
  final double includedScore;
  const AuditQuestionSnapshot({
    required this.section,
    required this.totalQuestionCount,
    required this.includedQuestionCount,
    required this.maxScore,
    required this.includedScore,
  });

  AuditQuestionSnapshot copyWith({
    String? section,
    int? totalQuestionCount,
    int? includedQuestionCount,
    double? maxScore,
    double? includedScore,
  }) {
    return AuditQuestionSnapshot(
      section: section ?? this.section,
      totalQuestionCount: totalQuestionCount ?? this.totalQuestionCount,
      includedQuestionCount:
          includedQuestionCount ?? this.includedQuestionCount,
      maxScore: maxScore ?? this.maxScore,
      includedScore: includedScore ?? this.includedScore,
    );
  }

  @override
  List<Object?> get props => [
        section,
        totalQuestionCount,
        includedQuestionCount,
        maxScore,
        includedScore,
      ];
}
