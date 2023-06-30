import '/common_libraries.dart';

part 'audit_detail_event.dart';
part 'audit_detail_state.dart';

class AuditDetailBloc extends Bloc<AuditDetailEvent, AuditDetailState> {
  final BuildContext context;
  late AuditsRepository auditsRepository;
  final String auditId;
  AuditDetailBloc(
    this.context,
    this.auditId,
  ) : super(const AuditDetailState()) {
    auditsRepository = RepositoryProvider.of(context);
    on<AuditDetailLoaded>(_onAuditDetailLoaded);
    on<AuditDetailAuditDeleted>(_onAuditDetailAuditDeleted);
    on<AuditDetailAuditSectionListLoaded>(_onAuditDetailAuditSectionListLoaded);
    on<AuditDetailSelectedAuditSectionChanged>(
        _onAuditDetailSelectedAuditSectionChanged);
  }

  Future<void> _onAuditDetailLoaded(
    AuditDetailLoaded event,
    Emitter<AuditDetailState> emit,
  ) async {
    try {
      AuditSummary auditSummary =
          await auditsRepository.getAuditSummary(event.auditId);

      emit(state.copyWith(auditSummary: auditSummary));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onAuditDetailAuditDeleted(
    AuditDetailAuditDeleted event,
    Emitter<AuditDetailState> emit,
  ) async {}

  Future<void> _onAuditDetailAuditSectionListLoaded(
    AuditDetailAuditSectionListLoaded event,
    Emitter<AuditDetailState> emit,
  ) async {
    final auditSectionAndQuestion =
        await auditsRepository.getAuditSectionAndQuestionList(event.auditId);

    emit(state.copyWith(
      auditSectionAndQuestionList: auditSectionAndQuestion,
      selectedAuditSection: auditSectionAndQuestion.isNotEmpty
          ? auditSectionAndQuestion.first
          : null,
    ));
  }

  void _onAuditDetailSelectedAuditSectionChanged(
    AuditDetailSelectedAuditSectionChanged event,
    Emitter<AuditDetailState> emit,
  ) {
    emit(state.copyWith(selectedAuditSection: event.auditSection));
  }
}
