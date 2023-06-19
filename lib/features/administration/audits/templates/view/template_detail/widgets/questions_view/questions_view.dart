import 'package:accordion/accordion.dart';

import '/common_libraries.dart';
import 'widgets/widgets.dart';

class QuestionsView extends StatelessWidget {
  final String templateId;
  const QuestionsView({
    super.key,
    required this.templateId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        QuestionsHeaderView(
          templateId: templateId,
        ),
        const CustomDivider(),
        BlocBuilder<TemplateDetailBloc, TemplateDetailState>(
          builder: (context, state) {
            return Accordion(
              maxOpenSections: 1,
              scaleWhenAnimating: false,
              openAndCloseAnimation: false,
              headerPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              headerBorderRadius: 0,
              contentBorderRadius: 0,
              contentVerticalPadding: 0,
              children: [
                for (final questionDetail in state.templateQuestionDetailList)
                  for (final templateSectionItem
                      in questionDetail.templateSectionItems)
                    TemplateSectionItemView(
                      templateSectionItem: templateSectionItem,
                      category: questionDetail.name,
                      context: context,
                      templateSectionId: questionDetail.id,
                      level: 1,
                    )
              ],
            );
          },
        ),
      ],
    );
  }
}
