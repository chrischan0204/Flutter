import '../widgets.dart';
import '/common_libraries.dart';

class TemplateSectionItemView extends CustomExpansionPanel {
  final String templateSectionId;
  final BuildContext context;
  final String category;
  final int level;
  final List<TemplateQuestion> Function(List<TemplateSection>)
      getTemplateQuestionList;
  final TemplateQuestion templateSectionItem;
  TemplateSectionItemView({
    required this.templateSectionId,
    required this.context,
    required this.templateSectionItem,
    required this.level,
    required this.category,
    required this.getTemplateQuestionList,
  }) : super(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return QuestionItemView(
              question: templateSectionItem.title,
              scale: templateSectionItem.scaleName,
              category: category,
              questionScore: templateSectionItem.questionScore,
              maxScore: templateSectionItem.maxScore,
              level: level - 1,
            );
          },
          backgroundColor: level == 1
              ? lightGreenAccent
              : level == 2
                  ? lightBlueAccent
                  : lightTeal,
          isExpanded: templateSectionItem.isOpen,
          body: templateSectionItem.responseScaleItems.isNotEmpty
              ? Padding(
                  padding: insetx10y20,
                  child: Card(
                    elevation: 3,
                    child: CustomExpansionPanelList(
                      expandedHeaderPadding: insety10,
                      noExpanded: templateSectionItem.responseScaleItems
                          .where((element) => !element.followUpRequired)
                          .map((e) => templateSectionItem.responseScaleItems
                              .indexWhere((child) => child.id == e.id))
                          .toList(),
                      expansionCallback: (int index, bool isExpanded) {
                        final responseScaleItem =
                            templateSectionItem.responseScaleItems[index];
                        if (responseScaleItem.followUpRequired) {
                          context.read<TemplateDetailBloc>().add(
                                TemplateDetailTemplateQuestionDetailLoaded(
                                  id: responseScaleItem.id!,
                                  itemType: 2,
                                  templateSectionId: templateSectionId,
                                  level: level,
                                  isOpen: !responseScaleItem.isOpen,
                                ),
                              );
                        }
                      },
                      children: [
                        for (final responseScaleItem
                            in templateSectionItem.responseScaleItems)
                          CustomExpansionPanel(
                            headerBuilder: (context, isExpanded) =>
                                ResponseItemView(
                              scale: templateSectionItem.scaleName,
                              option: responseScaleItem.name,
                              score: responseScaleItem.score,
                              comment: responseScaleItem.commentRequired,
                              actionItem: responseScaleItem.actionItemRequired,
                              followUp: responseScaleItem.followUpRequired,
                            ),
                            isExpanded: responseScaleItem.isOpen,
                            body: responseScaleItem
                                    .followUpQuestionList.isNotEmpty
                                ? Padding(
                                    padding: insetx10y20,
                                    child: Card(
                                      elevation: 3,
                                      child: CustomExpansionPanelList(
                                        expandedHeaderPadding: insety10,
                                        expansionCallback:
                                            (int index, bool isExpanded) {
                                          context
                                              .read<TemplateDetailBloc>()
                                              .add(TemplateDetailIsOpenChanged(
                                                id: getTemplateQuestionList(
                                                            responseScaleItem
                                                                .followUpQuestionList)[
                                                        index]
                                                    .id,
                                                level: level + 1,
                                                isOpen: !isExpanded,
                                              ));
                                        },
                                        children: [
                                          for (final questionDetail
                                              in responseScaleItem
                                                  .followUpQuestionList)
                                            for (final templateSectionItem
                                                in questionDetail
                                                    .templateSectionItems)
                                              TemplateSectionItemView(
                                                templateSectionItem:
                                                    templateSectionItem,
                                                category: questionDetail.name,
                                                context: context,
                                                templateSectionId:
                                                    questionDetail.id,
                                                level: level + 1,
                                                getTemplateQuestionList:
                                                    getTemplateQuestionList,
                                              )
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(height: 0),
                          ),
                      ],
                    ),
                  ),
                )
              : Container(height: 0),
        );
}
