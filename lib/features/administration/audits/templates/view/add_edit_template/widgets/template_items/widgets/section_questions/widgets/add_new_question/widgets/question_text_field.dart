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
                .question
                ?.name ??
            '';
      },
      listenWhen: (previous, current) => previous.level != current.level,
      builder: (context, state) {
        return CustomTextField(
          controller: questionController,
          hintText: getHintText(state.level),
          height: 100,
          minLines: 3,
          maxLines: 100,
          onChanged: (value) => context.read<TemplateDesignerBloc>().add(
                TemplateDesignerQuestionChanged(
                  responseScaleId: emptyGuid,
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
