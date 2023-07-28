import '/common_libraries.dart';

class Template extends Entity {
  final String revisionDate;
  final bool locked;
  final int usedInAudits;
  final int usedInSites;
  final String templateSites;

  /// assigned or not
  final bool assigned;

  const Template({
    super.id,
    super.name,
    this.revisionDate = '',
    this.locked = false,
    this.usedInAudits = 0,
    this.usedInSites = 0,
    this.templateSites = '',
    this.assigned = false,
    super.active,
    super.createdByUserName,
    super.createdOn,
    super.columns,
    super.deleted,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        revisionDate,
        locked,
        usedInAudits,
        usedInSites,
        templateSites,
        assigned,
      ];

  String get formatedRevisionDate => revisionDate.isNotEmpty
      ? FormatDate(format: 'MM/d/yyyy', dateString: revisionDate).formatDate
      : '--';

  @override
  Map<String, dynamic> tableItemsToMap() {
    return {
      'Name': name,
      'Revision Date': revisionDate,
      'Created On': createdOn,
      'Created By': createdByUserName,
    };
  }

  @override
  Map<String, dynamic> sideDetailItemsToMap() {
    return {
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
    Map<String, dynamic> map = {
      'revisionDate': revisionDate,
      'name': name,
    };
    if (id != null) {
      map.addEntries([MapEntry('id', id)]);
    }
    return map;
  }

  factory Template.fromMap(Map<String, dynamic> map) {
    Entity entity = Entity.fromMap(map);
    return Template(
      id: entity.id,
      name: entity.name,
      revisionDate: map['revisionDate'] ?? '',
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
    bool? deleted,
    List<String>? columns,
    bool? assigned,
  }) {
    return Template(
      id: id ?? this.id,
      name: name ?? this.name,
      revisionDate: revisionDate ?? this.revisionDate,
      locked: locked ?? this.locked,
      usedInAudits: usedInAudits ?? this.usedInAudits,
      active: active ?? this.active,
      createdOn: createdOn ?? this.createdOn,
      createdByUserName: createdByUserName ?? this.createdByUserName,
      deleted: deleted ?? this.deleted,
      columns: columns ?? this.columns,
      assigned: assigned ?? this.assigned,
    );
  }
}
