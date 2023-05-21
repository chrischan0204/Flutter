import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AddEditQuestion extends StatelessWidget {
  final String? question;
  final bool followUpQuestion;
  final VoidCallback? onMinimizeQuestion;
  const AddEditQuestion({
    super.key,
    this.question,
    this.followUpQuestion = false,
    this.onMinimizeQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Question(),
            SizedBox(width: 5),
            PossibleAnswersToQuestion(),
          ],
        ),
        const SizedBox(height: 30),
        ResponseLogicBuilder(followUpQuestion: followUpQuestion),
        const SizedBox(height: 20),
        followUpQuestion
            ? Container()
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: successColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      if (onMinimizeQuestion != null) {
                        onMinimizeQuestion!();
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Text(
                        'Save Question',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: purpleColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      if (onMinimizeQuestion != null) {
                        onMinimizeQuestion!();
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Text(
                        'Minimize Question',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
      ],
    );
  }
}
