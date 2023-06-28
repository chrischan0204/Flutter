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

class ActionItem extends Equatable {
  final String id;
  final String description;
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
    required this.id,
    required this.description,
    required this.dueBy,
    required this.assigneeId,
    required this.assigneeName,
    required this.awarenessCategoryId,
    required this.awarenessCategoryName,
    required this.companyId,
    required this.companyName,
    required this.projectId,
    required this.projectName,
    required this.observationId,
    required this.observationName,
    required this.area,
    required this.notes,
  });

  String get formatedDue => DateFormat('yyyy-MM-dd').format(dueBy);

  @override
  List<Object?> get props => [
        id,
        description,
        dueBy,
        assigneeId,
        awarenessCategoryId,
        companyId,
        projectName,
        area,
        notes,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
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

  factory ActionItem.fromMap(Map<String, dynamic> map) {
    return ActionItem(
      id: map['id'] as String,
      description: map['description'] as String,
      dueBy: DateTime.fromMillisecondsSinceEpoch(map['dueBy'] as int),
      observationId: map['observationId'] as String,
      observationName: map['observationName'] as String,
      assigneeId: map['assigneeId'] as String,
      assigneeName: map['assigneeName'] as String,
      awarenessCategoryId: map['awarenessCategoryId'] as String,
      awarenessCategoryName: map['awarenessCategoryName'] as String,
      companyId: map['companyId'] as String,
      companyName: map['companyName'] as String,
      projectId: map['projectId'] as String,
      projectName: map['projectName'] as String,
      area: map['area'] as String,
      notes: map['notes'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ActionItem.fromJson(String source) =>
      ActionItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
