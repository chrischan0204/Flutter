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
            style: textNormal18.copyWith(color: textBlue),
          ),
          TextButton(
            onPressed: () => context.read<TemplateDesignerBloc>().add(
                const TemplateDesignerAddNewQuestionViewShowed(
                    showAddNewQuestionView: false)),
            child: Text(
              'Back to list',
              style: textNormal12.copyWith(
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
