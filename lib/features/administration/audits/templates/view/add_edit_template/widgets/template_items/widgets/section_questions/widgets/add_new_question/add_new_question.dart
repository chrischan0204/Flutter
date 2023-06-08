import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AddNewQuestionView extends StatelessWidget {
  const AddNewQuestionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const AddNewQuestionHeaderView(),
              const QuestionTextField(),
            ],
          ),
        ),
      ],
    );
  }
}
