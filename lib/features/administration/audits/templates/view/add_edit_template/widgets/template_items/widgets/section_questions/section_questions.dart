import '/common_libraries.dart';
import 'widgets/widgets.dart';

class SectionQuestionsView extends StatelessWidget {
  final String templateId;
  const SectionQuestionsView({super.key, required this.templateId});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionQuestionsHeaderView(),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: primaryColor,
                width: 0.5,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: BlocBuilder<TemplateDesignerBloc, TemplateDesignerState>(
              builder: (context, state) {
                if (state.selectedTemplateSection == null) {
                  return SummarySectionView(templateId: templateId);
                } else if (state.showAddNewQuestionView) {
                  return BlocBuilder<TemplateDesignerBloc,
                      TemplateDesignerState>(
                    builder: (context, state) {
                      return AddNewQuestionView(
                        templateSectionItem: state
                            .currentTemplateSectionItemByLevel(state.level)!,
                      );
                    },
                  );
                } else {
                  return const QuestionsForSectionView();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
