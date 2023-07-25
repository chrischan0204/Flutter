import '/common_libraries.dart';

class NotifySenderCheckBox extends StatelessWidget {
  const NotifySenderCheckBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditAssessmentBloc, EditAssessmentState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (MediaQuery.of(context).size.width > minDesktopWidth)
              Text(
                'Notify sender:',
                style: textSemiBold14,
              ),
            Padding(
              padding: insetx20,
              child: Tooltip(
                message: 'Notify sender',
                child: Checkbox(
                  value: state.notifySender,
                  onChanged: (notifySender) =>
                      context.read<EditAssessmentBloc>().add(
                            EditAssessmentNotifySenderChanged(
                                notifySender: notifySender!),
                          ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
