import 'dart:convert';

import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final String id;
  final String name;
  final String responseScaleId;
  final String order;
  const Question({
    required this.id,
    required this.name,
    required this.responseScaleId,
    required this.order,
  });
  @override
  List<Object?> get props => [
        id,
        name,
        responseScaleId,
        order,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'responseScaleId': responseScaleId,
      'order': order,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] as String,
      name: map['name'] as String,
      responseScaleId: map['responseScaleId'] as String,
      order: map['order'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);

  Question copyWith({
    String? id,
    String? name,
    String? responseScaleId,
    String? order,
  }) {
    return Question(
      id: id ?? this.id,
      name: name ?? this.name,
      responseScaleId: responseScaleId ?? this.responseScaleId,
      order: order ?? this.order,
    );
  }
}
