import '/common_libraries.dart';

class TemplateSectionListItemForDetail extends Equatable {
  final String id;
  final String name;
  const TemplateSectionListItemForDetail({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [
        id,
        name,
      ];

  TemplateSectionListItemForDetail copyWith({
    String? id,
    String? name,
  }) {
    return TemplateSectionListItemForDetail(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory TemplateSectionListItemForDetail.fromMap(Map<String, dynamic> map) {
    return TemplateSectionListItemForDetail(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  factory TemplateSectionListItemForDetail.fromJson(String source) =>
      TemplateSectionListItemForDetail.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
