import '/common_libraries.dart';
import 'widgets/widget.dart';

class QuestionsListView extends StatelessWidget {
  const QuestionsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuestionItemView(),
        QuestionItemView(),
      ],
    );
  }
}
