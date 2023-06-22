import '/common_libraries.dart';

class ActionItemCreate extends Equatable {
  final String task;
  final String dueBy;
  final String assigneeId;
  final String categoryId;
  final String companyId;
  final String projectId;
  final String location;
  final String notes;
  const ActionItemCreate({
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
    return <String, dynamic>{
      'task': task,
      'dueBy': dueBy,
      'assigneeId': assigneeId,
      'categoryId': categoryId,
      'companyId': companyId,
      'projectId': projectId,
      'location': location,
      'notes': notes,
    };
  }

  String toJson() => json.encode(toMap());
}
