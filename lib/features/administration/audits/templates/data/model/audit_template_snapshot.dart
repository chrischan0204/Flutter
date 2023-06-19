import '/common_libraries.dart';

class AuditTemplateSnapshot extends Equatable {
  final double averageAuditScore;
  final String? lastUsedInAudit;
  final String? lastAuditStatus;
  final int usedInAudits;
  final String? lastUsedByInAudit;

  const AuditTemplateSnapshot({
    required this.averageAuditScore,
    this.lastUsedInAudit,
    this.lastAuditStatus,
    required this.usedInAudits,
    this.lastUsedByInAudit,
  });

  @override
  List<Object?> get props => [
        averageAuditScore,
        lastUsedInAudit,
        lastAuditStatus,
        usedInAudits,
        lastUsedByInAudit,
      ];

  AuditTemplateSnapshot copyWith({
    double? averageAuditScore,
    String? lastUsedInAudit,
    String? lastAuditStatus,
    int? usedInAudits,
    String? lastUsedByInAudit,
  }) {
    return AuditTemplateSnapshot(
      averageAuditScore: averageAuditScore ?? this.averageAuditScore,
      lastUsedInAudit: lastUsedInAudit ?? this.lastUsedInAudit,
      lastAuditStatus: lastAuditStatus ?? this.lastAuditStatus,
      usedInAudits: usedInAudits ?? this.usedInAudits,
      lastUsedByInAudit: lastUsedByInAudit ?? this.lastUsedByInAudit,
    );
  }

  factory AuditTemplateSnapshot.fromMap(Map<String, dynamic> map) {
    return AuditTemplateSnapshot(
      averageAuditScore: map['averageAuditScore'] as double,
      lastUsedInAudit: map['lastUsedInAudit'],
      lastAuditStatus: map['lastAuditStatus'],
      usedInAudits: map['usedInAudits'] as int,
      lastUsedByInAudit: map['lastUsedByInAudit'],
    );
  }

  factory AuditTemplateSnapshot.fromJson(String source) =>
      AuditTemplateSnapshot.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
