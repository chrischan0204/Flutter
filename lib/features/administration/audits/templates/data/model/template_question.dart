import '/common_libraries.dart';

class TemplateQuestion extends Equatable {
  final String id;
  final String questionId;
  final String title;
  final String scaleName;
  final String responseScaleId;
  final double questionScorePoint;
  final double questionScore;
  final double maxScore;
  final List<TemplateResponseScaleItem> responseScaleItems;

  final bool isOpen;

  const TemplateQuestion({
    required this.id,
    required this.questionId,
    required this.title,
    required this.scaleName,
    required this.responseScaleId,
    required this.questionScorePoint,
    required this.questionScore,
    required this.maxScore,
    required this.responseScaleItems,
    this.isOpen = false,
  });
  @override
  List<Object?> get props => [
        id,
        questionId,
        title,
        scaleName,
        questionScorePoint,
        questionScore,
        maxScore,
        responseScaleItems,
        isOpen,
      ];

  factory TemplateQuestion.fromMap(Map<String, dynamic> map) {
    return TemplateQuestion(
      id: map['id'] as String,
      questionId: map['questionId'] ?? '',
      title: map['title'] ?? '',
      scaleName: map['scaleName'] ?? '',
      responseScaleId: map['responseScaleId'],
      questionScorePoint: map['questionScorePoint'] as double,
      questionScore: map['questionScore'] as double,
      maxScore: map['maxScore'] as double,
      responseScaleItems: List.from(
        (map['responseScaleItems'])
            .map((x) => TemplateResponseScaleItem.fromMap(x)),
      ),
    );
  }

  factory TemplateQuestion.fromJson(String source) =>
      TemplateQuestion.fromMap(json.decode(source) as Map<String, dynamic>);

  TemplateQuestion copyWith({
    String? id,
    String? questionId,
    String? title,
    String? scaleName,
    String? responseScaleId,
    double? questionScorePoint,
    double? questionScore,
    double? maxScore,
    List<TemplateResponseScaleItem>? responseScaleItems,
    bool? isOpen,
  }) {
    return TemplateQuestion(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      title: title ?? this.title,
      scaleName: scaleName ?? this.scaleName,
      responseScaleId: responseScaleId ?? this.responseScaleId,
      questionScorePoint: questionScorePoint ?? this.questionScorePoint,
      questionScore: questionScore ?? this.questionScore,
      maxScore: maxScore ?? this.maxScore,
      responseScaleItems: responseScaleItems ?? this.responseScaleItems,
      isOpen: isOpen ?? this.isOpen,
    );
  }
}
