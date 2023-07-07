import '/common_libraries.dart';
import 'futher_action_item.dart';

class ResponseScaleItemView extends StatelessWidget {
  final TemplateSectionItem templateSectionItem;

  const ResponseScaleItemView({
    super.key,
    required this.templateSectionItem,
  });

  bool get disabled => !(templateSectionItem.response?.included ?? false);

  // build include check box
  Widget _buildIncludeCheckBox(BuildContext context) => Container(
        alignment: Alignment.centerLeft,
        width: 100,
        child: Checkbox(
          value: templateSectionItem.response?.isRequired == true
              ? true
              : templateSectionItem.response?.included,
          onChanged: templateSectionItem.response?.isRequired == true
              ? null
              : (value) => context
                  .read<TemplateDesignerBloc>()
                  .add(TemplateDesignerIncludedChanged(
                    include: value!,
                    responseScaleItemId:
                        templateSectionItem.response!.responseScaleItemId!,
                  )),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        ),
      );

  // response text field
  Widget get responseTextField => Flexible(
        flex: 3,
        fit: FlexFit.tight,
        child: Text(
          templateSectionItem.response?.name ?? '',
          style: textSemiBold14,
        ),
      );

  // build score text field
  Widget _buildScoreTextField(BuildContext context) => Flexible(
        flex: 2,
        fit: FlexFit.tight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: CustomTextField(
                key: ValueKey(templateSectionItem.id),
                initialValue: templateSectionItem.response?.score.toString(),
                isDisabled: disabled,
                onChanged: (value) => context
                    .read<TemplateDesignerBloc>()
                    .add(TemplateDesignerScoreChanged(
                      score: double.parse(value),
                      responseScaleItemId:
                          templateSectionItem.response!.responseScaleItemId!,
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
      );

  // build comment button
  Widget _buildCommentButton(BuildContext context) => FutherActionItemView(
        onClick: (commentRequired) => context
            .read<TemplateDesignerBloc>()
            .add(TemplateDesignerCommentRequiredChanged(
              commentRequired: commentRequired,
              responseScaleItemId:
                  templateSectionItem.response!.responseScaleItemId!,
            )),
        disabled: disabled,
        active: (templateSectionItem.response?.commentRequired ?? false) &&
            !disabled,
        title: 'Comment',
        activeColor: primaryColor,
      );

  // build action item button
  Widget _buildActionItemButton(BuildContext context) => FutherActionItemView(
        onClick: (actionItemRequired) => context
            .read<TemplateDesignerBloc>()
            .add(TemplateDesignerActionItemChanged(
              actionItemRequired: actionItemRequired,
              responseScaleItemId:
                  templateSectionItem.response!.responseScaleItemId!,
            )),
        disabled: disabled,
        active: (templateSectionItem.response?.actionItemRequired ?? false) &&
            !disabled,
        title: 'Action Item',
        activeColor: primaryColor,
      );

  // build follow up button
  Widget _buildFollowupButton(BuildContext context) => FutherActionItemView(
        active: (templateSectionItem.response?.followUpRequired ?? false) &&
            !disabled,
        onClick: (followUpRequired) {
          context
              .read<TemplateDesignerBloc>()
              .add(TemplateDesignerFollowUpRequiredChanged(
                followUpRequired: followUpRequired,
                responseScaleItemId:
                    templateSectionItem.response!.responseScaleItemId!,
              ));
          if (!followUpRequired) {
            context
                .read<TemplateDesignerBloc>()
                .add(TemplateDesignerCurrentTemplateSectionItemChanged(
                  templateSectionItemId: templateSectionItem.id!,
                  responseScaleItem: templateSectionItem.response!,
                  followUp: followUpRequired,
                ));
          }
        },
        disabled: disabled,
        title: 'Follow up',
        activeColor: warnColor,
      );

  // build level 1 or 2 follow up button
  Widget _buildLevelFollowUpButton(BuildContext context, int level) =>
      ElevatedButton(
          onPressed: disabled
              ? null
              : () {
                  context
                      .read<TemplateDesignerBloc>()
                      .add(TemplateDesignerCurrentTemplateSectionItemChanged(
                        templateSectionItemId: templateSectionItem.id!,
                        responseScaleItem: templateSectionItem.response!,
                      ));

                  if (templateSectionItem.id != null) {
                    context.read<TemplateDesignerBloc>().add(
                        TemplateDesignerFollowUpQuestionDetailLoaded(
                            id: templateSectionItem.id!));
                  }
                },
          style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
          child: Icon(
            PhosphorIcons.regular.arrowCircleRight,
            size: 18,
          ));
  // FutherActionItemView(
  //   active: templateSectionItem.response?.followUpRequired ?? false,
  //   onClick: (_) {

  //   },
  //   disabled: disabled,
  //   title: 'Add L${level + 1} Follow up',
  //   activeColor: primaryColor,
  // );

  // build futher action buttons
  Widget _buildFurtherActionButtons(BuildContext context, int level) =>
      Flexible(
        flex: 6,
        fit: FlexFit.tight,
        child: Row(
          children: [
            _buildCommentButton(context),
            spacerx20,
            _buildActionItemButton(context),
            spacerx20,
            if (level != 2) _buildFollowupButton(context),
            spacerx20,
            if (templateSectionItem.response?.followUpRequired == true &&
                level < 2)
              _buildLevelFollowUpButton(context, level),
          ],
        ),
      );

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
            padding: inset10,
            child: BlocBuilder<TemplateDesignerBloc, TemplateDesignerState>(
              builder: (context, state) {
                return Row(
                  children: [
                    _buildIncludeCheckBox(context),
                    responseTextField,
                    _buildScoreTextField(context),
                    _buildFurtherActionButtons(context, state.level),
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
