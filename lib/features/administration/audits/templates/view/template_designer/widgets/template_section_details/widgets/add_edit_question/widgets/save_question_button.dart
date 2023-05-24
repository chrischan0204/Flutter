import '/common_libraries.dart';

class SaveQuestionButton extends StatelessWidget {
  const SaveQuestionButton({
    super.key,
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
      onPressed: () {},
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
