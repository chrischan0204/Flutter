import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AuditSectionsView extends StatelessWidget {
  const AuditSectionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: const Color(0xffF9FCFC),
      child: Padding(
        padding: inset10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: grey))),
              padding: inset20,
              child: Text(
                'Audit Sections',
                style: textSemiBold14,
              ),
            ),
            Expanded(
              child: BlocBuilder<AuditQuestionsBloc, AuditQuestionsState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (final section in state.auditSectionList)
                          AuditSectionItemView(
                            active: section.id == state.selectedAuditSectionId,
                            auditSection: section,
                            disabled: section.isNoIncluded,
                          )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
