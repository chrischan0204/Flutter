import 'package:intl/intl.dart';

import '/common_libraries.dart';

class FilteredActionItem extends FilteredEntity {
  final String status;
  final String source;
  final String assignee;
  final String actionRequired;
  final DateTime? dueOn;
  final DateTime? closedOn;
  final String category;
  final String comments;
  final String company;
  final String location;
  final String project;

  const FilteredActionItem({
    required this.status,
    required this.source,
    required this.assignee,
    required this.actionRequired,
    this.dueOn,
    this.closedOn,
    required this.category,
    required this.comments,
    required this.company,
    required this.location,
    required this.project,
    super.id,
    super.createdBy,
    super.createdById,
    super.createdOn,
    super.lastModifiedByUserName,
    super.lastModifiedOn,
    super.deleted,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        status,
        source,
        assignee,
        actionRequired,
        dueOn,
        createdOn,
        closedOn,
        category,
        comments,
        company,
        location,
        project,
      ];

  ActionItem get actionItem => ActionItem(
        id: id,
        status: status,
        source: source,
        assigneeName: assignee,
        actionRequired: actionRequired,
        dueOn: formatedDueOn,
        closedOn: formatedClosedOn,
        awarenessCategoryName: category,
        comments: comments,
        companyName: company,
        area: location,
        projectName: project,
        createdByUserName: createdBy,
        createdOn: createdOn,
      );

  String get formatedDueOn =>
      dueOn != null ? DateFormat('d MMMM y').format(dueOn!) : '--';
  String get formatedClosedOn =>
      closedOn != null ? DateFormat('d MMMM y').format(closedOn!) : '--';

  factory FilteredActionItem.fromMap(Map<String, dynamic> map) {
    FilteredEntity entity = FilteredEntity.fromMap(map);
    return FilteredActionItem(
      id: entity.id,
      status: map['status'] ?? '',
      source: map['source'] ?? '',
      assignee: map['assignee'] ?? '',
      actionRequired: map['action_required'] ?? '',
      dueOn: map['due_on'] != null ? DateTime.parse(map['due_on']) : null,
      closedOn:
          map['closed_on'] != null ? DateTime.parse(map['closed_on']) : null,
      category: map['category'] ?? '',
      comments: map['comments'] ?? '',
      location: map['location'] ?? '',
      company: map['company'] ?? '',
      project: map['project'] ?? '',
      createdBy: entity.createdBy,
      createdOn: entity.createdOn,
      lastModifiedOn: entity.lastModifiedOn,
      lastModifiedByUserName: entity.lastModifiedByUserName,
      deleted: entity.deleted,
    );
  }

  factory FilteredActionItem.fromJson(String source) =>
      FilteredActionItem.fromMap(json.decode(source) as Map<String, dynamic>);

  FilteredActionItem copyWith({
    String? id,
    String? status,
    String? source,
    String? assignee,
    String? actionRequired,
    DateTime? dueOn,
    DateTime? closedOn,
    String? category,
    String? comments,
    String? company,
    String? location,
    String? project,
    String? createdBy,
    String? createdOn,
    String? lastModifiedOn,
    String? lastModifiedByUserName,
    bool? deleted,
    List<String>? columns,
  }) {
    return FilteredActionItem(
      id: id ?? this.id,
      status: status ?? this.status,
      source: source ?? this.source,
      assignee: assignee ?? this.assignee,
      actionRequired: actionRequired ?? this.actionRequired,
      dueOn: dueOn ?? this.dueOn,
      closedOn: closedOn ?? this.closedOn,
      company: company ?? this.company,
      category: category ?? this.category,
      comments: comments ?? this.comments,
      location: location ?? this.location,
      project: project ?? this.project,
      createdBy: createdBy ?? this.createdBy,
      createdOn: createdOn ?? this.createdOn,
      lastModifiedOn: lastModifiedOn ?? this.lastModifiedOn,
      lastModifiedByUserName:
          lastModifiedByUserName ?? this.lastModifiedByUserName,
      deleted: deleted ?? this.deleted,
    );
  }
}
