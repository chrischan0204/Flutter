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
              ElevatedButton(
                onPressed: () => context
                    .read<EditAssessmentBloc>()
                    .add(EditAssessmentIsEditingChanged()),
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        state.isEditing ? successColor : primaryColor),
                child:
                    BlocBuilder<ObservationDetailBloc, ObservationDetailState>(
                  builder: (context, detailState) {
                    return Text(
                      state.isEditing
                          ? 'Submit'
                          : detailState.observation?.assessed == false
                              ? 'Add Assessment'
                              : 'Edit Assessment',
                      style: textNormal12.copyWith(color: Colors.white),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
