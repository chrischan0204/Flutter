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
  final String questionStatusName;
  final int questionOrder;
  final bool questionIncluded;
  final List<AuditResponseScaleItem> responseScaleItems;
  final bool isNew;

  const AuditQuestion({
    required this.id,
    required this.questionScore,
    this.maxScore = 0,
    required this.question,
    required this.responseScaleName,
    required this.questionStatus,
    this.questionStatusName = '',
    this.questionOrder = 0,
    this.questionIncluded = true,
    this.isNew = false,
    this.responseScaleItems = const [],
  });

  @override
  List<Object?> get props => [
        id,
        questionScore,
        question,
        maxScore,
        responseScaleName,
        questionStatus,
        questionStatusName,
        questionOrder,
        questionIncluded,
        responseScaleItems,
        isNew,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'questionScore': questionScore,
      'maxScore': maxScore,
      'question': question,
      'responseScaleName': responseScaleName,
      'questionStatus': questionStatus,
      'questionOrder': questionOrder,
      'questionIncluded': questionIncluded,
    };
  }

  factory AuditQuestion.fromMap(Map<String, dynamic> map) {
    return AuditQuestion(
        id: map['id'] as String,
        questionScore: map['questionScore'] as double,
        maxScore: map['maxScore'] as double,
        question: map['question'] ?? '',
        responseScaleName: map['responseScaleName'] ?? '',
        questionStatusName: map['questionStatusName'] ?? '',
        questionStatus: map['questionStatus'] ?? 0,
        questionOrder: map['questionOrder'] as int,
        questionIncluded: map['questionIncluded'],
        responseScaleItems: map['responseScaleItems'] == null
            ? []
            : List.from(map['responseScaleItems'])
                .map((e) => AuditResponseScaleItem.fromMap(e))
                .toList());
  }

  String toJson() => json.encode(toMap());

  factory AuditQuestion.fromJson(String source) =>
      AuditQuestion.fromMap(json.decode(source) as Map<String, dynamic>);

  AuditQuestion copyWith({
    String? id,
    double? questionScore,
    double? maxScore,
    String? question,
    String? responseScaleName,
    int? questionStatus,
    int? questionOrder,
    bool? questionIncluded,
    List<AuditResponseScaleItem>? responseScaleItems,
    bool? isNew,
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
      responseScaleItems: responseScaleItems ?? this.responseScaleItems,
      isNew: isNew ?? this.isNew,
    );
  }
}
