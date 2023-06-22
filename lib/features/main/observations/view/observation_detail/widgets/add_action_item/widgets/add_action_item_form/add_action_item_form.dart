import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AddActionItemFormView extends StatelessWidget {
  const AddActionItemFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        TaskInputBox(),
        DueByDatePicker(),
        AssigneeSelectField(),
        CategorySelectField(),
        CompanySelectField(),
        ProjectSelectField(),
        LocationInputBox(),
        NotesTextField(),
      ],
    );
  }
}
