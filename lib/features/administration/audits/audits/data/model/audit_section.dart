import '/common_libraries.dart';

enum AuditSectionStatus {
  done,
  partial,
  inProgress,
  notStarted;

  @override
  String toString() {
    switch (this) {
      case AuditSectionStatus.done:
        return 'Done';
      case AuditSectionStatus.partial:
        return 'Partial';
      case AuditSectionStatus.inProgress:
        return 'In Progress';
      case AuditSectionStatus.notStarted:
        return 'Not Started';
    }
  }

  Color toColor() {
    switch (this) {
      case AuditSectionStatus.done:
        return successColor;
      case AuditSectionStatus.partial:
        return Colors.blueGrey;
      case AuditSectionStatus.inProgress:
        return primaryColor;
      case AuditSectionStatus.notStarted:
        return warnColor;
    }
  }
}

class AuditSection extends Equatable {
  final String id;
  final String name;
  final int order;
  final bool isIncluded;
  final int questionCount;
  final bool isNew;
  final double maxScore;
  final AuditSectionStatus status;
  final List<AuditQuestion> auditQuestionList;

  const AuditSection({
    this.id = emptyGuid,
    this.name = '',
    this.order = 0,
    this.isIncluded = true,
    this.isNew = false,
    this.status = AuditSectionStatus.done,
    this.questionCount = 0,
    this.maxScore = 0,
    this.auditQuestionList = const [],
  });

  bool get isNoIncluded =>
      auditQuestionList.where((element) => element.questionIncluded).isEmpty;

  @override
  List<Object?> get props => [
        id,
        name,
        order,
        isIncluded,
        isNew,
        status,
        auditQuestionList,
        questionCount,
        maxScore,
      ];

  factory AuditSection.fromMap(Map<String, dynamic> map) {
    return AuditSection(
      id: map['id'],
      name: map['name'],
      order: map['order'],
      isIncluded: map['isIncluded'],
      questionCount: map['questionCount'] ?? 0,
      maxScore: map['maxScore'] ?? 0,
      status: AuditSectionStatus.done,
      auditQuestionList: const [],
    );
  }

  factory AuditSection.fromJson(String source) =>
      AuditSection.fromMap(json.decode(source) as Map<String, dynamic>);

  AuditSection copyWith({
    String? id,
    String? name,
    int? order,
    bool? isIncluded,
    int? questionCount,
    bool? isNew,
    double? maxScore,
    AuditSectionStatus? status,
    List<AuditQuestion>? auditQuestionList,
  }) {
    return AuditSection(
      id: id ?? this.id,
      name: name ?? this.name,
      order: order ?? this.order,
      isIncluded: isIncluded ?? this.isIncluded,
      questionCount: questionCount ?? this.questionCount,
      isNew: isNew ?? this.isNew,
      maxScore: maxScore ?? this.maxScore,
      status: status ?? this.status,
      auditQuestionList: auditQuestionList ?? this.auditQuestionList,
    );
  }
}
