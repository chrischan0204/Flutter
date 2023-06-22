import '../../../../../../widgets/detail_item.dart';
import '/common_libraries.dart';

class AuditSummary2 extends StatelessWidget {
  const AuditSummary2({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        children: const [
          AuditDetailItemView(
            label: 'Project',
            content: '--',
          ),
          AuditDetailItemView(
            label: 'Completion',
            content: '11 of 33',
            highlighted: true,
          ),
          AuditDetailItemView(
            label: 'Observations',
            content: '2',
            highlighted: true,
          ),
          AuditDetailItemView(
            label: 'Action Items',
            content: '4',
            highlighted: true,
          ),
          AuditDetailItemView(
            label: 'Images',
            content: '4',
            highlighted: true,
          ),
        ],
      ),
    );
  }
}
