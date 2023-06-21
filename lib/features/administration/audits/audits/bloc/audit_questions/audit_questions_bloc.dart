import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'audit_questions_event.dart';
part 'audit_questions_state.dart';

class AuditQuestionsBloc extends Bloc<AuditQuestionsEvent, AuditQuestionsState> {
  AuditQuestionsBloc() : super(AuditQuestionsInitial()) {
    on<AuditQuestionsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
