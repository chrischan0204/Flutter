import '/common_libraries.dart';

class QuestionsHeaderView extends StatelessWidget {
  const QuestionsHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightBlueAccent,
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Questions in this template',
            style: TextStyle(fontSize: 18),
          ),
          CustomSingleSelect(
            hint: 'Show all category questions',
            width: 400,
            items: const {
              'Show all category questions': 'Show all category questions',
              'Electric Inspection': 'Electric Inspection',
              'Signage Inspection': 'Signage Inspection'
            },
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
