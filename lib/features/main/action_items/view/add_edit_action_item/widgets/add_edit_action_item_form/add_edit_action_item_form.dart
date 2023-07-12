import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AddEditActionItemFormView extends StatelessWidget {
  AddEditActionItemFormView({super.key});

  final Widget _notesInputBox = CustomBottomBorderContainer(
    child: Column(
      children: [
        Padding(
          padding: inset4,
          child: Row(
            children: [
              Text(
                '',
                style: textNormal12.copyWith(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: insetx20,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Notes:',
                  style: textSemiBold12,
                ),
              ),
              const Expanded(
                flex: 4,
                child: NotesTextField(),
              )
            ],
          ),
        ),
        Padding(
          padding: inset4,
          child: Row(
            children: [
              Text(
                '',
                style: textNormal12.copyWith(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

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
              rightLabel: 'Due By (*)',
              rightChild: const DueByDatePicker(),
              rightValidationMessage: state.dueByValidationMessage,
            ),
            const FormItemVertical(
              leftLabel: 'Company',
              leftChild: CompanySelectField(),
              rightLabel: 'Category',
              rightChild: CategorySelectField(),
            ),
            const FormItemVertical(
              leftLabel: 'Project',
              leftChild: ProjectSelectField(),
              rightLabel: 'Area',
              rightChild: LocationInputBox(),
            ),
            _notesInputBox,
          ],
        );
      },
    );
  }
}
