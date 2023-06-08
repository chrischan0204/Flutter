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
          const QuestionItemView(
            name: 'Are there any visible loose wires hanging from the ceiling?',
            score: '10 + 3',
          ),
          const QuestionItemView(
            name: 'Are there any visible signs of damage to the circuit box?',
            score: '2 + 0',
          ),
          const QuestionItemView(
            name: 'Are there any visible loose wires hanging from the ceiling?',
            score: '10 + 3',
          ),
        ],
      ),
    );
  }
}
