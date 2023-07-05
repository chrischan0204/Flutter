import '/common_libraries.dart';

class TemplateUsageSummary extends Equatable {
  final String auditId;
  final String templateId;
  final String? auditName;
  final String? templateName;
  final String? auditNumber;
  final int usedInAudits;
  final DateTime lastUsedOn;
  final String? auditStatus;
  final String? lastCreatedBy;

  const TemplateUsageSummary({
    required this.auditId,
    required this.templateId,
    this.auditName,
    this.templateName,
    this.auditNumber,
    required this.usedInAudits,
    required this.lastUsedOn,
    this.auditStatus,
    this.lastCreatedBy,
  });

  @override
  List<Object?> get props => [
        auditId,
        templateId,
        auditName,
        templateName,
        auditNumber,
        usedInAudits,
        lastUsedOn,
        auditStatus,
        lastCreatedBy,
      ];

  TemplateUsageSummary copyWith({
    String? auditId,
    String? templateId,
    String? auditName,
    String? templateName,
    String? auditNumber,
    int? usedInAudits,
    DateTime? lastUsedOn,
    String? auditStatus,
    String? lastCreatedBy,
  }) {
    return TemplateUsageSummary(
      auditId: auditId ?? this.auditId,
      templateId: templateId ?? this.templateId,
      auditName: auditName ?? this.auditName,
      templateName: templateName ?? this.templateName,
      auditNumber: auditNumber ?? this.auditNumber,
      usedInAudits: usedInAudits ?? this.usedInAudits,
      lastUsedOn: lastUsedOn ?? this.lastUsedOn,
      auditStatus: auditStatus ?? this.auditStatus,
      lastCreatedBy: lastCreatedBy ?? this.lastCreatedBy,
    );
  }

  factory TemplateUsageSummary.fromMap(Map<String, dynamic> map) {
    return TemplateUsageSummary(
      auditId: map['auditId'] as String,
      templateId: map['templateId'] as String,
      auditName: map['auditName'] != null ? map['auditName'] as String : null,
      templateName:
          map['templateName'] != null ? map['templateName'] as String : null,
      auditNumber:
          map['auditNumber'] != null ? map['auditNumber'] as String : null,
      usedInAudits: map['usedInAudits'] as int,
      lastUsedOn: DateTime.parse(map['lastUsedOn']),
      auditStatus:
          map['auditStatus'] != null ? map['auditStatus'] as String : null,
      lastCreatedBy:
          map['lastCreatedBy'] != null ? map['lastCreatedBy'] as String : null,
    );
  }

  factory TemplateUsageSummary.fromJson(String source) =>
      TemplateUsageSummary.fromMap(json.decode(source) as Map<String, dynamic>);
}
