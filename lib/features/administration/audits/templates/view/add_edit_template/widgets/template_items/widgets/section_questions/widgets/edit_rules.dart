import '/common_libraries.dart';

class EditRulesView extends StatelessWidget {
  const EditRulesView({super.key});

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
              'Edit Rules',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Text(
            'Please note the following while making edits to the template',
            style: TextStyle(),
          )
        ],
      ),
    );
  }
}
