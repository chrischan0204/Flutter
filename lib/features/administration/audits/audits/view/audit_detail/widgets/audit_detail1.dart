import '../../../../../../../common_libraries.dart';
import '../../widgets/widgets.dart';

class AuditDetailView1 extends StatelessWidget {
  const AuditDetailView1({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        children: const [
          AuditDetailItemView(
            label: 'Owner',
            content: 'Amy Admas',
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
          AuditDetailItemView(
            label: 'Completion',
            content: '33% (11 of 33)',
            highlighted: true,
          ),
          AuditDetailItemView(
            label: 'Observations',
            content: '2',
            highlighted: true,
          ),
        ],
      ),
    );
  }
}
