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

  bool get disabled => !(templateSectionItem.response?.included ?? false);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: templateSectionItem.response?.isRequired == true
          ? Colors.transparent
          : disableColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: inset20,
            child: Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: 100,
                  child: Checkbox(
                    value: templateSectionItem.response?.included,
                    onChanged: templateSectionItem.response?.isRequired == true
                        ? null
                        : (value) {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                  ),
                ),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Text(
                    response,
                    style: textSemiBold14,
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: CustomTextField(
                          isDisabled: disabled,
                          onChanged: (value) => context
                              .read<TemplateDesignerBloc>()
                              .add(TemplateDesignerScoreChanged(
                                  score: double.parse(value))),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 2,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Row(
                    children: [
                      FutherActionItemView(
                        onClick: (commentRequired) => context
                            .read<TemplateDesignerBloc>()
                            .add(TemplateDesignerCommentRequiredChanged(
                              level: level,
                              commentRequired: commentRequired,
                            )),
                        disabled: disabled,
                        active:
                            templateSectionItem.response?.commentRequiered ??
                                false,
                        title: 'Comment',
                        activeColor: primaryColor,
                      ),
                      spacer20,
                      FutherActionItemView(
                        onClick: (actionItemRequired) => context
                            .read<TemplateDesignerBloc>()
                            .add(TemplateDesignerActionItemChanged(
                              level: level,
                              actionItemRequired: actionItemRequired,
                            )),
                        disabled: disabled,
                        active:
                            templateSectionItem.response?.actionItemRequired ??
                                false,
                        title: 'Action Item',
                        activeColor: primaryColor,
                      ),
                      spacer20,
                      if (level != 2)
                        FutherActionItemView(
                          active:
                              templateSectionItem.response?.followUpRequired ??
                                  false,
                          onClick: (followUpRequired) => context
                              .read<TemplateDesignerBloc>()
                              .add(TemplateDesignerFollowUpRequiredChanged(
                                level: level,
                                followUpRequired: followUpRequired,
                              )),
                          disabled: disabled,
                          title: 'Follow up',
                          activeColor: warnColor,
                        ),
                      spacer20,
                      FutherActionItemView(
                        active:
                            templateSectionItem.response?.followUpRequired ??
                                false,
                        onClick: (followUpRequired) => context
                            .read<TemplateDesignerBloc>()
                            .add(TemplateDesignerFollowUpRequiredChanged(
                              level: level,
                              followUpRequired: followUpRequired,
                            )),
                        disabled: disabled,
                        title: 'Follow up',
                        activeColor: warnColor,
                      ),
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
  }
}
