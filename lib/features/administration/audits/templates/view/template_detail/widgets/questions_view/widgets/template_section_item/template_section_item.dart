import 'package:accordion/accordion.dart';

import '../widgets.dart';
import '/common_libraries.dart';

class TemplateSectionItemView extends ExpansionPanel {
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
          isExpanded: templateSectionItem.isOpen,
          body: templateSectionItem.responseScaleItems.isNotEmpty
              ? Padding(
                  padding: inset20,
                  child: Card(
                    elevation: 3,
                    child: ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        final responseScaleItem =
                            templateSectionItem.responseScaleItems[index];
                        if (responseScaleItem.followUpQuestionList.isEmpty &&
                            responseScaleItem.followUpRequired) {
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
                          ExpansionPanel(
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
                                    padding: inset20,
                                    child: Card(
                                      elevation: 3,
                                      child: ExpansionPanelList(
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

// class TemplateSectionItemView extends AccordionSection {
//   final String templateSectionId;
//   final BuildContext context;
//   final String category;
//   final int level;
//   final TemplateQuestion templateSectionItem;
//   TemplateSectionItemView({
//     super.key,
//     required this.templateSectionId,
//     required this.context,
//     required this.templateSectionItem,
//     required this.level,
//     required this.category,
//   }) : super(
//           contentBorderColor: Colors.white,
//           headerBackgroundColorOpened: level == 1
//               ? lightBlue
//               : level == 2
//                   ? Colors.purple.shade100
//                   : Colors.grey.shade200,
//           headerBackgroundColor: level == 1
//               ? lightBlueAccent
//               : level == 2
//                   ? Colors.purple.shade400
//                   : Colors.grey.shade400,
//           headerBorderRadius: 0,
//           contentBorderRadius: 0,
//           contentVerticalPadding: 0,
//           header: QuestionItemView(
//             question: templateSectionItem.title,
//             scale: templateSectionItem.scaleName,
//             category: category,
//             questionScore: templateSectionItem.questionScore,
//             maxScore: templateSectionItem.maxScore,
//             level: level - 1,
//           ),
//           isOpen: templateSectionItem.isOpen,
//           onOpenSection: () => context
//               .read<TemplateDetailBloc>()
//               .add(TemplateDetailIsOpenChanged(
//                 id: templateSectionItem.id,
//                 level: level,
//                 isOpen: !templateSectionItem.isOpen,
//               )),
//           content: templateSectionItem.responseScaleItems.isNotEmpty
//               ? Accordion(
//                   scaleWhenAnimating: false,
//                   openAndCloseAnimation: false,
//                   maxOpenSections: 1,
//                   headerPadding: const EdgeInsets.symmetric(
//                     vertical: 7,
//                     horizontal: 15,
//                   ),
//                   children: [
//                     for (final responseScaleItem
//                         in templateSectionItem.responseScaleItems)
//                       AccordionSection(
//                         headerBackgroundColor: level == 1
//                             ? lightGreenAccent
//                             : level == 2
//                                 ? Colors.amberAccent.shade100
//                                 : Colors.teal.shade200,
//                         headerBackgroundColorOpened: level == 1
//                             ? lightGreen
//                             : level == 2
//                                 ? Colors.amberAccent
//                                 : Colors.teal,
//                         contentBorderColor: Colors.white,
//                         headerBorderRadius: 0,
//                         contentBorderRadius: 0,
//                         contentVerticalPadding: 0,
//                         onOpenSection: () {
//                           if (responseScaleItem.followUpQuestionList.isEmpty &&
//                               responseScaleItem.followUpRequired) {
//                             context.read<TemplateDetailBloc>().add(
//                                   TemplateDetailTemplateQuestionDetailLoaded(
//                                     id: responseScaleItem.id,
//                                     itemType: 2,
//                                     templateSectionId: templateSectionId,
//                                     level: level,
//                                     isOpen: !responseScaleItem.isOpen,
//                                   ),
//                                 );
//                           }
//                         },
//                         header: ResponseItemView(
//                           scale: templateSectionItem.scaleName,
//                           option: responseScaleItem.name,
//                           score: responseScaleItem.score,
//                           comment: responseScaleItem.commentRequired,
//                           actionItem: responseScaleItem.actionItemRequired,
//                           followUp: responseScaleItem.followUpRequired,
//                         ),
//                         isOpen: responseScaleItem.isOpen,
//                         content: responseScaleItem
//                                 .followUpQuestionList.isNotEmpty
//                             ? Accordion(
//                                 scaleWhenAnimating: false,
//                                 openAndCloseAnimation: false,
//                                 maxOpenSections: 1,
//                                 headerBackgroundColor: Colors.transparent,
//                                 headerPadding: const EdgeInsets.symmetric(
//                                     vertical: 7, horizontal: 15),
//                                 headerBorderRadius: 0,
//                                 contentBorderRadius: 0,
//                                 contentVerticalPadding: 0,
//                                 children: [
//                                   for (final questionDetail
//                                       in responseScaleItem.followUpQuestionList)
//                                     for (final templateSectionItem
//                                         in questionDetail.templateSectionItems)
//                                       TemplateSectionItemView(
//                                         templateSectionItem:
//                                             templateSectionItem,
//                                         category: questionDetail.name,
//                                         context: context,
//                                         templateSectionId: questionDetail.id,
//                                         level: level + 1,
//                                       )
//                                 ],
//                               )
//                             : Container(height: 0),
//                         contentHorizontalPadding: 20,
//                       ),
//                   ],
//                 )
//               : Container(height: 0),
//         );
// }
