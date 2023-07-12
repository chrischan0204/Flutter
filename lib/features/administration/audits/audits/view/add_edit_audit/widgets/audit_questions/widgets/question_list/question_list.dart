import '../../../../../../../../../../common_libraries.dart';
import 'widgets/widgets.dart';

class QuestionListView extends StatelessWidget {
  const QuestionListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        children: [
          const QuestionListHeaderView(),
          Expanded(
            child: Container(
              padding: inset10,
              decoration: BoxDecoration(border: Border.all(color: primaryColor)),
              child: const QuestionsListBodyView(),
            ),
          ),
        ],
      ),
    );
  }
}
