import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'model.dart';

class TemplateSectionItem extends Equatable {
  final String id;
  final String templateSectionId;
  final int itemTypeId;
  final String responseScaleId;
  final String parentId;
  final Question question;
  final ResponseScaleItem response;
  final List<dynamic> children;

  const TemplateSectionItem({
    required this.id,
    required this.templateSectionId,
    required this.itemTypeId,
    required this.responseScaleId,
    required this.parentId,
    required this.question,
    required this.response,
    required this.children,
  });

  @override
  List<Object?> get props => [
        id,
        templateSectionId,
        itemTypeId,
        responseScaleId,
        parentId,
        question,
        response,
        children,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'templateSectionId': templateSectionId,
      'itemTypeId': itemTypeId,
      'responseScaleId': responseScaleId,
      'parentId': parentId,
      'question': question.toMap(),
      'response': response.toMap(),
      'children': children,
    };
  }

  factory TemplateSectionItem.fromMap(Map<String, dynamic> map) {
    return TemplateSectionItem(
      id: map['id'] as String,
      templateSectionId: map['templateSectionId'] as String,
      itemTypeId: map['itemTypeId'],
      responseScaleId: map['responseScaleId'] as String,
      parentId: map['parentId'] as String,
      question: Question.fromMap(map['question'] as Map<String, dynamic>),
      response:
          ResponseScaleItem.fromMap(map['response'] as Map<String, dynamic>),
      children: List.from(json.decode(map['children'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory TemplateSectionItem.fromJson(String source) =>
      TemplateSectionItem.fromMap(json.decode(source) as Map<String, dynamic>);

  TemplateSectionItem copyWith({
    String? id,
    String? templateSectionId,
    int? itemTypeId,
    String? responseScaleId,
    String? parentId,
    Question? question,
    ResponseScaleItem? response,
    List<dynamic>? children,
  }) {
    return TemplateSectionItem(
      id: id ?? this.id,
      templateSectionId: templateSectionId ?? this.templateSectionId,
      itemTypeId: itemTypeId ?? this.itemTypeId,
      responseScaleId: responseScaleId ?? this.responseScaleId,
      parentId: parentId ?? this.parentId,
      question: question ?? this.question,
      response: response ?? this.response,
      children: children ?? this.children,
    );
  }
}
