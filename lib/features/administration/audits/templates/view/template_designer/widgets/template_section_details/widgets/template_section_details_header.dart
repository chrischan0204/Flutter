import '/common_libraries.dart';
import 'create_new_question_button.dart';

class TemplateSectionDetailsHeader extends StatelessWidget {
  const TemplateSectionDetailsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Template section details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const CustomDivider(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<TemplateDesignerBloc, TemplateDesignerState>(
              builder: (context, state) {
                return Text(
                  state.selectedTemplateSection?.name ?? '',
                  style: const TextStyle(fontSize: 22),
                );
              },
            ),
            const CreateNewQuestionButton(),
          ],
        ),
      ],
    );
  }
}
