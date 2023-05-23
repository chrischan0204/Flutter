import '/common_libraries.dart';
import 'widgets/widgets.dart';

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
            ResponseScaleItemView(
              response: 'Yes',
              include: true,
              followUpQuestion: followUpQuestion,
            ),
            ResponseScaleItemView(
              response: 'No',
              include: true,
              followUpQuestion: followUpQuestion,
            ),
            ResponseScaleItemView(
              response: 'Maybe',
              include: false,
              followUpQuestion: followUpQuestion,
            ),
            ResponseScaleItemView(
              response: 'Not applicable',
              include: false,
              followUpQuestion: followUpQuestion,
            ),
            ResponseScaleItemView(
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
