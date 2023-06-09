import '/common_libraries.dart';

class FilteredTemplate extends FilteredEntity {
  final String name;
  final bool audit;
  final bool inspection;
  final String revisionDate;
  const FilteredTemplate({
    super.id,
    required this.name,
    required this.audit,
    required this.inspection,
    required this.revisionDate,
    super.createdBy,
    super.createdById,
    super.createdOn,
    super.lastModifiedOn,
    super.lastModifiedByUserName,
    super.deleted,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        name,
        audit,
        inspection,
        revisionDate,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'audit': audit,
      'inspection': inspection,
    };
  }

  factory FilteredTemplate.fromMap(Map<String, dynamic> map) {
    FilteredEntity entity = FilteredEntity.fromMap(map);
    return FilteredTemplate(
      id: entity.id,
      name: map['name'] ?? '',
      audit: map['audit'] ?? true,
      inspection: map['inspection'] ?? true,
      revisionDate: map['revision_Date'] != null
          ? FormatDate(
                  format: 'd MMMM y', dateString: map['revision_Date'] ?? '')
              .formatDate
          : '--',
      createdById: entity.createdById,
      createdBy: entity.createdBy,
      createdOn: entity.createdOn,
      lastModifiedOn: entity.lastModifiedOn,
      lastModifiedByUserName: entity.lastModifiedByUserName,
      deleted: entity.deleted,
    );
  }

  String toJson() => json.encode(toMap());

  factory FilteredTemplate.fromJson(String source) =>
      FilteredTemplate.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<Template> fromJsonList(String source) {
    return List.from(json.decode(source))
        .map((e) => FilteredTemplate.fromMap(e).template)
        .toList();
  }

  Template get template => Template(
        id: id,
        name: name,
        revisionDate: revisionDate,
        createdByUserName: createdBy,
        createdOn: createdOn,
        deleted: deleted,
      );
}
