import '/common_libraries.dart';

class MarkAsClosedCheckBox extends StatelessWidget {
  const MarkAsClosedCheckBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditAssessmentBloc, EditAssessmentState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Mark as closed:',
              style: textSemiBold14,
            ),
            Checkbox(
              value: state.markAsClosed,
              onChanged: (markAsClosed) =>
                  context.read<EditAssessmentBloc>().add(
                        EditAssessmentMarkAsClosedChanged(
                            markAsClosed: markAsClosed!),
                      ),
            )
          ],
        );
      },
    );
  }
}
