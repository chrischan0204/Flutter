import '/common_libraries.dart';
import 'widgets/widgets.dart';

class CategoryWeightView extends StatelessWidget {
  const CategoryWeightView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CategoryWeightHeaderView(),
        CustomDivider(),
        Row(
          children: [
            Expanded(child: ByQuestionCountView()),
            SizedBox(width: 30),
            Expanded(child: ByMaxPointsView())
          ],
        ),
      ],
    );
  }
}
