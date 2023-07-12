import '/common_libraries.dart';

class QuestionViewOptionSelectBox extends StatefulWidget {
  const QuestionViewOptionSelectBox({super.key});

  @override
  State<QuestionViewOptionSelectBox> createState() =>
      _QuestionViewOptionSelectBoxState();
}

class _QuestionViewOptionSelectBoxState
    extends State<QuestionViewOptionSelectBox> {
  @override
  void initState() {
    context
        .read<ExecuteAuditBloc>()
        .add(ExecuteAuditQuestionViewOptionLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExecuteAuditBloc, ExecuteAuditState>(
      builder: (context, state) {
        Map<String, Entity> items = {}..addEntries(state.optionViewList
            .map((option) => MapEntry(option.name ?? '', option)));
        return CustomSingleSelect(
          hint: 'Select Questions View',
          items: items,
          selectedValue: state.selectedQuestionViewOption?.name,
          onChanged: (value) => context.read<ExecuteAuditBloc>().add(
              ExecuteAuditQuestionViewOptionSelected(
                  questionViewOption: value.value)),
        );
      },
    );
  }
}
