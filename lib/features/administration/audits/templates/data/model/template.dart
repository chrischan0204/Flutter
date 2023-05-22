import 'dart:convert';

import '/common_libraries.dart';

class Template extends Entity {
  final String revisionDate;
  final bool usedInAudit;
  final bool usedInInspection;
  final bool locked;
  final int usedInAudits;
  final int usedInSites;
  final String templateSites;

  const Template({
    super.id,
    super.name,
    this.revisionDate = '',
    this.usedInAudit = false,
    this.usedInInspection = false,
    this.locked = false,
    this.usedInAudits = 0,
    this.usedInSites = 0,
    this.templateSites = '',
    super.active,
    super.createdByUserName,
    super.createdOn,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        revisionDate,
        usedInAudit,
        usedInInspection,
        locked,
        usedInAudits,
        usedInSites,
        templateSites,
      ];

  @override
  Map<String, dynamic> tableItemsToMap() {
    return {
      'Template Name': name,
      'Used in Audits': usedInAudits,
      'Audit': usedInAudit,
      'Inspection': usedInInspection,
      'Created at': createdOn,
      'Created by': createdByUserName,
    };
  }

  @override
  Map<String, dynamic> sideDetailItemsToMap() {
    return {
      'Audits': usedInAudit,
      'Inspection': usedInInspection,
      'Active': active,
      'Used at sites': usedInSites,
      'Used in audits': usedInAudits,
      'Created on': createdOn,
      'Created by': createdByUserName,
      'Sites using this template': {'content': templateSites},
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'revisionDate': revisionDate,
      'name': name,
      'usedInInspection': usedInInspection,
      'usedInAudit': usedInAudit,
    };
  }

  factory Template.fromMap(Map<String, dynamic> map) {
    Entity entity = Entity.fromMap(map);
    return Template(
      id: entity.id,
      name: entity.name,
      revisionDate: map['revisionDate'] ?? '',
      usedInAudit: map['usedInAudit'] ?? false,
      usedInInspection: map['usedInInspection'] ?? false,
      locked: map['locked'] ?? false,
      usedInAudits: map['usedInAudits'] ?? 0,
      usedInSites: map['usedInSites'] ?? 0,
      templateSites: map['templateSites'] ?? '',
      active: entity.active,
      createdByUserName: entity.createdByUserName,
      createdOn: entity.createdOn,
    );
  }

  @override
  Map<String, dynamic> detailItemsToMap() {
    return {
      'Template Description': name,
      'Revision Date': revisionDate,
      'Used in audits?': usedInAudit,
      'Used in inspections?': usedInInspection,
    };
  }

  String toJson() => json.encode(toMap());

  factory Template.fromJson(String source) =>
      Template.fromMap(json.decode(source) as Map<String, dynamic>);

  Template copyWith({
    String? id,
    String? name,
    String? revisionDate,
    bool? usedInAudit,
    bool? usedInInspection,
    bool? locked,
    int? usedInAudits,
    bool? active,
    String? createdOn,
    String? createdByUserName,
  }) {
    return Template(
      id: id ?? this.id,
      name: name ?? this.name,
      revisionDate: revisionDate ?? this.revisionDate,
      usedInAudit: usedInAudit ?? this.usedInAudit,
      usedInInspection: usedInInspection ?? this.usedInInspection,
      locked: locked ?? this.locked,
      usedInAudits: usedInAudits ?? this.usedInAudits,
      active: active ?? this.active,
      createdOn: createdOn ?? this.createdOn,
      createdByUserName: createdByUserName ?? this.createdByUserName,
    );
  }
}
