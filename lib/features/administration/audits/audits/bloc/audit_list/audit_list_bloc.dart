import 'package:safety_eta/common_libraries.dart';

part 'audit_list_event.dart';
part 'audit_list_state.dart';

class AuditListBloc extends Bloc<AuditListEvent, AuditListState> {
  final AuditsRepository auditsRepository;
  AuditListBloc({required this.auditsRepository})
      : super(const AuditListState()) {
    on<AuditListLoaded>(_onAuditListLoaded);
    on<AuditListFiltered>(_onAuditListFiltered);
    on<AuditListAuditForSideDetailLoaded>(_onAuditListAuditForSideDetailLoaded);
  }

  Future<void> _onAuditListLoaded(
    AuditListLoaded event,
    Emitter<AuditListState> emit,
  ) async {
    emit(state.copyWith(auditListLoadStatus: EntityStatus.loading));
    try {
      List<Audit> auditList = await auditsRepository.getAuditList();
      emit(state.copyWith(
        auditListLoadStatus: EntityStatus.success,
        auditList: auditList,
      ));
    } catch (e) {
      emit(state.copyWith(auditListLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onAuditListFiltered(
    AuditListFiltered event,
    Emitter<AuditListState> emit,
  ) async {
    emit(state.copyWith(auditListLoadStatus: EntityStatus.loading));

    try {
      final filteredauditData =
          await auditsRepository.getFilteredAuditList(event.option);
      final List<String> columns = List.from(filteredauditData.headers
          .where((e) => !e.isHidden)
          .map((e) => e.title));

      emit(state.copyWith(
        auditList: filteredauditData.data
            .map((e) => e.audit.copyWith(columns: columns))
            .toList(),
        auditListLoadStatus: EntityStatus.success,
        totalRows: filteredauditData.totalRows,
      ));
    } catch (e) {
      print(e);
      emit(state.copyWith(auditListLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onAuditListAuditForSideDetailLoaded(
    AuditListAuditForSideDetailLoaded event,
    Emitter<AuditListState> emit,
  ) async {
    emit(state.copyWith(auditLoadStatus: EntityStatus.loading));
    try {
      Audit audit = await auditsRepository.getAuditById(event.auditId);
      emit(state.copyWith(
        auditLoadStatus: EntityStatus.success,
        audit: audit,
      ));
    } catch (e) {
      print(e);
      emit(state.copyWith(auditLoadStatus: EntityStatus.failure));
    }
  }
}
