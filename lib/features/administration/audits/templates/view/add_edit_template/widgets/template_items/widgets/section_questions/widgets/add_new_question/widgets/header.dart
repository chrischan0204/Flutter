import '/common_libraries.dart';

class AddNewQuestionHeaderView extends StatelessWidget {
  const AddNewQuestionHeaderView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: BlocBuilder<TemplateDesignerBloc, TemplateDesignerState>(
        builder: (context, state) {
          if (state.level == 0) {
            return Row(
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
            );
          } else {
            return Row(
              children: [
                TextButton(
                  onPressed: () => context
                      .read<TemplateDesignerBloc>()
                      .add(const TemplateDesignerLevelChanged(level: 0)),
                  child: Text(
                    'Question',
                    style: textNormal18.copyWith(
                      color: textBlue,
                      decoration: TextDecoration.underline,
                      decorationColor: textBlue,
                    ),
                  ),
                ),
                Text(
                  '>',
                  style: TextStyle(
                    color: textBlue,
                  ),
                ),
                TextButton(
                  onPressed: () => context
                      .read<TemplateDesignerBloc>()
                      .add(const TemplateDesignerLevelChanged(level: 1)),
                  child: Text(
                    'Follow up Question (For Option=\'${state.currentTemplateSectionItemByLevel(1).response!.name}\')',
                    style: textNormal14.copyWith(
                      decoration: TextDecoration.underline,
                      color: textBlue,
                      decorationColor: textBlue,
                    ),
                  ),
                ),
                if (state.level == 2)
                  Text(
                    '>',
                    style: TextStyle(
                      color: textBlue,
                    ),
                  ),
                if (state.level == 2)
                  Text(
                    'Level Two Follow up Question (For Option=\'${state.currentTemplateSectionItemByLevel(2).response!.name}\')',
                    style: textNormal12.copyWith(
                      color: textBlue,
                    ),
                  )
              ],
            );
          }
        },
      ),
    );
  }
}
