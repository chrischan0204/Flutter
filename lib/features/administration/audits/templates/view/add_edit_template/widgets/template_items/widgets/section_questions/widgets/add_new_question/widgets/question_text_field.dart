import '/common_libraries.dart';

class QuestionTextField extends StatefulWidget {
  final TemplateSectionItem templateSectionItem;

  const QuestionTextField({
    super.key,
    required this.templateSectionItem,
  });

  @override
  State<QuestionTextField> createState() => _QuestionTextFieldState();
}

class _QuestionTextFieldState extends State<QuestionTextField> {
  TextEditingController questionController = TextEditingController();

  @override
  void dispose() {
    questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String getHintText(int level) {
      switch (level) {
        case 0:
          return 'Type question here.....';
        case 1:
          return 'Type L1 Follow up question here.....';
        default:
          return 'Type Feedback Level two question here.....';
      }
    }

    return BlocConsumer<TemplateDesignerBloc, TemplateDesignerState>(
      listener: (context, state) {
        questionController.text = state
                .currentTemplateSectionItemByLevel(state.level)
                ?.question
                ?.name ??
            '';
      },
      listenWhen: (previous, current) => previous.level != current.level,
      // current.templateSectionItem != previous.templateSectionItem,
      builder: (context, state) {
        final templateSectionItem =
            state.currentTemplateSectionItemByLevel(state.level);
        return CustomTextField(
          key: ValueKey(templateSectionItem?.id),
          initialValue: templateSectionItem?.question?.name,
          // controller: questionController,
          hintText: getHintText(state.level),
          minLines: 3,
          height: null,
          maxLines: 100,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 10,
          ),
          onChanged: (value) => context.read<TemplateDesignerBloc>().add(
                TemplateDesignerQuestionChanged(
                  question: value,
                  templateSectionItemId:
                      widget.templateSectionItem.id ?? emptyGuid,
                ),
              ),
        );
      },
    );
  }
}
