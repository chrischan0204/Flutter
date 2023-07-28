import 'package:intl/intl.dart';

import '/common_libraries.dart';

class AuditActionItem extends Equatable {
  final String id;
  final String? description;
  final DateTime dueBy;
  final String? assigneeName;
  final String? awarenessCategoryName;
  final String? companyName;
  final String? projectName;
  final String? observationName;
  final String? area;
  final bool isClosed;
  final String? closedByUserName;
  final DateTime? closedOn;
  final String? status;
  final String? source;
  final String? notes;
  final String? createdBy;
  const AuditActionItem({
    required this.id,
    this.description,
    required this.dueBy,
    this.assigneeName,
    this.awarenessCategoryName,
    this.companyName,
    this.projectName,
    this.observationName,
    this.area,
    required this.isClosed,
    this.closedByUserName,
    this.closedOn,
    this.status,
    this.source,
    this.notes,
    this.createdBy,
  });

  @override
  List<Object?> get props {
    return [
      id,
      description,
      dueBy,
      assigneeName,
      awarenessCategoryName,
      companyName,
      projectName,
      observationName,
      area,
      isClosed,
      closedByUserName,
      closedOn,
      status,
      source,
      notes,
      createdBy,
    ];
  }

  String get formatedDueBy => DateFormat('MM/d/yyyy').format(dueBy);

  AuditActionItem copyWith({
    String? id,
    String? description,
    DateTime? dueBy,
    String? assigneeName,
    String? awarenessCategoryName,
    String? companyName,
    String? projectName,
    String? observationName,
    String? area,
    bool? isClosed,
    String? closedByUserName,
    DateTime? closedOn,
    String? status,
    String? source,
    String? notes,
    String? createdBy,
  }) {
    return AuditActionItem(
      id: id ?? this.id,
      description: description ?? this.description,
      dueBy: dueBy ?? this.dueBy,
      assigneeName: assigneeName ?? this.assigneeName,
      awarenessCategoryName:
          awarenessCategoryName ?? this.awarenessCategoryName,
      companyName: companyName ?? this.companyName,
      projectName: projectName ?? this.projectName,
      observationName: observationName ?? this.observationName,
      area: area ?? this.area,
      isClosed: isClosed ?? this.isClosed,
      closedByUserName: closedByUserName ?? this.closedByUserName,
      closedOn: closedOn ?? this.closedOn,
      status: status ?? this.status,
      source: source ?? this.source,
      notes: notes ?? this.notes,
      createdBy: createdBy ?? this.createdBy,
    );
  }

  factory AuditActionItem.fromMap(Map<String, dynamic> map) {
    return AuditActionItem(
      id: map['id'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      dueBy: DateTime.parse(map['dueBy']),
      assigneeName:
          map['assigneeName'] != null ? map['assigneeName'] as String : null,
      awarenessCategoryName: map['awarenessCategoryName'] != null
          ? map['awarenessCategoryName'] as String
          : null,
      companyName:
          map['companyName'] != null ? map['companyName'] as String : null,
      projectName:
          map['projectName'] != null ? map['projectName'] as String : null,
      observationName: map['observationName'] != null
          ? map['observationName'] as String
          : null,
      area: map['area'] != null ? map['area'] as String : null,
      isClosed: map['isClosed'] as bool,
      closedByUserName: map['closedByUserName'] != null
          ? map['closedByUserName'] as String
          : null,
      closedOn:
          map['closedOn'] != null ? DateTime.parse(map['closedOn']) : null,
      status: map['status'] != null ? map['status'] as String : null,
      source: map['source'] != null ? map['source'] as String : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
      createdBy: map['createdBy'] != null ? map['createdBy'] as String : null,
    );
  }

  factory AuditActionItem.fromJson(String source) =>
      AuditActionItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
