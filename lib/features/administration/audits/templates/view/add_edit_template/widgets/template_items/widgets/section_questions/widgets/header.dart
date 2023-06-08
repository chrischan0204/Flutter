import '/common_libraries.dart';

class SectionQuestionsHeaderView extends StatelessWidget {
  const SectionQuestionsHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateDesignerBloc, TemplateDesignerState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                state.selectedTemplateSection == null
                    ? 'Summary Section'
                    : 'Questions for ${state.selectedTemplateSection!.name}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (state.selectedTemplateSection != null)
                ElevatedButton(
                  onPressed: () => context.read<TemplateDesignerBloc>().add(
                      const TemplateDesignerAddNewQuestionViewShowed(
                          showAddNewQuestionView: true)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 8,
                    ),
                  ),
                  child: const Text('Add Question'),
                ),
            ],
          ),
        );
      },
    );
  }
}
