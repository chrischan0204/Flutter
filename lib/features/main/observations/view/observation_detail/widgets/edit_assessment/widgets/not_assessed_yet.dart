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
              content: observation.assessedAs,
            ),
            AssessmentDetailItemView(
              label: 'Assigned by',
              content: observation.assessedBy,
            ),
            AssessmentDetailItemView(
              label: 'Assessment Status',
              content: observation.assessed == false ? 'Not yet assessed' : '',
            ),
          ],
        );
      },
    );
  }
}
