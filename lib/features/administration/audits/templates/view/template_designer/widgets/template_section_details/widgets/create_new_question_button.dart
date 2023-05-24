import '/common_libraries.dart';

class CreateNewQuestionButton extends StatefulWidget {
  const CreateNewQuestionButton({
    super.key,
  });

  @override
  State<CreateNewQuestionButton> createState() =>
      _CreateNewQuestionButtonState();
}

class _CreateNewQuestionButtonState extends State<CreateNewQuestionButton> {
  late TemplateDesignerBloc templateDesignerBloc;

  @override
  void initState() {
    templateDesignerBloc = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onPressed: () =>
          templateDesignerBloc.add(TemplateDesignerNewQuestionButtonClicked()),
      child: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Text(
          'New Question',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
