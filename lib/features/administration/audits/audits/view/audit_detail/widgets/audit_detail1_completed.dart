import '../../../../../../../common_libraries.dart';
import '../../widgets/detail_item.dart';
import 'action_item_list.dart';
import 'observation_list.dart';

class AuditDetail1CompletedView extends StatelessWidget {
  const AuditDetail1CompletedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: BlocBuilder<AuditDetailBloc, AuditDetailState>(
        builder: (context, state) {
          final audit = state.auditSummary!;
          return Column(
            children: [
              AuditDetailItemView(
                label: 'Owner',
                content: audit.owner ?? '--',
              ),
              AuditDetailItemView(
                label: 'Completed On',
                content: audit.formatedLastExecutedOn,
              ),
              AuditDetailItemView(
                label: 'Score',
                content:
                    '${audit.answeredQuestions} of ${audit.questions} / (${audit.completedPercent}%)',
              ),
              AuditDetailItemView(
                label: 'Site',
                content: audit.siteName ?? '--',
              ),
              AuditDetailItemView(
                label: 'Action items',
                highlighted: audit.actionItems != 0,
                content: audit.actionItems.toString(),
                onClick: () async {
                  await showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => AuditDetailActionItemListView(
                        actionItemList: state.actionItemList),
                  );
                },
              ),
              AuditDetailItemView(
                label: 'Observations',
                highlighted: audit.observations != 0,
                content: audit.observations.toString(),
                onClick: () async {
                  await showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => AuditDetailObservationListView(
                        observationList: state.observationList),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
