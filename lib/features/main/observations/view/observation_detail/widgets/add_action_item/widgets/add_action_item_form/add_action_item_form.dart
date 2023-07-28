import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AddActionItemFormView extends StatelessWidget {
  const AddActionItemFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddActionItemBloc, AddActionItemState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TaskInputBox(),
            const DueByDatePicker(),
            const SiteSelectField(),
            const AssigneeSelectField(),
            const CategorySelectField(),
            const CompanySelectField(),
            const ProjectSelectField(),
            const LocationInputBox(),
            const NotesTextField(),
            const ActionItemImagePicker(),
            if (state.actionItem != null) const IsClosedCheckBox(),
          ],
        );
      },
    );
  }
}
