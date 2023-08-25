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
          BlocBuilder<ActionItemDetailBloc, ActionItemDetailState>(
            builder: (context, state) {
              if (state.parentInfomationLoadStatus.isLoading) {
                return const Center(child: Loader());
              }
              if (state.actionItem != null) {
                if (state.actionItem!.source == 'Audit') {
                  return const AuditViewForActionItem();
                } else if (state.actionItem!.source == 'Observation') {
                  return const ObservationViewForActionItem();
                }
                if (state.actionItem!.source == 'Observation, Audit') {
                  return CustomTabBar(
                    activeIndex: 0,
                    tabs: const {
                      'Observation': ObservationViewForActionItem(),
                      'Audit': AuditViewForActionItem(),
                    },
                    onTabClick: (current, previous) async {
                      return true;
                    },
                  );
                }
              }

              return Container();
            },
          )
        ],
      ),
    );
  }
}
