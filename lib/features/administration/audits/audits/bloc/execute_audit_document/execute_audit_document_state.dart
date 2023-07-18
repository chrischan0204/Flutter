part of 'execute_audit_document_bloc.dart';

class ExecuteAuditDocumentState extends Equatable {
  final List<Document> documentList;
  final EntityStatus documentListLoadStatus;
  const ExecuteAuditDocumentState({
    this.documentList = const [],
    this.documentListLoadStatus = EntityStatus.initial,
  });

  @override
  List<Object> get props => [
        documentList,
        documentListLoadStatus,
      ];

  ExecuteAuditDocumentState copyWith({
    List<Document>? documentList,
    EntityStatus? documentListLoadStatus,
  }) {
    return ExecuteAuditDocumentState(
      documentList: documentList ?? this.documentList,
      documentListLoadStatus:
          documentListLoadStatus ?? this.documentListLoadStatus,
    );
  }
}
