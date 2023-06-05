import '/common_libraries.dart';

import 'widgets/widgets.dart';

class TemplateView extends StatelessWidget {
  const TemplateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TemplateDetailHeaderView(title: 'Template for Crown project'),
        const CustomDivider(),
        LayoutBuilder(builder: (context, constraints) {
          return Row(
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
          );
        }),
        const CustomDivider(),
        const SummaryView(),
      ],
    );
  }
}
