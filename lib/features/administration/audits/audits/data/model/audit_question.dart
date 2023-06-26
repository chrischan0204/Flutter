// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
  final double questionScore;
  final double maxScore;
  final String question;
  final String responseScaleName;
  final int questionStatus;
  final int questionOrder;
  final bool questionIncluded;

  const AuditQuestion({
    required this.id,
    required this.questionScore,
    this.maxScore = 0,
    required this.question,
    required this.responseScaleName,
    required this.questionStatus,
    this.questionOrder = 0,
    this.questionIncluded = true,
  });

  @override
  List<Object?> get props => [
        id,
        questionScore,
        question,
        maxScore,
        responseScaleName,
        questionStatus,
        questionOrder,
        questionIncluded,
      ];

  AuditQuestion copyWith({
    String? id,
    double? questionScore,
    double? maxScore,
    String? question,
    String? responseScaleName,
    int? questionStatus,
    int? questionOrder,
    bool? questionIncluded,
  }) {
    return AuditQuestion(
      id: id ?? this.id,
      questionScore: questionScore ?? this.questionScore,
      maxScore: maxScore ?? this.maxScore,
      question: question ?? this.question,
      responseScaleName: responseScaleName ?? this.responseScaleName,
      questionStatus: questionStatus ?? this.questionStatus,
      questionOrder: questionOrder ?? this.questionOrder,
      questionIncluded: questionIncluded ?? this.questionIncluded,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'questionScore': questionScore,
      'maxScore': maxScore,
      'question': question,
      'responseScaleName': responseScaleName,
      'questionStatus': questionStatus,
      'questionOrder': questionOrder,
      'questionExcluded': questionIncluded,
    };
  }

  factory AuditQuestion.fromMap(Map<String, dynamic> map) {
    return AuditQuestion(
      id: map['id'] as String,
      questionScore: map['questionScore'] as double,
      maxScore: map['maxScore'] as double,
      question: map['question'] as String,
      responseScaleName: map['responseScaleName'] as String,
      questionStatus: map['questionStatus'] as int,
      questionOrder: map['questionOrder'] as int,
      questionIncluded: !(map['questionExcluded'] as bool),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuditQuestion.fromJson(String source) =>
      AuditQuestion.fromMap(json.decode(source) as Map<String, dynamic>);
}
