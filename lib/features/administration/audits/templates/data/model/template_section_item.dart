import '/common_libraries.dart';

class TemplateSectionItem extends Equatable {
  final String? id;
  final String? templateSectionItemId;
  final String templateSectionId;
  final int itemTypeId;
  final String? responseScaleId;
  final String? parentId;
  final Question? question;
  final TemplateResponseScaleItem? response;
  final List<TemplateSectionItem> children;

  static TemplateSectionItem empty = const TemplateSectionItem();

  const TemplateSectionItem({
    this.id,
    this.templateSectionItemId,
    this.templateSectionId = emptyGuid,
    this.itemTypeId = 1,
    this.responseScaleId,
    this.parentId,
    this.question,
    this.response,
    this.children = const [],
  });

  @override
  List<Object?> get props => [
        id,
        templateSectionItemId,
        templateSectionId,
        itemTypeId,
        responseScaleId,
        parentId,
        question,
        response,
        children,
      ];

  List<TemplateSectionItem> get includedChildren => children
      .where((element) => element.response?.included == true)
      .map((e) => e)
      .toList();

  bool get isNotBlank =>
      children.isNotEmpty ||
      question != null ||
      responseScaleId != emptyGuid ||
      children.isNotEmpty;

  bool get isNew => id == null;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': templateSectionItemId,
      'templateSectionId':
          templateSectionId == emptyGuid ? null : templateSectionId,
      'itemTypeId': itemTypeId,
      'responseScaleId': responseScaleId,
      'parentId': parentId,
      'question': question?.toMap(),
      'response': itemTypeId == 3 ? null : response?.toMap(),
    };

    if (children.isNotEmpty) {
      map.addEntries([
        MapEntry(
            'children',
            children
                .where((element) =>
                    element.response?.included == true ||
                    (element.response?.included == false &&
                        element.response?.id != null))
                .map((e) => e.toMap())
                .toList())
      ]);
    }

    return map;
  }

  factory TemplateSectionItem.fromMap(Map<String, dynamic> map) {
    return TemplateSectionItem(
      id: map['id'] as String,
      templateSectionId: map['templateSectionId'] as String,
      itemTypeId: map['itemTypeId'],
      responseScaleId: map['responseScaleId'] as String,
      parentId: map['parentId'] as String,
      question: Question.fromMap(map['question'] as Map<String, dynamic>),
      response: TemplateResponseScaleItem.fromMap(
          map['response'] as Map<String, dynamic>),
      children: List.from(json.decode(map['children'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory TemplateSectionItem.fromJson(String source) =>
      TemplateSectionItem.fromMap(json.decode(source) as Map<String, dynamic>);

  TemplateSectionItem copyWith({
    String? id,
    String? templateSectionItemId,
    String? templateSectionId,
    int? itemTypeId,
    String? responseScaleId,
    String? parentId,
    Nullable<Question?>? question,
    Nullable<TemplateResponseScaleItem?>? response,
    List<TemplateSectionItem>? children,
  }) {
    return TemplateSectionItem(
      id: id ?? this.id,
      templateSectionItemId:
          templateSectionItemId ?? this.templateSectionItemId,
      templateSectionId: templateSectionId ?? this.templateSectionId,
      itemTypeId: itemTypeId ?? this.itemTypeId,
      responseScaleId: responseScaleId ?? this.responseScaleId,
      parentId: parentId ?? this.parentId,
      question: question != null ? question.value : this.question,
      response: response != null ? response.value : this.response,
      children: children ?? this.children,
    );
  }
}
