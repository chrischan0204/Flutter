import '/common_libraries.dart';

class TemplateResponseScaleItem extends Equatable {
  final String id;
  final String name;
  final String? responseScaleItemId;
  final bool isRequired;
  final bool included;
  final double score;
  final bool commentRequired;
  final bool actionItemRequired;
  final bool followUpRequired;
  final int order;

  final List<TemplateSection> followUpQuestionList;
  final bool isOpen;

  const TemplateResponseScaleItem({
    required this.id,
    required this.name,
    this.responseScaleItemId,
    required this.isRequired,
    required this.included,
    required this.score,
    required this.commentRequired,
    required this.actionItemRequired,
    required this.followUpRequired,
    required this.order,
    this.followUpQuestionList = const [],
    this.isOpen = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        responseScaleItemId,
        isRequired,
        included,
        score,
        commentRequired,
        actionItemRequired,
        followUpRequired,
        order,
        followUpQuestionList,
        isOpen,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': null,
      'isRequired': isRequired,
      'included': true,
      'name': name,
      'responseScaleItemId': id,
      'score': score,
      'order': order,
      'commentRequired': commentRequired,
      'actionItemRequired': actionItemRequired,
      'followUpRequired': followUpRequired,
    };
  }

  factory TemplateResponseScaleItem.fromMap(Map<String, dynamic> map) {
    return TemplateResponseScaleItem(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      isRequired: map['isRequired'] ?? false,
      included:
          (map['isRequired'] as bool) == true ? true : map['included'] ?? false,
      responseScaleItemId: map['responseScaleItemId'],
      score: map['score'] ?? 0,
      commentRequired: map['commentRequired'] ?? false,
      actionItemRequired: map['actionItemRequired'] ?? false,
      followUpRequired: map['followUpRequired'] ?? false,
      order: map['order'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TemplateResponseScaleItem.fromJson(String source) =>
      TemplateResponseScaleItem.fromMap(
          json.decode(source) as Map<String, dynamic>);

  static List<TemplateResponseScaleItem> fromListJson(String source) {
    return List.from(json.decode(source))
        .map((e) => TemplateResponseScaleItem.fromMap(e))
        .toList();
  }

  TemplateResponseScaleItem copyWith({
    String? id,
    String? name,
    String? responseScaleItemId,
    bool? isRequired,
    bool? included,
    double? score,
    bool? commentRequired,
    bool? actionItemRequired,
    bool? followUpRequired,
    int? order,
    List<TemplateSection>? followUpQuestionList,
    bool? isOpen,
  }) {
    return TemplateResponseScaleItem(
      id: id ?? this.id,
      name: name ?? this.name,
      responseScaleItemId: responseScaleItemId ?? this.responseScaleItemId,
      isRequired: isRequired ?? this.isRequired,
      included: included ?? this.included,
      score: score ?? this.score,
      commentRequired: commentRequired ?? this.commentRequired,
      actionItemRequired: actionItemRequired ?? this.actionItemRequired,
      followUpRequired: followUpRequired ?? this.followUpRequired,
      order: order ?? this.order,
      followUpQuestionList: followUpQuestionList ?? this.followUpQuestionList,
      isOpen: isOpen ?? this.isOpen,
    );
  }
}
