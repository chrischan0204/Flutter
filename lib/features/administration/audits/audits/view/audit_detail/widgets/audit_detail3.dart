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
                content: 'Section 3 Parking garage',
              ),
              AuditDetailItemView(
                label: 'Companies',
                content:
                    'Lucas Landscaping, Constellation Fencing and picketing llc., Rider group concrete inc and Gartner Electric',
                twoLines: true,
              ),
              AuditDetailItemView(
                label: 'Inspectors',
                content: 'Frank Hurt, Brian Trippi and George Kiltman',
                twoLines: true,
              ),
            ],
          );
        },
      ),
    );
  }
}
