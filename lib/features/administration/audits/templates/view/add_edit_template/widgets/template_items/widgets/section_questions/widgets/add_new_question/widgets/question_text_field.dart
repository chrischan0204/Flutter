import '/common_libraries.dart';

class QuestionTextField extends StatelessWidget {
  final int level;

  const QuestionTextField({
    super.key,
    this.level = 0,
  });

  @override
  Widget build(BuildContext context) {
    String getHintText() {
      switch (level) {
        case 0:
          return 'Type question here.....';
        case 1:
          return 'Type L1 Follow up question here.....';
        default:
          return 'Type L1 Follow up question here.....';
      }
    }

    return CustomTextField(
      hintText: getHintText(),
      height: 100,
      minLines: 3,
      maxLines: 100,
      onChanged: (value) => context.read<TemplateDesignerBloc>().add(
            TemplateDesignerQuestionChanged(
              level: level,
              responseScaleId: emptyGuid,
              question: value,
            ),
          ),
    );
  }
}
