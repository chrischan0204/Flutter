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
              content: observation.description ?? '',
            ),
            DetailItemView1(
              label: 'Area',
              content: observation.area ?? '',
            ),
            DetailItemView2(
              rightLabel: 'Site',
              rightContent: observation.userReportedSiteName ?? '--',
              leftLabel: 'Response',
              leftContent: observation.response ?? '',
            ),
            DetailItemView2(
              rightLabel: 'Reported At',
              rightContent: observation.formatedReportedAt,
              leftLabel: 'Reported By',
              leftContent: observation.reportedBy ?? '',
            ),
            DetailItemView2(
              rightContent: observation.userReportedPriorityLevelName ?? '',
              rightLabel: 'Reported Level',
              leftLabel: 'Reported Via',
              leftContent: observation.reportedVia ?? '',
            ),
          ],
        );
      },
    );
  }
}
