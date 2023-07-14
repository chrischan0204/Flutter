import '/common_libraries.dart';

part 'execute_audit_action_item_event.dart';
part 'execute_audit_action_item_state.dart';

class ExecuteAuditActionItemBloc
    extends Bloc<ExecuteAuditActionItemEvent, ExecuteAuditActionItemState> {
  final BuildContext context;
  final AuditQuestion auditQuestion;

  late ExecuteAuditBloc _executeAuditBloc;
  late AuditsRepository _auditsRepository;
  late String _questionId;
  late String _auditId;
  late String _userId;
  ExecuteAuditActionItemBloc({
    required this.context,
    required this.auditQuestion,
  }) : super(const ExecuteAuditActionItemState()) {
    _executeAuditBloc = context.read();
    _auditsRepository = context.read();

    _questionId = auditQuestion.id;

    _auditId = _executeAuditBloc.auditId;

    _userId = context.read<AuthBloc>().state.authUser!.id;

    // on<ExecuteAuditActionItemListLoaded>(_onExecuteAuditActionItemListLoaded);
    // on<ExecuteAuditActionItemCreated>(_onExecuteAuditActionItemCreated);
    // on<ExecuteAuditActionItemDeleted>(_onExecuteAuditActionItemDeleted);
    // on<ExecuteAuditActionItemTextChanged>(
    //     _onExecuteAuditActionItemTextChanged);
    // on<ExecuteAuditActionItemViewChanged>(
    //     _onExecuteAuditActionItemViewChanged);
    // on<ExecuteAuditActionItemLoaded>(_onExecuteAuditActionItemLoaded);
    // on<ExecuteAuditActionItemUpdated>(_onExecuteAuditActionItemUpdated);
  }

//   Future<void> _onExecuteAuditActionItemListLoaded(
//     ExecuteAuditActionItemListLoaded event,
//     Emitter<ExecuteAuditActionItemState> emit,
//   ) async {
//     emit(state.copyWith(auditActionItemListLoadStatus: EntityStatus.loading));

//     try {
//       List<AuditActionItem> auditActionItemList =
//           await _auditsRepository.getAuditActionItemList(_questionId);

//       emit(state.copyWith(
//         auditActionItemList: auditActionItemList,
//         auditActionItemListLoadStatus: EntityStatus.success,
//       ));
//     } catch (e) {
//       emit(
//           state.copyWith(auditActionItemListLoadStatus: EntityStatus.failure));
//     }
//   }

//   Future<void> _onExecuteAuditActionItemLoaded(
//     ExecuteAuditActionItemLoaded event,
//     Emitter<ExecuteAuditActionItemState> emit,
//   ) async {
//     emit(state.copyWith(auditActionItemLoadStatus: EntityStatus.loading));

//     try {
//       final auditActionItem = await _auditsRepository.getAuditActionItemById(
//         questionId: _questionId,
//         actionItemId: event.actionItemId,
//       );
//       emit(state.copyWith(
//         auditActionItem: auditActionItem,
//         auditActionItemLoadStatus: EntityStatus.success,
//       ));
//     } catch (e) {
//       emit(state.copyWith(auditActionItemLoadStatus: EntityStatus.failure));
//     }
//   }

//   Future<void> _onExecuteAuditActionItemCreated(
//     ExecuteAuditActionItemCreated event,
//     Emitter<ExecuteAuditActionItemState> emit,
//   ) async {
//     emit(state.copyWith(status: EntityStatus.loading));

//     try {
//       // await _auditsRepository.addActionItemForAudit(ActionItemCreate(
//       //   name: name,
//       //   siteId: siteId,
//       //   location: location,
//       //   response: response,
//       //   priorityLevelId: priorityLevelId,
//       //   actionItemTypeId: actionItemTypeId,
//       //   auditId: _auditId,
//       //   auditSectionItemId: _questionId,
//       // ));

//       emit(state.copyWith(
//         status: EntityStatus.success,
//         actionItemText: '',
//       ));

//       add(ExecuteAuditActionItemListLoaded());
//     } catch (e) {
//       emit(state.copyWith(status: EntityStatus.failure));
//     }
//   }

//   Future<void> _onExecuteAuditActionItemUpdated(
//     ExecuteAuditActionItemUpdated event,
//     Emitter<ExecuteAuditActionItemState> emit,
//   ) async {
//     emit(state.copyWith(status: EntityStatus.loading));

//     try {
//       // await _auditsRepository.editActionItemForAudit(ActionItemCreate(
//       //   name: name,
//       //   siteId: siteId,
//       //   location: location,
//       //   response: response,
//       //   priorityLevelId: priorityLevelId,
//       //   actionItemTypeId: actionItemTypeId,
//       //   auditId: _auditId,
//       //   auditSectionItemId: _questionId,
//       // ));

//       emit(state.copyWith(
//         status: EntityStatus.success,
//         actionItemText: '',
//       ));

//       add(ExecuteAuditActionItemListLoaded());
//     } catch (e) {
//       emit(state.copyWith(status: EntityStatus.failure));
//     }
//   }

//   void _onExecuteAuditActionItemTextChanged(
//     ExecuteAuditActionItemTextChanged event,
//     Emitter<ExecuteAuditActionItemState> emit,
//   ) {
//     emit(state.copyWith(actionItemText: event.actionItemText));
//   }

//   void _onExecuteAuditActionItemViewChanged(
//     ExecuteAuditActionItemViewChanged event,
//     Emitter<ExecuteAuditActionItemState> emit,
//   ) {
//     emit(state.copyWith(view: event.view));
//   }

//   Future<void> _onExecuteAuditActionItemDeleted(
//     ExecuteAuditActionItemDeleted event,
//     Emitter<ExecuteAuditActionItemState> emit,
//   ) async {
//     emit(state.copyWith(status: EntityStatus.loading));

//     try {
//       EntityResponse response = await _auditsRepository.deleteAuditActionItem(
//         actionItemId: event.actionItemId,
//         questionId: _questionId,
//       );

//       if (response.isSuccess) {
//         emit(state.copyWith(status: EntityStatus.success));

//         add(ExecuteAuditActionItemListLoaded());
//       }
//     } catch (e) {
//       emit(state.copyWith(status: EntityStatus.failure));
//     }
//   }
// }



// class ExecuteAuditActionItemBloc
//     extends Bloc<ExecuteAuditActionItemEvent, ExecuteAuditActionItemState> {
      
//   ExecuteAuditActionItemBloc() : super(const ExecuteAuditActionItemState()) {
    
//   }

//   Future<void> _onExecuteAuditActionItemProjectListLoaded(
//     ExecuteAuditActionItemProjectListLoaded event,
//     Emitter<ExecuteAuditActionItemState> emit,
//   ) async {

//     try {
//       List<Project> projectList = 
//     } catch (e) {

//     }
//   }
}
