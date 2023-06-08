import '/common_libraries.dart';

class QuestionTextField extends StatefulWidget {
  final String? question;
  final bool child;
  final String templateSectionItemId;
  const QuestionTextField({
    super.key,
    this.question,
    required this.child,
    required this.templateSectionItemId,
  });

  @override
  State<QuestionTextField> createState() => _QuestionTextFieldState();
}

class _QuestionTextFieldState extends State<QuestionTextField> {
  late TemplateDesignerBloc templateDesignerBloc;

  @override
  void initState() {
    templateDesignerBloc = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Question:',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
              const CustomDivider(),
              CustomTextField(
                initialValue: widget.question,
                height: 100,
                minLines: 6,
                // onChanged: (value) => templateDesignerBloc.add(
                //   TemplateDesignerQuestionChanged(
                //     child: widget.child,
                //     templateSectionItemId: widget.templateSectionItemId,
                //     responseScaleId: emptyGuid,
                //     question: value,
                //   ),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
