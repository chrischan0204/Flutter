import '/common_libraries.dart';

class UsageView extends StatelessWidget {
  const UsageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: lightGreenAccent,
            padding: const EdgeInsets.all(20.0),
            child: const Text(
              'Usage',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
