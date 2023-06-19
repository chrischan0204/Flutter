import '/common_libraries.dart';

class TemplateSiteAssignment extends Equatable {
  final String siteId;
  final String userId;
  final String templateId;
  final bool assigned;
  const TemplateSiteAssignment({
    required this.siteId,
    required this.userId,
    required this.templateId,
    required this.assigned,
  });

  @override
  List<Object?> get props => [
        siteId,
        userId,
        templateId,
        assigned,
      ];

  TemplateSiteAssignment copyWith({
    String? siteId,
    String? userId,
    String? templateId,
    bool? assigned,
  }) {
    return TemplateSiteAssignment(
      siteId: siteId ?? this.siteId,
      userId: userId ?? this.userId,
      templateId: templateId ?? this.templateId,
      assigned: assigned ?? this.assigned,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'siteId': siteId,
      'userId': userId,
      'templateId': templateId,
      'assigned': assigned,
    };
  }

  String toJson() => json.encode(toMap());
}
