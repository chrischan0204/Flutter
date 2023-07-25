import '/common_libraries.dart';

class AssessmentHeaderView extends StatelessWidget {
  const AssessmentHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: inset20,
      backgroundColor: lightBlueAccent,
      child: BlocBuilder<EditAssessmentBloc, EditAssessmentState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                state.isEditing ? 'Assessment' : 'Assessment Reading',
                style: textSemiBold14,
              ),
              Row(
                children: [
                  if (state.isEditing)
                    ElevatedButton(
                      onPressed: () => context
                          .read<EditAssessmentBloc>()
                          .add(EditAssessmentIsEditingChanged()),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey),
                      child: Text(
                        'Cancel',
                        style: textNormal12.copyWith(color: Colors.white),
                      ),
                    ),
                  if (state.isEditing) spacerx10,
                  BlocBuilder<ObservationDetailBloc, ObservationDetailState>(
                    builder: (context, detailState) {
                      return ElevatedButton(
                        onPressed: detailState.observation?.isClosed == true
                            ? null
                            : () {
                                if (state.isEditing) {
                                  context
                                      .read<EditAssessmentBloc>()
                                      .add(EditAssessmentAdded());
                                } else {
                                  context
                                      .read<EditAssessmentBloc>()
                                      .add(EditAssessmentIsEditingChanged());
                                }
                              },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                state.isEditing ? successColor : primaryColor),
                        child: Text(
                          state.isEditing
                              ? detailState.observation?.assessedOn == null ? 'Add' : 'Update'
                              : detailState.observation?.assessedOn == null
                                  ? 'Add Assessment'
                                  : 'Edit Assessment',
                          style: textNormal12.copyWith(color: Colors.white),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
