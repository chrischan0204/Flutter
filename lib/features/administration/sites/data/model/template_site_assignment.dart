import '/common_libraries.dart';

class TemplateSiteAssignment extends Equatable {
  final String siteId;
  final String templateId;
  final bool assigned;
  const TemplateSiteAssignment({
    required this.siteId,
    required this.templateId,
    required this.assigned,
  });

  @override
  List<Object?> get props => [
        siteId,
        templateId,
        assigned,
      ];

  TemplateSiteAssignment copyWith({
    String? siteId,
    String? templateId,
    bool? assigned,
  }) {
    return TemplateSiteAssignment(
      siteId: siteId ?? this.siteId,
      templateId: templateId ?? this.templateId,
      assigned: assigned ?? this.assigned,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'siteId': siteId,
      'templateId': templateId,
      'assigned': assigned,
    };
  }

  String toJson() => json.encode(toMap());
}
