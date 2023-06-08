import '/common_libraries.dart';
import 'response_scale_item_icon.dart';
import '../../../add_edit_question.dart';

class ResponseScaleItemView extends StatefulWidget {
  final TemplateSectionItem templateSectionItem;
  final String response;
  final bool child;
  const ResponseScaleItemView({
    super.key,
    required this.templateSectionItem,
    required this.response,
    this.child = false,
  });

  @override
  State<ResponseScaleItemView> createState() => _ResponseScaleItemViewState();
}

class _ResponseScaleItemViewState extends State<ResponseScaleItemView> {
  late TemplateDesignerBloc templateDesignerBloc;

  bool followUp = false;

  @override
  void initState() {
    templateDesignerBloc = context.read();
    super.initState();
  }

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
                    widget.response,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  child: CustomTextField(
                    // onChanged: (value) => templateDesignerBloc.add(
                    //     TemplateDesignerScoreChanged(
                    //         child: widget.child,
                    //         templateSectionItemId:
                    //             widget.templateSectionItem.id!,
                    //         score: double.parse(value))),
                  ),
                ),
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: Row(
                    children: [
                      Expanded(
                        child: ResponseScaleItemIcon(
                          // onClick: (commentRequired) => templateDesignerBloc
                          //     .add(TemplateDesignerCommentRequiredChanged(
                          //   child: widget.child,
                          //   templateSectionItemId:
                          //       widget.templateSectionItem.id!,
                          //   commentRequired: commentRequired,
                          // )),
                          active: widget.templateSectionItem.response
                                  ?.commentRequiered ??
                              false,
                          iconData: PhosphorIcons.regular.chatCenteredDots,
                          label: 'Comment',
                          activeColor: const Color.fromRGBO(250, 110, 15, 1),
                        ),
                      ),
                      Expanded(
                        child: ResponseScaleItemIcon(
                          // onClick: (actionItemRequired) => templateDesignerBloc
                          //     .add(TemplateDesignerActionItemChanged(
                          //   child: widget.child,
                          //   templateSectionItemId:
                          //       widget.templateSectionItem.id!,
                          //   actionItemRequired: actionItemRequired,
                          // )),
                          active: widget.templateSectionItem.response
                                  ?.actionItemRequired ??
                              false,
                          iconData: PhosphorIcons.regular.bellRinging,
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
                                  onClick: (followUpRequired) {
                                    setState(() => followUp = !followUp);
                                    // templateDesignerBloc.add(
                                    //     TemplateDesignerFollowUpRequiredChanged(
                                    //   child: widget.child,
                                    //   templateSectionItemId:
                                    //       widget.templateSectionItem.id!,
                                    //   followUpRequired: followUpRequired,
                                    // ));
                                  },
                                  iconData: PhosphorIcons.regular.bookmark,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Follow up',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
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
