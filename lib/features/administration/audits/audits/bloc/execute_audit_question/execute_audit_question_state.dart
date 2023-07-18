part of 'execute_audit_question_bloc.dart';

class ExecuteAuditQuestionState extends Equatable {
  final EntityStatus questionLoadStatus;
  final AuditQuestion level0;
  final AuditQuestion? level1Followup;
  final AuditQuestion? level2Followup;
  final AuditResponseScaleItem? selectedlevel0Response;
  final AuditResponseScaleItem? selectedlevel1Response;
  final AuditResponseScaleItem? selectedlevel2Response;
  final int level;
  const ExecuteAuditQuestionState({
    required this.level0,
    this.level1Followup,
    this.level2Followup,
    this.selectedlevel0Response,
    this.selectedlevel1Response,
    this.selectedlevel2Response,
    this.questionLoadStatus = EntityStatus.initial,
    this.level = 0,
  });

  @override
  List<Object?> get props => [
        level0,
        level1Followup,
        level2Followup,
        questionLoadStatus,
        selectedlevel0Response,
        selectedlevel1Response,
        selectedlevel2Response,
        level,
      ];

  AuditResponseScaleItem? get selectedResponse {
    switch (level) {
      case 0:
        return selectedlevel0Response;
      case 1:
        return selectedlevel1Response;
      case 2:
        return selectedlevel2Response;
    }
    return null;
  }

  AuditQuestion? get auditQuestion {
    switch (level) {
      case 0:
        return level0;
      case 1:
        return level1Followup;
      case 2:
        return level2Followup;
    }

    return null;
  }

  ExecuteAuditQuestionState copyWith({
    EntityStatus? questionLoadStatus,
    AuditQuestion? level0,
    Nullable<AuditQuestion?>? level1Followup,
    Nullable<AuditQuestion?>? level2Followup,
    Nullable<AuditResponseScaleItem?>? selectedlevel0Response,
    Nullable<AuditResponseScaleItem?>? selectedlevel1Response,
    Nullable<AuditResponseScaleItem?>? selectedlevel2Response,
    int? level,
  }) {
    return ExecuteAuditQuestionState(
      questionLoadStatus: questionLoadStatus ?? this.questionLoadStatus,
      level0: level0 ?? this.level0,
      level1Followup:
          level1Followup != null ? level1Followup.value : this.level1Followup,
      level2Followup:
          level2Followup != null ? level2Followup.value : this.level2Followup,
      selectedlevel0Response: selectedlevel0Response != null
          ? selectedlevel0Response.value
          : this.selectedlevel0Response,
      selectedlevel1Response: selectedlevel1Response != null
          ? selectedlevel1Response.value
          : this.selectedlevel1Response,
      selectedlevel2Response: selectedlevel2Response != null
          ? selectedlevel2Response.value
          : this.selectedlevel2Response,
      level: level ?? this.level,
    );
  }
}
