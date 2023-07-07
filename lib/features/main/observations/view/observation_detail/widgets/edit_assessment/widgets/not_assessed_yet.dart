import '/common_libraries.dart';
import 'assessment_detail/widgets/widgets.dart';

class NotAssessedYetView extends StatelessWidget {
  const NotAssessedYetView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObservationDetailBloc, ObservationDetailState>(
      builder: (context, state) {
        if (state.observation == null) {
          return Container();
        }

        final observation = state.observation!;
        return Column(
          children: [
            AssessmentDetailItemView(
              label: 'Assigned to',
              content: '',
            ),
            AssessmentDetailItemView(
              label: 'Assigned by',
              content: '',
            ),
            AssessmentDetailItemView(
              label: 'Assessment Status',
              content: 'Not yet assessed',
            ),
          ],
        );
      },
    );
  }
}
