import '/common_libraries.dart';
import 'widgets/widgets.dart';

class TemplateItemsView extends StatelessWidget {
  final String templateId;
  const TemplateItemsView({
    super.key,
    required this.templateId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'A page to define a template. A template\'s sections, questions and other composition can be defined here.',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const CustomDivider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: TemplateSectionsView(templateId: templateId),
            ),
            const SizedBox(width: 10),
            const Flexible(
              flex: 8,
              fit: FlexFit.tight,
              child: SectionQuestionsView(),
            )
          ],
        )
      ],
    );
  }
}
