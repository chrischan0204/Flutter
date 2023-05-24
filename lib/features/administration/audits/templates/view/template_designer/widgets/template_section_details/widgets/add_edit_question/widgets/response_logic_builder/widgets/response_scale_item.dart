import '/common_libraries.dart';
import 'response_scale_item_icon.dart';
import '../../../add_edit_question.dart';

class ResponseScaleItemView extends StatefulWidget {
  final TemplateSectionItem templateSectionItem;
  final String response;
  final bool include;
  final bool child;
  const ResponseScaleItemView({
    super.key,
    required this.templateSectionItem,
    required this.response,
    required this.include,
    this.child = false,
  });

  @override
  State<ResponseScaleItemView> createState() => _ResponseScaleItemViewState();
}

class _ResponseScaleItemViewState extends State<ResponseScaleItemView> {
  late TemplateDesignerBloc templateDesignerBloc;

  late bool include;
  bool followUp = false;

  @override
  void initState() {
    templateDesignerBloc = context.read();
    include = widget.include;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: include ? Colors.white : const Color.fromRGBO(242, 242, 242, 1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: Checkbox(
                      value: include,
                      onChanged: (value) => setState(() => include = !include)),
                ),
                Expanded(
                  child: Text(
                    widget.response,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 70,
                    child: CustomTextField(
                      onChanged: (value) => templateDesignerBloc.add(
                          TemplateDesignerScoreChanged(
                              child: widget.child,
                              templateSectionItemId:
                                  widget.templateSectionItem.id!,
                              score: double.parse(value))),
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Row(
                    children: [
                      Expanded(
                        child: ResponseScaleItemIcon(
                          onClick: (commentRequired) => templateDesignerBloc
                              .add(TemplateDesignerCommentRequiredChanged(
                            child: widget.child,
                            templateSectionItemId:
                                widget.templateSectionItem.id!,
                            commentRequired: commentRequired,
                          )),
                          include: include,
                          active: widget.templateSectionItem.response
                                  ?.commentRequiered ??
                              false,
                          iconData: PhosphorIcons.chatCenteredDots,
                          label: 'Comment',
                          activeColor: const Color.fromRGBO(250, 110, 15, 1),
                        ),
                      ),
                      Expanded(
                        child: ResponseScaleItemIcon(
                          onClick: (actionItemRequired) => templateDesignerBloc
                              .add(TemplateDesignerActionItemChanged(
                            child: widget.child,
                            templateSectionItemId:
                                widget.templateSectionItem.id!,
                            actionItemRequired: actionItemRequired,
                          )),
                          include: include,
                          active: widget.templateSectionItem.response
                                  ?.actionItemRequired ??
                              false,
                          iconData: PhosphorIcons.bellRinging,
                          label: 'Action Item',
                          activeColor: const Color.fromRGBO(115, 117, 233, 1),
                        ),
                      ),
                      ...(widget.child
                          ? []
                          : [
                              Expanded(
                                child: ResponseScaleItemIcon(
                                  active: widget.templateSectionItem.response
                                          ?.followUpRequired ??
                                      false,
                                  include: include,
                                  onClick: (followUpRequired) {
                                    setState(() => followUp = !followUp);
                                    templateDesignerBloc.add(
                                        TemplateDesignerFollowUpRequiredChanged(
                                      child: widget.child,
                                      templateSectionItemId:
                                          widget.templateSectionItem.id!,
                                      followUpRequired: followUpRequired,
                                    ));
                                  },
                                  iconData: PhosphorIcons.bookmark,
                                  label: 'Follow up',
                                  activeColor:
                                      const Color.fromRGBO(21, 169, 252, 1),
                                ),
                              )
                            ]),
                      Expanded(child: Container())
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          followUp
              ? Container(
                  color: const Color(0xffE5F8FF),
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Follow up',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      const CustomDivider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 100,
                        ),
                        child: AddEditQuestionView(
                          templateSectionItem: widget.templateSectionItem,
                          child: true,
                        ),
                      ),
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
