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
  final bool? isClosed;
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
    this.isClosed,
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
        isClosed,
      ];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'description': name,
      'dueBy': dueBy,
      'assigneeId': assigneeId,
      'siteId': siteId,
      'awarenessCategoryId': categoryId?.isNotEmpty == true ? categoryId : null,
      'companyId': companyId?.isNotEmpty == true ? companyId : null,
      'projectId': projectId?.isNotEmpty == true ? projectId : null,
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

    if (isClosed != null) {
      map.addAll({'isClosed': isClosed});
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
    bool? isClosed,
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
      isClosed: isClosed ?? this.isClosed,
      observationId: observationId ?? this.observationId,
      auditSectionItemId: auditSectionItemId ?? this.auditSectionItemId,
    );
  }
}
