import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuditTemplate extends Equatable {
  final String id;
  final String name;
  final String createdBy;
  final String lastRevisedOn;
  final String templateDescription;
  final bool assigned;
  const AuditTemplate({
    required this.id,
    required this.name,
    required this.createdBy,
    this.assigned = false,
    required this.templateDescription,
    required this.lastRevisedOn,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        createdBy,
        lastRevisedOn,
        templateDescription,
        assigned,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'createdBy': createdBy,
      'lastRevisedOn': lastRevisedOn,
    };
  }

  Map<String, dynamic> toTableDetailMap() {
    return <String, dynamic>{
      'Template Name': name,
      'Created By': createdBy,
      'Last Revised on': lastRevisedOn,
    };
  }

  factory AuditTemplate.fromMap(Map<String, dynamic> map) {
    return AuditTemplate(
      id: map['id'] as String,
      name: map['name'] as String,
      createdBy: map['createdBy'] as String,
      lastRevisedOn: map['lastRevisedOn'] as String,
      templateDescription: map['templateDescription'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuditTemplate.fromJson(String source) =>
      AuditTemplate.fromMap(json.decode(source) as Map<String, dynamic>);

  AuditTemplate copyWith({
    String? id,
    String? name,
    String? createdBy,
    String? lastRevisedOn,
    String? templateDescription,
    bool? assigned,
  }) {
    return AuditTemplate(
      id: id ?? this.id,
      name: name ?? this.name,
      createdBy: createdBy ?? this.createdBy,
      lastRevisedOn: lastRevisedOn ?? this.lastRevisedOn,
      templateDescription: templateDescription ?? this.templateDescription,
      assigned: assigned ?? this.assigned,
    );
  }
}
