import '/common_libraries.dart';
import 'response_scale_item.dart';

class ResponseLogicBuilder extends StatelessWidget {
  final bool followUpQuestion;
  const ResponseLogicBuilder({
    super.key,
    required this.followUpQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Response logic builder',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ),
            const CustomDivider(),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Yes/No response scale',
              ),
            ),
            ResponseScaleItem(
              response: 'Yes',
              include: true,
              followUpQuestion: followUpQuestion,
            ),
            ResponseScaleItem(
              response: 'No',
              include: true,
              followUpQuestion: followUpQuestion,
            ),
            ResponseScaleItem(
              response: 'Maybe',
              include: false,
              followUpQuestion: followUpQuestion,
            ),
            ResponseScaleItem(
              response: 'Not applicable',
              include: false,
              followUpQuestion: followUpQuestion,
            ),
            ResponseScaleItem(
              response: 'Input Required',
              include: false,
              followUpQuestion: followUpQuestion,
            ),
          ],
        ),
      ),
    );
  }
}
