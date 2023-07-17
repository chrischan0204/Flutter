import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AddActionItemFormView extends StatelessWidget {
  const AddActionItemFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TaskInputBox(),
        DueByDatePicker(),
        SiteSelectField(),
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
