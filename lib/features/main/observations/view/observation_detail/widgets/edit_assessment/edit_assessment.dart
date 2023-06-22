import '/common_libraries.dart';
import 'widgets/widgets.dart';

class EditAssessmentView extends StatelessWidget {
  const EditAssessmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          AssessmentHeaderView(),
          AssessmentFormView(),
        ],
      ),
    );
  }
}
