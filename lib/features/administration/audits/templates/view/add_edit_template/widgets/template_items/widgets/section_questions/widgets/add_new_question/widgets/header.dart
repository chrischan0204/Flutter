import '/common_libraries.dart';

class AddNewQuestionHeaderView extends StatelessWidget {
  const AddNewQuestionHeaderView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Add Question',
            style: TextStyle(
              color: textBlue,
            ),
          ),
          TextButton(
            onPressed: () => context.read<TemplateDesignerBloc>().add(
                const TemplateDesignerAddNewQuestionViewShowed(
                    showAddNewQuestionView: false)),
            child: Text(
              'Back to list',
              style: TextStyle(
                color: lightBlue,
                decoration: TextDecoration.underline,
                decorationColor: lightBlue,
              ),
            ),
          )
        ],
      ),
    );
  }
}
