import '/common_libraries.dart';

part 'execute_audit_document_event.dart';
part 'execute_audit_document_state.dart';

class ExecuteAuditDocumentBloc
    extends Bloc<ExecuteAuditDocumentEvent, ExecuteAuditDocumentState> {
  final BuildContext context;
  final AuditQuestion auditQuestion;

  late AuditsRepository _auditsRepository;
  ExecuteAuditDocumentBloc({
    required this.context,
    required this.auditQuestion,
  }) : super(const ExecuteAuditDocumentState()) {
    _auditsRepository = context.read();

    on<ExecuteAuditDocumentListLoaded>(_onExecuteAuditDocumentListLoaded);
  }

  Future<void> _onExecuteAuditDocumentListLoaded(
    ExecuteAuditDocumentListLoaded event,
    Emitter<ExecuteAuditDocumentState> emit,
  ) async {
    emit(state.copyWith(documentListLoadStatus: EntityStatus.loading));
    try {
      List<Document> documentList =
          await _auditsRepository.getDocumentList(auditQuestion.id);

      emit(state.copyWith(
        documentList: documentList,
        documentListLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      print(e);
      emit(state.copyWith(documentListLoadStatus: EntityStatus.failure));
    }
  }
}
