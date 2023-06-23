import '/common_libraries.dart';

class QuestionItemView extends StatelessWidget {
  const QuestionItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: inset10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: inset20,
              child: Text(
                'Q1: How well do the employees know about social distancing?',
                style: textSemiBold16,
              ),
            ),
            Row(
              children: const [
                Expanded(flex: 4, child: Placeholder()),
                Expanded(flex: 5, child: Placeholder()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
