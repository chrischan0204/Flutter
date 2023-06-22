import '/common_libraries.dart';

class AssessmentHeaderView extends StatelessWidget {
  const AssessmentHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: inset20,
      color: lightBlueAccent,
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
                child: Text(
                  state.isEditing ? 'Submit' : 'Edit Assessment',
                  style: textNormal12.copyWith(color: Colors.white),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
