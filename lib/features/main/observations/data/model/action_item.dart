import 'package:intl/intl.dart';

import 'package:safety_eta/common_libraries.dart';

enum ActionItemStatus {
  closed,
  open;

  bool get isClosed => this == closed;
  bool get isOpen => this == open;

  @override
  String toString() {
    return isClosed ? 'Close' : 'Open';
  }
}

class ActionItem extends Entity {
  final DateTime dueBy;
  final String observationId;
  final String observationName;
  final String assigneeId;
  final String assigneeName;
  final String awarenessCategoryId;
  final String awarenessCategoryName;
  final String companyId;
  final String companyName;
  final String projectId;
  final String projectName;
  final String area;
  final String notes;
  const ActionItem({
    super.id,
    super.name,
    required this.dueBy,
    this.assigneeId = '',
    this.assigneeName = '',
    this.awarenessCategoryId = '',
    this.awarenessCategoryName = '',
    this.companyId = '',
    this.companyName = '',
    this.projectId = '',
    this.projectName = '',
    this.observationId = '',
    this.observationName = '',
    this.area = '',
    this.notes = '',
    super.createdByUserName,
  });

  String get formatedDue => DateFormat('yyyy-MM-dd').format(dueBy);

  @override
  List<Object?> get props => [
        ...super.props,
        dueBy,
        assigneeId,
        awarenessCategoryId,
        companyId,
        projectName,
        area,
        notes,
      ];

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': name,
      'dueBy': dueBy.millisecondsSinceEpoch,
      'observationId': observationId,
      'observationName': observationName,
      'assigneeId': assigneeId,
      'assigneeName': assigneeName,
      'awarenessCategoryId': awarenessCategoryId,
      'awarenessCategoryName': awarenessCategoryName,
      'companyId': companyId,
      'companyName': companyName,
      'projectId': projectId,
      'projectName': projectName,
      'area': area,
      'notes': notes,
    };
  }

  @override
  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{
      'Status': '',
      'Source': '',
      'Created By': createdByUserName,
      'Assignee': assigneeName,
      'Category': awarenessCategoryName,
      'Site': '',
      'Project': projectName,
    };
  }

  @override
  Map<String, dynamic> sideDetailItemsToMap() {
    return {
      'Item': name,
      'Due': formatedDue,
      'Assignee': assigneeName,
      'Site': '',
      'Parent': '',
      'Category': awarenessCategoryName,
      'Company': companyName,
      'Project': projectName,
      'Location': area,
      'Notes': {'content': notes},
    };
  }

  factory ActionItem.fromMap(Map<String, dynamic> map) {
    Entity entity = Entity.fromMap(map);
    return ActionItem(
      id: entity.id,
      name: map['description'] ?? '',
      dueBy: DateTime.parse(map['dueBy']),
      observationId: map['observationId'] ?? '',
      observationName: map['observationName'] ?? '',
      assigneeId: map['assigneeId'] ?? '',
      assigneeName: map['assigneeName'] ?? '',
      awarenessCategoryId: map['awarenessCategoryId'] ?? '',
      awarenessCategoryName: map['awarenessCategoryName'] ?? '',
      companyId: map['companyId'] ?? '',
      companyName: map['companyName'] ?? '',
      projectId: map['projectId'] ?? '',
      projectName: map['projectName'] ?? '',
      area: map['area'] ?? '',
      notes: map['notes'] ?? '',
      createdByUserName: entity.createdByUserName,
    );
  }

  String toJson() => json.encode(toMap());

  factory ActionItem.fromJson(String source) =>
      ActionItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
