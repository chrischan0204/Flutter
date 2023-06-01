import 'dart:convert';

import 'package:equatable/equatable.dart';

class TemplateSectionQuestion extends Equatable {
  final String id;
  final String templateSectionId;
  final String title;
  final String responseScaleId;
  const TemplateSectionQuestion({
    required this.id,
    required this.templateSectionId,
    required this.title,
    required this.responseScaleId,
  });
  @override
  List<Object?> get props => [
        id,
        templateSectionId,
        title,
        responseScaleId,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'templateSectionId': templateSectionId,
      'title': title,
      'responseScaleId': responseScaleId,
    };
  }

  factory TemplateSectionQuestion.fromMap(Map<String, dynamic> map) {
    return TemplateSectionQuestion(
      id: map['id'] as String,
      templateSectionId: map['templateSectionId'] as String,
      title: map['title'] ?? '',
      responseScaleId: map['responseScaleId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TemplateSectionQuestion.fromJson(String source) =>
      TemplateSectionQuestion.fromMap(
          json.decode(source) as Map<String, dynamic>);

  TemplateSectionQuestion copyWith({
    String? id,
    String? templateSectionId,
    String? title,
    String? responseScaleId,
  }) {
    return TemplateSectionQuestion(
      id: id ?? this.id,
      templateSectionId: templateSectionId ?? this.templateSectionId,
      title: title ?? this.title,
      responseScaleId: responseScaleId ?? this.responseScaleId,
    );
  }
}
