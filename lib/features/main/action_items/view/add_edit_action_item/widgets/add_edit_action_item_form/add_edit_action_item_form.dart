import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AddEditActionItemFormView extends StatelessWidget {
  const AddEditActionItemFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditActionItemBloc, AddEditActionItemState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            FormItemVertical(
              leftLabel: 'Action Required (*)',
              leftChild: const ActionItemNameInputBox(),
              leftValidationMessage: state.nameValidationMessage,
              rightLabel: 'Site (*)',
              rightChild: const SiteSelectField(),
              rightValidationMessage: state.siteValidationMessage,
            ),
            FormItemVertical(
              leftLabel: 'Assignee (*)',
              leftChild: const AssigneeSelectField(),
              leftValidationMessage: state.assigneeValidationMessage,
              rightLabel: 'Due By',
              rightChild: const DueByDatePicker(),
            ),
            const FormItemVertical(
              leftLabel: 'Company',
              leftChild: CompanySelectField(),
              rightLabel: 'Awareness Category',
              rightChild: CategorySelectField(),
            ),
            const FormItemVertical(
              leftLabel: 'Project',
              leftChild: ProjectSelectField(),
              rightLabel: 'Location',
              rightChild: LocationInputBox(),
            ),
            FormItemVertical(
              leftLabel: 'Notes',
              leftChild: const NotesTextField(),
              secondaryRightChild: Container(),
            )
          ],
        );
      },
    );
  }
}
