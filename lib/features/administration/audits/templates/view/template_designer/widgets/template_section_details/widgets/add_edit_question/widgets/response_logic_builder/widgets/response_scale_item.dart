import '/common_libraries.dart';
import 'response_scale_item_icon.dart';
import '../../../add_edit_question.dart';

class ResponseScaleItemView extends StatefulWidget {
  final TemplateSectionItem templateSectionItem;
  final String response;
  final bool include;
  final bool childQuestion;
  const ResponseScaleItemView({
    super.key,
    required this.templateSectionItem,
    required this.response,
    required this.include,
    this.childQuestion = false,
  });

  @override
  State<ResponseScaleItemView> createState() => _ResponseScaleItemViewState();
}

class _ResponseScaleItemViewState extends State<ResponseScaleItemView> {
  late bool include;
  bool followUp = false;

  @override
  void initState() {
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
                const Expanded(
                  child: SizedBox(
                    width: 70,
                    child: CustomTextField(),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Row(
                    children: [
                      Expanded(
                        child: ResponseScaleItemIcon(
                          include: include,
                          iconData: PhosphorIcons.chatCenteredDots,
                          label: 'Comment',
                          activeColor: const Color.fromRGBO(250, 110, 15, 1),
                        ),
                      ),
                      Expanded(
                        child: ResponseScaleItemIcon(
                          include: include,
                          iconData: PhosphorIcons.bellRinging,
                          label: 'Action Item',
                          activeColor: const Color.fromRGBO(115, 117, 233, 1),
                        ),
                      ),
                      ...(widget.childQuestion
                          ? []
                          : [
                              Expanded(
                                child: ResponseScaleItemIcon(
                                  include: include,
                                  onClick: () =>
                                      setState(() => followUp = !followUp),
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
                          childQuestion: true,
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
