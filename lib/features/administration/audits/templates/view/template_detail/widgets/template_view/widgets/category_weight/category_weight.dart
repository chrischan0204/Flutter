import '/common_libraries.dart';
import 'widgets/widgets.dart';

class CategoryWeightView extends StatelessWidget {
  const CategoryWeightView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CategoryWeightHeaderView(),
        const CustomDivider(),
        Row(
          children: const [
            Expanded(child: ByQuestionCountView()),
            SizedBox(width: 30),
            Expanded(child: ByMaxPointsView())
          ],
        ),
      ],
    );
  }
}
