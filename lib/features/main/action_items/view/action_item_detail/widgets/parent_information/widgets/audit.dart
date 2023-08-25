import '../../action_item_information.dart';
import '/common_libraries.dart';

class AuditViewForActionItem extends StatelessWidget {
  const AuditViewForActionItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActionItemDetailBloc, ActionItemDetailState>(
      builder: (context, state) {
        if (state.auditQuestionOnActionitem != null) {
          final auditQuestionOnActionitem = state.auditQuestionOnActionitem!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ActionItemInformationItemView(
                label: 'Audit',
                content: auditQuestionOnActionitem.auditName ?? '--',
              ),
              ActionItemInformationItemView(
                label: 'ID',
                content: auditQuestionOnActionitem.auditNumber ?? '--',
              ),
              ActionItemInformationItemView(
                label: 'Site',
                content: auditQuestionOnActionitem.siteName ?? '--',
              ),
              ActionItemInformationItemView(
                label: 'Company',
                content: auditQuestionOnActionitem.companies ?? '--',
              ),
              ActionItemInformationItemView(
                label: 'Project',
                content: auditQuestionOnActionitem.projectName ?? '--',
              ),
              ActionItemInformationItemView(
                label: 'Created By',
                content: auditQuestionOnActionitem.createdBy ?? '--',
              ),
              ActionItemInformationItemView(
                label: 'Audit Date',
                content: auditQuestionOnActionitem.formatedAuditDate,
              ),
              CustomBottomBorderContainer(
                padding: inset12,
                child: Text(
                  'For question',
                  style: textSemiBold14,
                ),
              ),
              CustomBottomBorderContainer(
                padding: inset12,
                child: Text(
                  auditQuestionOnActionitem.question ?? '--',
                  style: textNormal14,
                ),
              )
            ],
          );
        }
        return Container();
      },
    );
  }
}
