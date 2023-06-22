import '../../../../../../widgets/detail_item.dart';
import '/common_libraries.dart';

class AuditSummary1 extends StatelessWidget {
  const AuditSummary1({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        children: const [
          AuditDetailItemView(
            label: 'Owner',
            content: 'Amy Adams',
          ),
          AuditDetailItemView(
            label: 'Created on',
            content: '14th May 2023',
          ),
          AuditDetailItemView(
            label: 'Status',
            content: 'In progress',
          ),
          AuditDetailItemView(
            label: 'Last touched',
            content: '16th May 2023',
          ),
          AuditDetailItemView(
            label: 'Sections',
            content: '4',
          ),
          AuditDetailItemView(
            label: 'Site',
            content: 'Lakeshore Drive, Chicago',
          ),
        ],
      ),
    );
  }
}
