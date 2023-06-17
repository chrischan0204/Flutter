import '/common_libraries.dart';

class TemplateSection extends Equatable {
  final String id;
  final String name;
  final List<TemplateQuestion> templateSectionItems;

  const TemplateSection({
    required this.id,
    required this.name,
    required this.templateSectionItems,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        templateSectionItems,
      ];

  TemplateSection copyWith({
    String? id,
    String? name,
    List<TemplateQuestion>? templateSectionItems,
  }) {
    return TemplateSection(
      id: id ?? this.id,
      name: name ?? this.name,
      templateSectionItems: templateSectionItems ?? this.templateSectionItems,
    );
  }

  factory TemplateSection.fromMap(Map<String, dynamic> map) {
    return TemplateSection(
      id: map['id'] as String,
      name: map['name'] as String,
      templateSectionItems: List.from(
        (map['templateSectionItems']).map((x) => TemplateQuestion.fromMap(x)),
      ),
    );
  }

  factory TemplateSection.fromJson(String source) =>
      TemplateSection.fromMap(json.decode(source) as Map<String, dynamic>);
}
