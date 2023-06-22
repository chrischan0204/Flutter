import '../../../../../../../common_libraries.dart';
import '../../widgets/widgets.dart';

class AuditDetailView2 extends StatelessWidget {
  const AuditDetailView2({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        children: const [
          AuditDetailItemView(
            label: 'Created on',
            content: '14th May 2023',
          ),
          AuditDetailItemView(
            label: 'Status',
            content: 'In progress',
          ),
          AuditDetailItemView(
            label: 'Questions',
            content: '43',
          ),
          AuditDetailItemView(
            label: 'Project',
            content: '--',
          ),
          AuditDetailItemView(
            label: 'Action items',
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
