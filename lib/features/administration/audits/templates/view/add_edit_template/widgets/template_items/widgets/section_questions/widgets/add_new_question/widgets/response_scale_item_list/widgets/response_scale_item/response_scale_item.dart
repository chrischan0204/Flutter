import '/common_libraries.dart';
import 'futher_action_item.dart';

class ResponseScaleItemView extends StatelessWidget {
  final int level;
  final String response;
  final TemplateSectionItem templateSectionItem;

  const ResponseScaleItemView({
    super.key,
    this.level = 0,
    required this.response,
    required this.templateSectionItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    response,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  child: CustomTextField(
                    onChanged: (value) => context
                        .read<TemplateDesignerBloc>()
                        .add(TemplateDesignerScoreChanged(
                            score: double.parse(value))),
                  ),
                ),
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: Row(
                    children: [
                      Expanded(
                        child: FutherActionItemView(
                          onClick: (commentRequired) => context
                              .read<TemplateDesignerBloc>()
                              .add(TemplateDesignerCommentRequiredChanged(
                                level: level,
                                commentRequired: commentRequired,
                              )),
                          active:
                              templateSectionItem.response?.commentRequiered ??
                                  false,
                          title: 'Comment',
                          activeColor: const Color.fromRGBO(250, 110, 15, 1),
                        ),
                      ),
                      Expanded(
                        child: FutherActionItemView(
                          onClick: (actionItemRequired) => context
                              .read<TemplateDesignerBloc>()
                              .add(TemplateDesignerActionItemChanged(
                                level: level,
                                actionItemRequired: actionItemRequired,
                              )),
                          active: templateSectionItem
                                  .response?.actionItemRequired ??
                              false,
                          title: 'Action Item',
                          activeColor: const Color.fromRGBO(115, 117, 233, 1),
                        ),
                      ),
                      if (level != 2)
                        Expanded(
                          child: FutherActionItemView(
                            active: templateSectionItem
                                    .response?.followUpRequired ??
                                false,
                            onClick: (followUpRequired) => context
                                .read<TemplateDesignerBloc>()
                                .add(TemplateDesignerFollowUpRequiredChanged(
                                  level: level,
                                  followUpRequired: followUpRequired,
                                )),
                            title: 'Follow up',
                            activeColor: const Color.fromRGBO(21, 169, 252, 1),
                          ),
                        ),
                      Expanded(child: Container())
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
        ],
      ),
    );
    ;
  }
}
