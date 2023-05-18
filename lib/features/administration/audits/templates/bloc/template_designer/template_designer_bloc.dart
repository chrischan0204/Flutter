import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'template_designer_event.dart';
part 'template_designer_state.dart';

class TemplateDesignerBloc extends Bloc<TemplateDesignerEvent, TemplateDesignerState> {
  TemplateDesignerBloc() : super(TemplateDesignerInitial()) {
    on<TemplateDesignerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
