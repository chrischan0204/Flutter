import '/common_libraries.dart';

part 'execute_audit_comment_event.dart';
part 'execute_audit_comment_state.dart';

class ExecuteAuditCommentBloc
    extends Bloc<ExecuteAuditCommentEvent, ExecuteAuditCommentState> {
  final BuildContext context;
  final AuditQuestion auditQuestion;

  late ExecuteAuditBloc _executeAuditBloc;
  late ExecuteAuditQuestionBloc _executeAuditQuestionBloc;
  late AuditsRepository _auditsRepository;
  late FormDirtyBloc _formDirtyBloc;
  late String _questionId;
  late String _auditId;
  late String _userId;
  ExecuteAuditCommentBloc({
    required this.context,
    required this.auditQuestion,
  }) : super(const ExecuteAuditCommentState()) {
    _executeAuditBloc = context.read();
    _auditsRepository = context.read();
    _executeAuditQuestionBloc = context.read();
    _formDirtyBloc = context.read();

    _questionId = auditQuestion.id;

    _auditId = _executeAuditBloc.auditId;

    _userId = context.read<AuthBloc>().state.authUser!.id;

    on<ExecuteAuditCommentListLoaded>(_onExecuteAuditCommentListLoaded);
    on<ExecuteAuditCommentCreated>(_onExecuteAuditCommentCreated);
    on<ExecuteAuditCommentDeleted>(_onExecuteAuditCommentDeleted);
    on<ExecuteAuditCommentTextChanged>(_onExecuteAuditCommentTextChanged);
    on<ExecuteAuditCommentViewChanged>(_onExecuteAuditCommentViewChanged);
    on<ExecuteAuditCommentLoaded>(_onExecuteAuditCommentLoaded);
    on<ExecuteAuditCommentUpdated>(_onExecuteAuditCommentUpdated);
    on<ExecuteAuditCommentInited>(_onExecuteAuditCommentInited);
  }

  Future<void> _onExecuteAuditCommentListLoaded(
    ExecuteAuditCommentListLoaded event,
    Emitter<ExecuteAuditCommentState> emit,
  ) async {
    _formDirtyBloc.add(const FormDirtyChanged(isDirty: false));

    _executeAuditQuestionBloc
        .add(ExecuteAuditQuestionDetailLoaded(questionId: _questionId));
    emit(state.copyWith(status: EntityStatus.loading));

    try {
      List<AuditComment> auditCommentList =
          await _auditsRepository.getAuditCommentList(_questionId);

      emit(state.copyWith(
        auditCommentList: auditCommentList,
        status: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: EntityStatus.failure));
    }
  }

  Future<void> _onExecuteAuditCommentLoaded(
    ExecuteAuditCommentLoaded event,
    Emitter<ExecuteAuditCommentState> emit,
  ) async {
    emit(state.copyWith(status: EntityStatus.loading));

    try {
      final auditComment = await _auditsRepository.getAuditCommentById(
        questionId: _questionId,
        commentId: event.commentId,
      );
      emit(state.copyWith(
        auditComment: Nullable.value(auditComment),
        commentText: auditComment.commentText,
        initialCommentText: auditComment.commentText,
        status: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: EntityStatus.failure));
    }
  }

  Future<void> _onExecuteAuditCommentCreated(
    ExecuteAuditCommentCreated event,
    Emitter<ExecuteAuditCommentState> emit,
  ) async {
    if (Validation.isEmpty(state.commentText)) {
      emit(state.copyWith(
          commentValidationMessage:
              FormValidationMessage(fieldName: 'Comment').requiredMessage));
    } else {
      emit(state.copyWith(
        status: EntityStatus.loading,
        crudStatus: EntityStatus.loading,
      ));

      try {
        await _auditsRepository.addCommentForAudit(AuditCommentCreate(
          userId: _userId,
          auditId: _auditId,
          questionId: _questionId,
          commentText: state.commentText,
        ));

        emit(state.copyWith(
          status: EntityStatus.success,
          crudStatus: EntityStatus.success,
          message: 'Comment added successfully.',
          commentText: '',
        ));

        add(ExecuteAuditCommentListLoaded());

        add(const ExecuteAuditCommentViewChanged(view: CrudView.list));
      } catch (e) {
        emit(state.copyWith(
          status: EntityStatus.failure,
          crudStatus: EntityStatus.failure,
        ));
      }
    }
  }

  Future<void> _onExecuteAuditCommentUpdated(
    ExecuteAuditCommentUpdated event,
    Emitter<ExecuteAuditCommentState> emit,
  ) async {
    if (Validation.isEmpty(state.commentText)) {
      emit(state.copyWith(
          commentValidationMessage:
              FormValidationMessage(fieldName: 'Comment').requiredMessage));
    } else {
      emit(state.copyWith(
        status: EntityStatus.loading,
        crudStatus: EntityStatus.loading,
      ));

      try {
        await _auditsRepository.editCommentForAudit(AuditCommentUpdate(
          id: state.auditComment!.id,
          userId: _userId,
          auditId: _auditId,
          questionId: _questionId,
          commentText: state.commentText,
        ));

        emit(state.copyWith(
          status: EntityStatus.success,
          commentText: '',
          auditComment: const Nullable.value(null),
          message: 'Comment updated successfully.',
          crudStatus: EntityStatus.success,
        ));

        add(ExecuteAuditCommentListLoaded());

        add(const ExecuteAuditCommentViewChanged(view: CrudView.list));
      } catch (e) {
        emit(state.copyWith(
          status: EntityStatus.failure,
          crudStatus: EntityStatus.failure,
        ));
      }
    }
  }

  void _onExecuteAuditCommentTextChanged(
    ExecuteAuditCommentTextChanged event,
    Emitter<ExecuteAuditCommentState> emit,
  ) {
    emit(state.copyWith(
      commentText: event.commentText,
      commentValidationMessage: '',
    ));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.isDirty));
  }

  void _onExecuteAuditCommentViewChanged(
    ExecuteAuditCommentViewChanged event,
    Emitter<ExecuteAuditCommentState> emit,
  ) {
    emit(state.copyWith(view: event.view));
  }

  Future<void> _onExecuteAuditCommentDeleted(
    ExecuteAuditCommentDeleted event,
    Emitter<ExecuteAuditCommentState> emit,
  ) async {
    emit(state.copyWith(
      status: EntityStatus.loading,
      crudStatus: EntityStatus.loading,
    ));

    try {
      EntityResponse response = await _auditsRepository.deleteAuditComment(
        commentId: event.commentId,
        auditId: _auditId,
      );

      if (response.isSuccess) {
        emit(state.copyWith(
          status: EntityStatus.success,
          crudStatus: EntityStatus.success,
          message: 'Comment deleted successfully.',
        ));

        add(ExecuteAuditCommentListLoaded());
      }
    } catch (e) {
      emit(state.copyWith(
        status: EntityStatus.failure,
        crudStatus: EntityStatus.failure,
      ));
    }
  }

  void _onExecuteAuditCommentInited(
    ExecuteAuditCommentInited event,
    Emitter<ExecuteAuditCommentState> emit,
  ) {
    emit(const ExecuteAuditCommentState());
  }
}
