import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'execute_audit_question_event.dart';
part 'execute_audit_question_state.dart';

class ExecuteAuditQuestionBloc extends Bloc<ExecuteAuditQuestionEvent, ExecuteAuditQuestionState> {
  ExecuteAuditQuestionBloc() : super(ExecuteAuditQuestionInitial()) {
    on<ExecuteAuditQuestionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
