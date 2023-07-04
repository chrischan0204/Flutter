import '/common_libraries.dart';

class ActionItemParentInfo extends Equatable {
  final String title;
  final String source;
  final String id;
  final String siteName;
  final String companyName;
  final String projectName;
  final String createdByName;
  final String date;
  final String forQuestion;
  final String priorityLevelName;

  const ActionItemParentInfo({
    required this.title,
    required this.source,
    required this.id,
    required this.siteName,
    required this.companyName,
    required this.projectName,
    required this.createdByName,
    required this.date,
    required this.forQuestion,
    required this.priorityLevelName,
  });

  @override
  List<Object?> get props => [
        title,
        source,
        id,
        siteName,
        companyName,
        projectName,
        createdByName,
        date,
        forQuestion,
        priorityLevelName,
      ];

  ActionItemParentInfo copyWith({
    String? title,
    String? source,
    String? id,
    String? siteName,
    String? companyName,
    String? projectName,
    String? createdByName,
    String? date,
    String? forQuestion,
    String? priorityLevelName,
  }) {
    return ActionItemParentInfo(
      title: title ?? this.title,
      source: source ?? this.source,
      id: id ?? this.id,
      siteName: siteName ?? this.siteName,
      companyName: companyName ?? this.companyName,
      projectName: projectName ?? this.projectName,
      createdByName: createdByName ?? this.createdByName,
      date: date ?? this.date,
      forQuestion: forQuestion ?? this.forQuestion,
      priorityLevelName: priorityLevelName ?? this.priorityLevelName,
    );
  }

  factory ActionItemParentInfo.fromMap(Map<String, dynamic> map) {
    return ActionItemParentInfo(
      title: map['title'] ?? '',
      source: map['source'] ?? '',
      id: map['id'] ?? '',
      siteName: map['siteName'] ?? '',
      companyName: map['companyName'] ?? '',
      projectName: map['projectName'] ?? '',
      createdByName: map['createdByName'] ?? '',
      date: map['date'] ?? '',
      forQuestion: map['forQuestion'] ?? '',
      priorityLevelName: map['priorityLevelName'] ?? '',
    );
  }

  factory ActionItemParentInfo.fromJson(String source) =>
      ActionItemParentInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}
