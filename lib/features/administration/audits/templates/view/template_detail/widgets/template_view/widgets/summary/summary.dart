import '/common_libraries.dart';
import 'widgets/widgets.dart';

class SummaryView extends StatelessWidget {
  const SummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
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
          const Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: SummaryItemView(
              backgroundColor: Color(0xff8e70c1),
              title: 'Last Used In:',
              content: '028-19939',
            ),
          ),
          Flexible(flex: 1, child: Container()),
          const Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: SummaryItemView(
              backgroundColor: Color(0xff8e70c1),
              title: 'Last Audit Status:',
              content: 'In review',
            ),
          ),
          Flexible(flex: 1, child: Container()),
          const Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: SummaryItemView(
              backgroundColor: Color(0xff8e70c1),
              title: 'Used:',
              content: '13 Audits',
            ),
          ),
        ],
      ),
    );
  }
}
