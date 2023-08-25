import '../../../../../../../common_libraries.dart';

class QuestionsAndAnswersView extends StatelessWidget {
  const QuestionsAndAnswersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomBottomBorderContainer(
            padding: inset10,
            child: Text(
              'Questions and Answers',
              style: textSemiBold16,
            ),
          ),
          const QuestionItemView(
            question: 'Question',
            answer: 'Answer',
            score: 'Score',
            isTitle: true,
          ),
          const QuestionItemView(
            question:
                'Were the leaflets on social distancing distributed at least 3 months before the lockdown was removed?',
            answer: 'Yes',
            score: '2',
          ),
          const QuestionItemView(
            question:
                'Was the distribution elctronic as well as printed copies?',
            answer: 'Yes',
            score: '2',
            isSubQuestion: true,
          ),
          const QuestionItemView(
            question: 'Was the open rate on electronic emails about 50%?',
            answer: 'Yes',
            score: '2',
            isSubQuestion: true,
          ),
          const QuestionItemView(
            question:
                'Were there visible signs in the office that promoted social distancing?',
            answer: 'Satisfactory',
            score: '2',
          ),
          const QuestionItemView(
            question:
                'Were the workstations wiped everyday by the cleaning crew?',
            answer: 'Yes',
            score: '2',
          ),
          const QuestionItemView(
            question: 'Were FDA approved disinfectants used for this purpose?',
            answer: 'Yes',
            score: '2',
            isSubQuestion: true,
          ),
          const QuestionItemView(
            question:
                'Were the leaflets on social distancing distributed at least 3 months before the lockdown was removed?',
            answer: 'Yes',
            score: '2',
          ),
        ],
      ),
    );
  }
}

class QuestionItemView extends StatelessWidget {
  final String question;
  final String answer;
  final String score;
  final bool isSubQuestion;
  final bool isTitle;
  const QuestionItemView({
    super.key,
    required this.question,
    required this.score,
    required this.answer,
    this.isSubQuestion = false,
    this.isTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: isSubQuestion ? insetx20y10.copyWith(left: 50) : insetx20y10,
      child: Row(
        children: [
          Expanded(
            child: Text(
              question,
              style: isSubQuestion
                  ? const TextStyle(color: Color(0xff666666))
                  : isTitle
                      ? const TextStyle(fontWeight: FontWeight.w600)
                      : null,
            ),
          ),
          SizedBox(
            width: 150,
            child: Text(
              answer,
              style:
                  isTitle ? const TextStyle(fontWeight: FontWeight.w600) : null,
            ),
          ),
          SizedBox(
            width: 60,
            child: Text(
              score,
              style:
                  isTitle ? const TextStyle(fontWeight: FontWeight.w600) : null,
            ),
          ),
        ],
      ),
    );
  }
}
