import '/common_libraries.dart';

class Question extends StatelessWidget {
  const Question({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Question:',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
              const CustomDivider(),
              CustomTextField(
                height: 100,
                minLines: 6,
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
