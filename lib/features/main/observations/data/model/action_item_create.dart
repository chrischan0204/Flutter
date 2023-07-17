// ignore_for_file: public_member_api_docs, sort_constructors_first
import '/common_libraries.dart';

class ActionItemCreate extends Equatable {
  final String? id;
  final String name;
  final String dueBy;
  final String assigneeId;
  final String? siteId;
  final String? categoryId;
  final String? companyId;
  final String? projectId;
  final String location;
  final String notes;
  final String? observationId;
  final String? auditSectionItemId;
  final String? auditId;
  const ActionItemCreate({
    this.id,
    required this.name,
    required this.dueBy,
    required this.assigneeId,
    this.categoryId,
    this.companyId,
    this.projectId,
    this.siteId,
    required this.location,
    required this.notes,
    this.observationId,
    this.auditSectionItemId,
    this.auditId,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        dueBy,
        assigneeId,
        siteId,
        categoryId,
        companyId,
        projectId,
        location,
        notes,
        observationId,
        auditSectionItemId,
        auditId,
      ];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'description': name,
      'dueBy': dueBy,
      'assigneeId': assigneeId,
      'siteId': siteId,
      'awarenessCategoryId': categoryId,
      'companyId': companyId,
      'projectId': projectId,
      'area': location,
      'notes': notes,
    };

    if (id != null) {
      map.addEntries([MapEntry('id', id)]);
    }

    if (observationId != null) {
      map.addEntries([MapEntry('observationId', observationId)]);
    }

    if (auditSectionItemId != null) {
      map.addEntries([MapEntry('auditSectionItemId', auditSectionItemId)]);
    }

    if (auditId != null) {
      map.addAll({'auditId': auditId});
    }

    return map;
  }

  String toJson() => json.encode(toMap());

  ActionItemCreate copyWith({
    String? id,
    String? name,
    String? dueBy,
    String? assigneeId,
    String? siteId,
    String? categoryId,
    String? companyId,
    String? projectId,
    String? location,
    String? notes,
    String? observationId,
    String? auditSectionItemId,
  }) {
    return ActionItemCreate(
      id: id ?? this.id,
      name: name ?? this.name,
      dueBy: dueBy ?? this.dueBy,
      assigneeId: assigneeId ?? this.assigneeId,
      siteId: siteId ?? this.siteId,
      categoryId: categoryId ?? this.categoryId,
      companyId: companyId ?? this.companyId,
      projectId: projectId ?? this.projectId,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      observationId: observationId ?? this.observationId,
      auditSectionItemId: auditSectionItemId ?? this.auditSectionItemId,
    );
  }
}
