import '../../../../../../../template_detail/widgets/template_view/widgets/widgets.dart';
import '/common_libraries.dart';
import 'widgets/widgets.dart';

class SummarySectionView extends StatelessWidget {
  const SummarySectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}