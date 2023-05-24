import '/common_libraries.dart';
import 'widgets/widgets.dart';

class QuestionsView extends StatefulWidget {
  const QuestionsView({super.key});

  @override
  State<QuestionsView> createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<QuestionsView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateDesignerBloc, TemplateDesignerState>(
      builder: (context, state) {
        final sectionItemQuestionList =
            List.from(state.sectionItemQuestionList);
        sectionItemQuestionList.sort((a, b) => a.order - b.order);
        
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: sectionItemQuestionList
              .map((e) => QuestionView(question: e.name))
              .toList(),
        );
      },
    );
  }
}
