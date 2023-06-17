import '/common_libraries.dart';

class TemplateQuestion extends Equatable {
  final String id;
  final String title;
  final String scaleName;
  final double questionScorePoint;
  final double questionScore;
  final double maxScore;
  final List<TemplateResponseScaleItem> responseScaleItems;

  const TemplateQuestion({
    required this.id,
    required this.title,
    required this.scaleName,
    required this.questionScorePoint,
    required this.questionScore,
    required this.maxScore,
    required this.responseScaleItems,
  });
  @override
  List<Object?> get props => [
        id,
        title,
        scaleName,
        questionScorePoint,
        questionScore,
        maxScore,
      ];

  TemplateQuestion copyWith({
    String? id,
    String? title,
    String? scaleName,
    double? questionScorePoint,
    double? questionScore,
    double? maxScore,
    List<TemplateResponseScaleItem>? responseScaleItems,
  }) {
    return TemplateQuestion(
      id: id ?? this.id,
      title: title ?? this.title,
      scaleName: scaleName ?? this.scaleName,
      questionScorePoint: questionScorePoint ?? this.questionScorePoint,
      questionScore: questionScore ?? this.questionScore,
      maxScore: maxScore ?? this.maxScore,
      responseScaleItems: responseScaleItems ?? this.responseScaleItems,
    );
  }

  factory TemplateQuestion.fromMap(Map<String, dynamic> map) {
    return TemplateQuestion(
      id: map['id'] as String,
      title: map['title'] ?? '',
      scaleName: map['scaleName'] ?? '',
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
}
