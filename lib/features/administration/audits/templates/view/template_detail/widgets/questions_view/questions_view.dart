import '/common_libraries.dart';
import 'widgets/widgets.dart';

class QuestionsView extends StatelessWidget {
  final String templateId;
  const QuestionsView({
    super.key,
    required this.templateId,
  });

  List<TemplateQuestion> _getTemplateQuestionList(
      List<TemplateSection> templateSectionList) {
    final List<TemplateQuestion> list = [];
    for (final questionDetail in templateSectionList) {
      for (final templateSectionItem in questionDetail.templateSectionItems) {
        list.add(templateSectionItem);
      }
    }
    return list;
  }

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
            return CustomExpansionPanelList(
              dividerColor: primaryColor,
              elevation: 3,
              expansionCallback: (int index, bool isExpanded) {
                context
                    .read<TemplateDetailBloc>()
                    .add(TemplateDetailIsOpenChanged(
                      id: _getTemplateQuestionList(
                              state.templateQuestionDetailList)[index]
                          .id,
                      level: 1,
                      isOpen: !isExpanded,
                    ));
              },
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
                      getTemplateQuestionList: _getTemplateQuestionList,
                    )
              ],
            );
          },
        ),
      ],
    );
  }
}
