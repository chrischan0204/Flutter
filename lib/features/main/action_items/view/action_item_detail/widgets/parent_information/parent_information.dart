import '/common_libraries.dart';
import 'widgets/widgets.dart';

class ParentInformationView extends StatelessWidget {
  const ParentInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomBottomBorderContainer(
            padding: inset20,
            child: Text(
              'Parent Information',
              style: textSemiBold16,
            ),
          ),
          CustomTabBar(
            activeIndex: 0,
            tabs: const {
              'Audit': AuditViewForActionItem(),
              'Observation': ObservationViewForActionItem(),
            },
            onTabClick: (index) async {
              return true;
            },
          )
        ],
      ),
    );
  }
}
