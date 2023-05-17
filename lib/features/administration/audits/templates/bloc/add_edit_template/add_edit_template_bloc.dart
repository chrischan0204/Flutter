import 'package:equatable/equatable.dart';
import '/common_libraries.dart';

part 'add_edit_template_event.dart';
part 'add_edit_template_state.dart';

class AddEditTemplateBloc
    extends Bloc<AddEditTemplateEvent, AddEditTemplateState> {
  final TemplatesRepository templatesRepository;
  AddEditTemplateBloc({required this.templatesRepository})
      : super(const AddEditTemplateState()) {
    on<AddEditTemplateEvent>((event, emit) {});
  }
}
