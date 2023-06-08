import '/common_libraries.dart';
import 'widgets/widgets.dart';

class SectionQuestionsView extends StatefulWidget {
  const SectionQuestionsView({super.key});

  @override
  State<SectionQuestionsView> createState() => _SectionQuestionsViewState();
}

class _SectionQuestionsViewState extends State<SectionQuestionsView> {
  bool showAddNewQuestionView = false;
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
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            child: BlocBuilder<TemplateDesignerBloc, TemplateDesignerState>(
              builder: (context, state) {
                if (state.selectedTemplateSection == null) {
                  return const SummarySectionView();
                } else if (state.showAddNewQuestionView) {
                  return BlocBuilder<TemplateDesignerBloc,
                      TemplateDesignerState>(
                    builder: (context, state) {
                      return AddNewQuestionView(
                        templateSectionItem: state.currentTemplateSectionItem(
                            state.level,
                            state.currentTemplateSectionItemId ?? emptyGuid),
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
