import 'package:safety_eta/features/administration/audits/audits/view/audit_detail/widgets/widgets.dart';

import '../../../../../../../common_libraries.dart';
import '../../widgets/widgets.dart';

class AuditDetailView2 extends StatelessWidget {
  const AuditDetailView2({super.key});

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
                label: 'Status',
                content: audit.auditStatusName ?? '--',
              ),
              AuditDetailItemView(
                label: 'Completion',
                content:
                    '${audit.completedPercent}% (${audit.answeredQuestions} of ${audit.questions})',
              ),
              AuditDetailItemView(
                label: 'Sections',
                content: audit.sections.toString(),
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
                label: 'Images/Documents',
                highlighted: audit.documents != 0,
                content: audit.documents.toString(),
                onClick: () async {
                  await showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) =>
                        AuditDetailImageListView(imageList: state.documentList),
                  );
                },
              ),
              AuditDetailItemView(
                label: 'Inspectors',
                content: audit.inspectors ?? '--',
                twoLines: true,
              ),
            ],
          );
        },
      ),
    );
  }
}
