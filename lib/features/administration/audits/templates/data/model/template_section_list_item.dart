import 'dart:convert';

import 'package:equatable/equatable.dart';

class TemplateSectionListItem extends Equatable {
  final String id;
  final String templateId;
  final String name;
  final int templateSectionItemCount;
  const TemplateSectionListItem({
    this.id = '',
    required this.templateId,
    required this.name,
    this.templateSectionItemCount = 0,
  });

  @override
  List<Object?> get props => [
        id,
        templateId,
        name,
        templateSectionItemCount,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'templateId': templateId,
      'name': name,
    };
  }

  factory TemplateSectionListItem.fromMap(Map<String, dynamic> map) {
    return TemplateSectionListItem(
      id: map['id'] as String,
      templateId: map['templateId'] as String,
      name: map['name'] as String,
      templateSectionItemCount: map['templateSectionItemCount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TemplateSectionListItem.fromJson(String source) =>
      TemplateSectionListItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
