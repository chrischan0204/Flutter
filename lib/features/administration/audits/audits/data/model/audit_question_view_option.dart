
import '/common_libraries.dart';

class AuditQuestionViewOption extends Equatable {
  final List<AuditQuestionViewOptionItem> sections;

  final List<AuditQuestionViewOptionItem> statuses;

  const AuditQuestionViewOption({
    required this.sections,
    required this.statuses,
  });

  @override
  List<Object?> get props => [
        sections,
        statuses,
      ];

  AuditQuestionViewOption copyWith({
    List<AuditQuestionViewOptionItem>? sections,
    List<AuditQuestionViewOptionItem>? statuses,
  }) {
    return AuditQuestionViewOption(
      sections: sections ?? this.sections,
      statuses: statuses ?? this.statuses,
    );
  }

  factory AuditQuestionViewOption.fromMap(Map<String, dynamic> map) {
    return AuditQuestionViewOption(
      sections: List<AuditQuestionViewOptionItem>.from(
        (map['sections']).map<AuditQuestionViewOptionItem>(
          (x) => AuditQuestionViewOptionItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      statuses: List<AuditQuestionViewOptionItem>.from(
        (map['statuses']).map<AuditQuestionViewOptionItem>(
          (x) => AuditQuestionViewOptionItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory AuditQuestionViewOption.fromJson(String source) =>
      AuditQuestionViewOption.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

class AuditQuestionViewOptionItem extends Equatable {
  final String id;
  final String name;

  const AuditQuestionViewOptionItem({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [
        id,
        name,
      ];

  AuditQuestionViewOptionItem copyWith({
    String? id,
    String? name,
  }) {
    return AuditQuestionViewOptionItem(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory AuditQuestionViewOptionItem.fromMap(Map<String, dynamic> map) {
    return AuditQuestionViewOptionItem(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  factory AuditQuestionViewOptionItem.fromJson(String source) =>
      AuditQuestionViewOptionItem.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
