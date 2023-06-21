import '/common_libraries.dart';
import 'widgets/widgets.dart';

class SummarySectionView extends StatelessWidget {
  const SummarySectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: inset20,
            child: Text(
              'Summary Section',
              style: textSemiBold14,
            ),
          ),
          Container(
            padding: inset20.copyWith(bottom: 100),
            decoration: BoxDecoration(border: Border.all(color: primaryColor)),
            child: Row(
              children: [
                const Expanded(
                  child: SectionSummaryView(),
                ),
                spacer20,
                Expanded(
                  child: Placeholder(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
