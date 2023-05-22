import '/common_libraries.dart';
import 'add_edit_question/add_edit_question.dart';

class Question extends StatefulWidget {
  final String question;

  const Question({
    super.key,
    required this.question,
  });

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  bool editQuestion = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CustomDivider(
          height: 30,
        ),
        Builder(builder: (context) {
          if (editQuestion) {
            return AddEditQuestion(
              question: widget.question,
              onMinimizeQuestion: () =>
                  setState(() => editQuestion = !editQuestion),
            );
          }
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              height: 80,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      decoration: const BoxDecoration(
                        color: Color(0xffdbe5d2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: RichText(
                          text: TextSpan(
                            text: 'Question: ',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: widget.question,
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: Center(
                      child: IconButton(
                        onPressed: () =>
                            setState(() => editQuestion = !editQuestion),
                        icon: const Icon(
                          PhosphorIcons.caretCircleDoubleDown,
                          size: 20,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 20),
      ],
    );
  }
}
