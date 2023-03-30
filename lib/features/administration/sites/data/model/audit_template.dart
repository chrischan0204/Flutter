import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AuditTemplate {
  final String name;
  final String createdBy;
  final String lastRevisedOn;
  AuditTemplate({
    required this.name,
    required this.createdBy,
    required this.lastRevisedOn,
  });

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
      name: map['name'] as String,
      createdBy: map['createdBy'] as String,
      lastRevisedOn: map['lastRevisedOn'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuditTemplate.fromJson(String source) =>
      AuditTemplate.fromMap(json.decode(source) as Map<String, dynamic>);
}
