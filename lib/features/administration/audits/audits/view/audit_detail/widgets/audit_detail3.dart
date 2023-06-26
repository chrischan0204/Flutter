import '../../../../../../../common_libraries.dart';
import '../../widgets/widgets.dart';

class AuditDetailView3 extends StatelessWidget {
  const AuditDetailView3({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: BlocBuilder<AuditDetailBloc, AuditDetailState>(
        builder: (context, state) {
          final audit = state.audit!;
          return Column(
            children: [
              AuditDetailItemView(
                label: 'Area',
                content: audit.area,
              ),
              AuditDetailItemView(
                label: 'Companies',
                content: audit.companies,
                twoLines: true,
              ),
              AuditDetailItemView(
                label: 'Inspectors',
                content: audit.inspectors,
                twoLines: true,
              ),
            ],
          );
        },
      ),
    );
  }
}
