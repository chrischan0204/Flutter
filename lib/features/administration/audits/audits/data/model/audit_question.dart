import '/common_libraries.dart';

class AuditQuestion extends Equatable {
  final int no;
  final double score;
  final String question;
  final String scale;
  final bool answered;
  const AuditQuestion({
    required this.no,
    required this.score,
    required this.question,
    required this.scale,
    required this.answered,
  });
  @override
  List<Object?> get props => [
        no,
        score,
        question,
        scale,
        answered,
      ];

  AuditQuestion copyWith({
    int? no,
    double? score,
    String? question,
    String? scale,
    bool? answered,
  }) {
    return AuditQuestion(
      no: no ?? this.no,
      score: score ?? this.score,
      question: question ?? this.question,
      scale: scale ?? this.scale,
      answered: answered ?? this.answered,
    );
  }
}
