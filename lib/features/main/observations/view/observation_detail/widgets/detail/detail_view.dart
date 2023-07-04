import '/common_libraries.dart';
import 'widgets/widgets.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key});

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
            DetailItemView1(
              label: 'Observation',
              content: observation.name ?? '',
            ),
            DetailItemView1(
              label: 'Location',
              content: observation.area,
            ),
            DetailItemView1(
              label: 'Response',
              content: 'Reported via ${observation.response}',
            ),
            DetailItemView2(
              rightLabel: 'Reported At',
              rightContent: observation.formatedReportedAt ?? '--',
              leftLabel: 'Reported By',
              leftContent: observation.reportedBy,
            ),
            DetailItemView2(
              rightContent: observation.reportedPriorityLevel,
              rightLabel: 'Reported Level',
              leftLabel: 'Reported Via',
              leftContent: observation.reportedVia,
            ),
          ],
        );
      },
    );
  }
}
