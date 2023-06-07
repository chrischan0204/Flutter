import '../../../../../template_detail/widgets/template_view/widgets/widgets.dart';
import '/common_libraries.dart';
import 'widgets/widgets.dart';

class SectionQuestionsView extends StatelessWidget {
  const SectionQuestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Summary Section',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: primaryColor,
                width: 0.5,
              ),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            child: Column(
              children: [
                Row(
                  children: const [
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: TemplateSectionView(),
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: CategoryWeightView(),
                    )
                  ],
                ),
                const CustomDivider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: UsageView(),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: EditRulesView(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
