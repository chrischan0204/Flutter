// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'action_item_detail_bloc.dart';

class ActionItemDetailState extends Equatable {
  /// actionItem for detail
  final ActionItem? actionItem;
  final EntityStatus actionItemLoadStatus;
  final EntityStatus actionItemDeleteStatus;

  final ActionItemParentInfo? actionItemParentInfo;

  final ObservationDetail? observation;

  final AuditQuestionOnActionItem? auditQuestionOnActionitem;

  final List<Document> documentList;
  final EntityStatus documentListLoadStatus;

  final EntityStatus documentDeleteStatus;

  final String message;
  const ActionItemDetailState({
    this.actionItem,
    this.actionItemLoadStatus = EntityStatus.initial,
    this.actionItemDeleteStatus = EntityStatus.initial,
    this.actionItemParentInfo,
    this.observation,
    this.auditQuestionOnActionitem,
    this.documentList = const [],
    this.documentListLoadStatus = EntityStatus.initial,
    this.documentDeleteStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        actionItem,
        observation,
        auditQuestionOnActionitem,
        actionItemLoadStatus,
        actionItemDeleteStatus,
        actionItemParentInfo,
        documentList,
        documentListLoadStatus,
        documentDeleteStatus,
        message,
      ];

  ActionItemDetailState copyWith({
    ActionItem? actionItem,
    EntityStatus? actionItemLoadStatus,
    EntityStatus? actionItemDeleteStatus,
    ActionItemParentInfo? actionItemParentInfo,
    ObservationDetail? observation,
    AuditQuestionOnActionItem? auditQuestionOnActionitem,
    List<Document>? documentList,
    EntityStatus? documentListLoadStatus,
    EntityStatus? documentDeleteStatus,
    String? message,
  }) {
    return ActionItemDetailState(
      actionItem: actionItem ?? this.actionItem,
      actionItemLoadStatus: actionItemLoadStatus ?? this.actionItemLoadStatus,
      actionItemDeleteStatus:
          actionItemDeleteStatus ?? this.actionItemDeleteStatus,
      actionItemParentInfo: actionItemParentInfo ?? this.actionItemParentInfo,
      observation: observation ?? this.observation,
      auditQuestionOnActionitem:
          auditQuestionOnActionitem ?? this.auditQuestionOnActionitem,
      documentList: documentList ?? this.documentList,
      documentListLoadStatus:
          documentListLoadStatus ?? this.documentListLoadStatus,
      documentDeleteStatus: documentDeleteStatus ?? this.documentDeleteStatus,
      message: message ?? this.message,
    );
  }
}
