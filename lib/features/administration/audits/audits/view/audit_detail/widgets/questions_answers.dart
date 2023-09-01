import '../../../../../../../common_libraries.dart';
import 'comment_list.dart';

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
    return BlocConsumer<AuditDetailBloc, AuditDetailState>(
      listener: (context, state) async {
        await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) =>
              AuditDetailCommentListView(commentList: state.commentList),
        );
      },
      listenWhen: (previous, current) =>
          previous.commentListLoadStatus != current.commentListLoadStatus &&
          current.commentListLoadStatus.isSuccess,
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
                  iconButton: IconButton(
                      onPressed: question.parentId == null
                          ? () => context.read<AuditDetailBloc>().add(
                              AuditDetailQuestionCommentListLoaded(
                                  questionId: question.sectionItemId))
                          : null,
                      icon: PhosphorIcon(
                        PhosphorIcons.regular.chatCircleDots,
                        color: primaryColor,
                      )),
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
  final Widget? iconButton;
  const QuestionItemView({
    super.key,
    required this.question,
    required this.score,
    required this.answer,
    this.isSubQuestion = false,
    this.isTitle = false,
    this.iconButton,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: isSubQuestion ? insetx20y10.copyWith(left: 50) : insetx20y10,
      child: Row(
        children: [
          Expanded(
            flex: 5,
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
          Expanded(
            child: Text(
              answer,
              style:
                  isTitle ? const TextStyle(fontWeight: FontWeight.w600) : null,
            ),
          ),
          spacerx10,
          SizedBox(
            width: 70,
            child: Text(
              score,
              style:
                  isTitle ? const TextStyle(fontWeight: FontWeight.w600) : null,
            ),
          ),
          spacerx10,
          SizedBox(
            width: 80,
            child: isTitle || isSubQuestion ? Container() : iconButton,
          )
        ],
      ),
    );
  }
}
