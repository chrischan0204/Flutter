import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AuditQuestionsHeaderView extends StatelessWidget {
  const AuditQuestionsHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: inset30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              'Audit Questions',
              style: textSemiBold20,
            ),
          ),
          const Expanded(flex: 2, child: QuestionViewOptionSelectBox()),
        ],
      ),
    );
  }
}
