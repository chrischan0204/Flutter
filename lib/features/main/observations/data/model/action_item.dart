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
  final String task;
  final DateTime due;
  final String assignee;
  final String category;
  final String company;
  final String project;
  final String location;
  final String notes;
  final ActionItemStatus status;
  const ActionItem({
    required this.id,
    required this.task,
    required this.due,
    required this.assignee,
    required this.category,
    required this.company,
    required this.project,
    required this.location,
    required this.notes,
    required this.status,
  });

  String get formatedDue => DateFormat('yyyy-MM-dd').format(due);

  @override
  List<Object?> get props => [
        id,
        task,
        due,
        assignee,
        category,
        company,
        project,
        location,
        notes,
        status,
      ];
}
