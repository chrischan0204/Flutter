import '/common_libraries.dart';
import 'futher_action_item.dart';

class ResponseScaleItemView extends StatelessWidget {
  final String response;
  final TemplateSectionItem templateSectionItem;

  const ResponseScaleItemView({
    super.key,
    required this.response,
    required this.templateSectionItem,
  });

  bool get disabled => !(templateSectionItem.response?.included ?? false);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: templateSectionItem.response?.included == true
          ? Colors.transparent
          : disableColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: inset20,
            child: BlocBuilder<TemplateDesignerBloc, TemplateDesignerState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 100,
                      child: Checkbox(
                        value: templateSectionItem.response?.included,
                        onChanged:
                            templateSectionItem.response?.isRequired == true
                                ? null
                                : (value) => context
                                    .read<TemplateDesignerBloc>()
                                    .add(TemplateDesignerIncludedChanged(
                                      include: value!,
                                      templateSectionItemId:
                                          templateSectionItem.id!,
                                      level: state.level,
                                    )),
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
                                    score: double.parse(value),
                                    level: state.level,
                                    templateSectionItemId:
                                        templateSectionItem.id!,
                                  )),
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
                                  level: state.level,
                                  commentRequired: commentRequired,
                                  templateSectionItemId:
                                      templateSectionItem.id!,
                                )),
                            disabled: disabled,
                            active: templateSectionItem
                                    .response?.commentRequiered ??
                                false,
                            title: 'Comment',
                            activeColor: primaryColor,
                          ),
                          spacer20,
                          FutherActionItemView(
                            onClick: (actionItemRequired) => context
                                .read<TemplateDesignerBloc>()
                                .add(TemplateDesignerActionItemChanged(
                                  level: state.level,
                                  actionItemRequired: actionItemRequired,
                                  templateSectionItemId:
                                      templateSectionItem.id!,
                                )),
                            disabled: disabled,
                            active: templateSectionItem
                                    .response?.actionItemRequired ??
                                false,
                            title: 'Action Item',
                            activeColor: primaryColor,
                          ),
                          spacer20,
                          if (state.level != 2)
                            FutherActionItemView(
                              active: templateSectionItem
                                      .response?.followUpRequired ??
                                  false,
                              onClick: (followUpRequired) => context
                                  .read<TemplateDesignerBloc>()
                                  .add(TemplateDesignerFollowUpRequiredChanged(
                                    level: state.level,
                                    followUpRequired: followUpRequired,
                                    templateSectionItemId:
                                        templateSectionItem.id!,
                                  )),
                              disabled: disabled,
                              title: 'Follow up',
                              activeColor: warnColor,
                            ),
                          spacer20,
                          if (templateSectionItem.response?.followUpRequired ==
                                  true &&
                              state.level < 2)
                            FutherActionItemView(
                              active: templateSectionItem
                                      .response?.followUpRequired ??
                                  false,
                              onClick: (followUpRequired) {
                                context.read<TemplateDesignerBloc>()
                                  ..add(TemplateDesignerLevelChanged(
                                    level: state.level + 1,
                                  ))
                                  ..add(
                                      TemplateDesignerCurrentTemplateSectionItemChanged(
                                          templateSectionItemId:
                                              templateSectionItem.id!));
                              },
                              disabled: disabled,
                              title: 'Add L${state.level + 1} Follow up',
                              activeColor: primaryColor,
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}
