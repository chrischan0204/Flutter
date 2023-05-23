import '/common_libraries.dart';

class PossibleAnswersToQuestion extends StatefulWidget {
  const PossibleAnswersToQuestion({super.key});

  @override
  State<PossibleAnswersToQuestion> createState() =>
      _PossibleAnswersToQuestionState();
}

class _PossibleAnswersToQuestionState extends State<PossibleAnswersToQuestion> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Possible answers to question:',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
              const CustomDivider(),
              CustomSingleSelect(
                  hint: 'Select response scale',
                  selectedValue: selectedValue,
                  items: const {
                    'Yes/No': 'Yes/No',
                    'Satisfactory/UnSatisfactory':
                        'Satisfactory/UnSatisfactory',
                    'Pass/Fail': 'Pass/Fail',
                    'Ratings': 'Ratings',
                    'Survey': 'Survey',
                  },
                  onChanged: (value) =>
                      setState(() => selectedValue = value.key))
            ],
          ),
        ),
      ),
    );
    ;
  }
}
