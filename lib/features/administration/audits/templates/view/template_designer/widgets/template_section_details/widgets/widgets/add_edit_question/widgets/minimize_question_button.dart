import '/common_libraries.dart';

class MinimizeQuestionButton extends StatelessWidget {
  final VoidCallback? onMinimizeQuestion;
  const MinimizeQuestionButton({
    super.key,
    this.onMinimizeQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
    );
  }
}
