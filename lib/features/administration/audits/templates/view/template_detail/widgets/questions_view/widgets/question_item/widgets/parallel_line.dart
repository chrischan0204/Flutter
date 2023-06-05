import '/common_libraries.dart';

class ParallelLineView extends StatelessWidget {
  const ParallelLineView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            width: 1,
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
