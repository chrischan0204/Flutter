import '/common_libraries.dart';
import 'widgets/widgets.dart';

class SummaryView extends StatelessWidget {
  const SummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: BlocBuilder<TemplateDetailBloc, TemplateDetailState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: SummaryItemView(
                  backgroundColor: primaryColor,
                  title: 'Avg Audit Score:',
                  content: '82 of 112 points',
                ),
              ),
              Flexible(flex: 1, child: Container()),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: SummaryItemView(
                  backgroundColor: const Color(0xff8e70c1),
                  title: 'Last Used In:',
                  content: state.templateUsageSummary?.auditNumber ?? '',
                ),
              ),
              Flexible(flex: 1, child: Container()),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: SummaryItemView(
                  backgroundColor: const Color(0xff8e70c1),
                  title: 'Last Audit Status:',
                  content: state.templateUsageSummary?.auditStatus ?? '',
                ),
              ),
              Flexible(flex: 1, child: Container()),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: SummaryItemView(
                  backgroundColor: const Color(0xff8e70c1),
                  title: 'Used:',
                  content:
                      '${state.templateUsageSummary?.usedInAudits ?? ''} Audits',
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
