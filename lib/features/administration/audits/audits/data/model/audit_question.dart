// ignore_for_file: public_member_api_docs, sort_constructors_first
import '/common_libraries.dart';

// enum AuditQuestionStatus {
//   answered,
//   unanswered,
//   excluded;

//   @override
//   String toString() {
//     switch (this) {
//       case AuditQuestionStatus.answered:
//         return 'Answered';
//       case AuditQuestionStatus.unanswered:
//         return 'Unanswered';
//       case AuditQuestionStatus.excluded:
//         return 'Excluded';
//     }
//   }
// }

class AuditQuestion extends Equatable {
  final String id;
  final int no;
  final double score;
  final String question;
  final String scale;
  final bool answered;
  final bool included;
  const AuditQuestion({
    required this.id,
    required this.no,
    required this.score,
    required this.question,
    required this.scale,
    required this.answered,
    this.included = true,
  });
  @override
  List<Object?> get props => [
        id,
        no,
        score,
        question,
        scale,
        answered,
        included,
      ];

  AuditQuestion copyWith({
    String? id,
    int? no,
    double? score,
    String? question,
    String? scale,
    bool? answered,
    bool? included,
  }) {
    return AuditQuestion(
      id: id ?? this.id,
      no: no ?? this.no,
      score: score ?? this.score,
      question: question ?? this.question,
      scale: scale ?? this.scale,
      answered: answered ?? this.answered,
      included: included ?? this.included,
    );
  }
}
