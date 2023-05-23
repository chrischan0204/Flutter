import '/common_libraries.dart';

class SaveQuestionButton extends StatelessWidget {
  final VoidCallback? onMinimizeQuestion;
  const SaveQuestionButton({
    super.key,
    this.onMinimizeQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
    );
  }
}
