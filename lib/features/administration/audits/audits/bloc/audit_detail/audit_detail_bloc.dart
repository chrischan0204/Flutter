import '/common_libraries.dart';

part 'audit_detail_event.dart';
part 'audit_detail_state.dart';

class AuditDetailBloc extends Bloc<AuditDetailEvent, AuditDetailState> {
  final BuildContext context;
  late AuditsRepository auditsRepository;
  AuditDetailBloc(this.context) : super(const AuditDetailState()) {
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
      Audit audit = await auditsRepository.getAuditById(event.auditId);

      emit(state.copyWith(audit: audit));
    } catch (e) {}
  }

  Future<void> _onAuditDetailAuditDeleted(
    AuditDetailAuditDeleted event,
    Emitter<AuditDetailState> emit,
  ) async {}

  Future<void> _onAuditDetailAuditSectionListLoaded(
    AuditDetailAuditSectionListLoaded event,
    Emitter<AuditDetailState> emit,
  ) async {
    final auditSectionList =
        await auditsRepository.getAuditSectionList(event.auditId);

    emit(state.copyWith(
      auditSectionList: auditSectionList,
      selectedAuditSection:
          auditSectionList.isNotEmpty ? auditSectionList.first : null,
    ));
  }

  void _onAuditDetailSelectedAuditSectionChanged(
    AuditDetailSelectedAuditSectionChanged event,
    Emitter<AuditDetailState> emit,
  ) {
    emit(state.copyWith(selectedAuditSection: event.auditSection));
  }
}
