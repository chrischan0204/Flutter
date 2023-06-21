import '/common_libraries.dart';

part 'audit_questions_event.dart';
part 'audit_questions_state.dart';

class AuditQuestionsBloc
    extends Bloc<AuditQuestionsEvent, AuditQuestionsState> {
  final BuildContext context;
  late AuditsRepository auditsRepository;
  AuditQuestionsBloc(this.context) : super(const AuditQuestionsState()) {
    auditsRepository = context.read();

    on<AuditQuestionsSnapshotListLoaded>(_onAuditQuestionsSnapshotListLoaded);
  }

  Future<void> _onAuditQuestionsSnapshotListLoaded(
    AuditQuestionsSnapshotListLoaded event,
    Emitter<AuditQuestionsState> emit,
  ) async {
    final auditQuestionSnapshotList =
        await auditsRepository.getAuditQuestionSnapshotList(event.auditId);

    emit(state.copyWith(auditQuestionSnapshotList: auditQuestionSnapshotList));
  }
}
