import '/common_libraries.dart';
import 'widgets/widgets.dart';

class QuestionsForSectionView extends StatelessWidget {
  const QuestionsForSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Question',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Score',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          const CustomDivider(),
          BlocBuilder<TemplateDesignerBloc, TemplateDesignerState>(
            builder: (context, state) {
              if (state.sectionItemQuestionListLoadStatus.isLoading) {
                return const Center(
                  child: Loader(),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: state.templateQuestionList
                    .map((e) => QuestionItemView(question: e))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
