import '../../../../../../../common_libraries.dart';

class QuestionsAndAnswersView extends StatefulWidget {
  const QuestionsAndAnswersView({super.key});

  @override
  State<QuestionsAndAnswersView> createState() =>
      _QuestionsAndAnswersViewState();
}

class _QuestionsAndAnswersViewState extends State<QuestionsAndAnswersView> {
  @override
  void initState() {
    context
        .read<AuditDetailBloc>()
        .add(AuditDetailAuditCompletedQuestionsWithFollowupsListLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuditDetailBloc, AuditDetailState>(
      builder: (context, state) {
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
              for (final question
                  in state.auditCompletedQuestionsWithFollowupsList)
                QuestionItemView(
                  question: question.question ?? '',
                  answer: question.response ?? '',
                  score: question.score.toString(),
                  isSubQuestion: question.parentId != null,
                ),
            ],
          ),
        );
      },
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
          spacerx10,
          SizedBox(
            width: 150,
            child: Text(
              answer,
              style:
                  isTitle ? const TextStyle(fontWeight: FontWeight.w600) : null,
            ),
          ),
          spacerx10,
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
