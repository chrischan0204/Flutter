import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'edit_assessment_event.dart';
part 'edit_assessment_state.dart';

class EditAssessmentBloc extends Bloc<EditAssessmentEvent, EditAssessmentState> {
  EditAssessmentBloc() : super(EditAssessmentInitial()) {
    on<EditAssessmentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
