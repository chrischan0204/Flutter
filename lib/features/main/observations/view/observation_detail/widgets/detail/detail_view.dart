import '/common_libraries.dart';
import 'widgets/widgets.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        DetailItemView1(
          label: 'Observation',
          content: 'Slippery stairs by the admin office',
        ),
        DetailItemView1(
          label: 'Location',
          content: 'East entrance going to second floor',
        ),
        DetailItemView1(
          label: 'Follow up',
          content: 'Reported via safety app',
        ),
        DetailItemView2(
          rightContent: 'Reported At',
          rightLabel: '13th May 2021 at 2:31 PM',
          leftLabel: 'Reported By',
          leftContent: 'Frank Curtis',
        ),
        DetailItemView2(
          rightContent: 'Reported Level',
          rightLabel: 'High',
          leftLabel: 'Reported Via',
          leftContent: 'PIMS Safety App',
        ),
      ],
    );
  }
}
