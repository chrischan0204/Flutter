import '/common_libraries.dart';
import '../../../../form_item.dart';

class FollowUpCloseoutTextField extends StatelessWidget {
  const FollowUpCloseoutTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditAssessmentBloc, EditAssessmentState>(
      builder: (context, state) {
        return ObservationDetailFormItemView(
          label: 'Follow up closeout',
          content: CustomTextField(
            // key: ValueKey(state.loadedAudit?.id),
            initialValue: state.followUpCloseout,
            hintText: 'Follow up comments...',
            minLines: 3,
            height: null,
            maxLines: 100,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 10,
            ),
            onChanged: (followUpCloseout) =>
                context.read<EditAssessmentBloc>().add(
                      EditAssessmentFollowUpCloseoutChanged(
                          followUpCloseout: followUpCloseout),
                    ),
          ),
        );
      },
    );
  }
}
