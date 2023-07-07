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
              if (state.actionItem != null) {
                if (state.actionItem!.source == 'Audit') {
                  return const AuditViewForActionItem();
                } else if (state.actionItem!.source == 'Observation') {
                  return const ObservationViewForActionItem();
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
