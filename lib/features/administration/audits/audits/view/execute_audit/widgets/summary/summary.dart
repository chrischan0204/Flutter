import '../../../../../../../../common_libraries.dart';
import 'widgets/widgets.dart';

class SummaryView extends StatelessWidget {
  const SummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomBottomBorderContainer(
            padding: inset20,
            child: Text(
              'SA0029-23',
              style: textSemiBold20,
            ),
          ),
          Padding(
            padding: inset20,
            child: Row(
              children: const [
                Spacer(),
                SummaryItemView(
                  title: 'Answered',
                  content: '12 of 28 Questions',
                ),
                Spacer(flex: 2),
                SummaryItemView(
                  title: 'Answered',
                  content: '12 of 28 Questions',
                ),
                Spacer(flex: 2),
                SummaryItemView(
                  title: 'Answered',
                  content: '12 of 28 Questions',
                ),
                Spacer(flex: 2),
                SummaryItemView(
                  title: 'Answered',
                  content: '12 of 28 Questions',
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
