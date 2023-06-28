import '/common_libraries.dart';

class ActionItemCreate extends Equatable {
  final String? id;
  final String task;
  final String dueBy;
  final String assigneeId;
  final String categoryId;
  final String companyId;
  final String projectId;
  final String location;
  final String notes;
  const ActionItemCreate({
    this.id,
    required this.task,
    required this.dueBy,
    required this.assigneeId,
    required this.categoryId,
    required this.companyId,
    required this.projectId,
    required this.location,
    required this.notes,
  });

  @override
  List<Object?> get props => [
        task,
        dueBy,
        assigneeId,
        categoryId,
        companyId,
        projectId,
        location,
        notes,
      ];

  ActionItemCreate copyWith({
    String? id,
    String? task,
    String? dueBy,
    String? assigneeId,
    String? categoryId,
    String? companyId,
    String? projectId,
    String? location,
    String? notes,
  }) {
    return ActionItemCreate(
      id: id ?? this.id,
      task: task ?? this.task,
      dueBy: dueBy ?? this.dueBy,
      assigneeId: assigneeId ?? this.assigneeId,
      categoryId: categoryId ?? this.categoryId,
      companyId: companyId ?? this.companyId,
      projectId: projectId ?? this.projectId,
      location: location ?? this.location,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'description': task,
      'dueBy': dueBy,
      'assigneeId': assigneeId,
      'awarenessCategoryId': categoryId,
      'companyId': companyId,
      'projectId': projectId,
      'area': location,
      'notes': notes,
    };

    if (id != null) {
      map.addEntries([MapEntry('id', id)]);
    }

    return map;
  }

  String toJson() => json.encode(toMap());
}
