import 'dart:convert';

import 'package:equatable/equatable.dart';

class TemplateSnapshot extends Equatable {
  final String id;
  final String name;
  final int questions;
  final double maxScore;
  const TemplateSnapshot({
    required this.id,
    required this.name,
    required this.questions,
    required this.maxScore,
  });
  @override
  List<Object?> get props => [
        id,
        name,
        questions,
        maxScore,
      ];

  TemplateSnapshot copyWith({
    String? id,
    String? name,
    int? questions,
    double? maxScore,
  }) {
    return TemplateSnapshot(
      id: id ?? this.id,
      name: name ?? this.name,
      questions: questions ?? this.questions,
      maxScore: maxScore ?? this.maxScore,
    );
  }

  factory TemplateSnapshot.fromMap(Map<String, dynamic> map) {
    return TemplateSnapshot(
      id: map['id'] as String,
      name: map['name'] as String,
      questions: map['questions'] as int,
      maxScore: map['maxScore'] as double,
    );
  }

  factory TemplateSnapshot.fromJson(String source) =>
      TemplateSnapshot.fromMap(json.decode(source) as Map<String, dynamic>);
}
