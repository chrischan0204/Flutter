import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

import '/common_libraries.dart';

class QuestionItemView extends StatelessWidget {
  final TemplateQuestion question;
  final bool isFirst;
  final bool isLast;
  const QuestionItemView({
    super.key,
    required this.question,
    required this.isFirst,
    required this.isLast,
  });

  Widget _buildChild(BuildContext context, ReorderableItemState state) {
    BoxDecoration decoration;

    if (state == ReorderableItemState.dragProxy ||
        state == ReorderableItemState.dragProxyFinished) {
      decoration = const BoxDecoration(color: Color(0xD0FFFFFF));
    } else {
      bool placeholder = state == ReorderableItemState.placeholder;
      decoration = BoxDecoration(
          border: Border(
              top: isFirst
                  ? BorderSide.none
                  : isFirst && !placeholder
                      ? Divider.createBorderSide(context) //
                      : BorderSide.none,
              bottom: isLast && placeholder
                  ? BorderSide.none //
                  : Divider.createBorderSide(context)),
          color: placeholder ? null : Colors.white);
    }

    // For iOS dragging mode, there will be drag handle on the right that triggers
    // reordering; For android mode it will be just an empty container
    Widget dragHandle = ReorderableListener(
      child: Icon(
        PhosphorIcons.regular.arrowsOutCardinal,
        size: 20,
        color: primaryColor,
      ),
    );

    Widget content = Container(
      decoration: decoration,
      height: 50,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Opacity(
          opacity: state == ReorderableItemState.placeholder ? 0.0 : 1.0,
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ListTile(
                  onTap: () => context.read<TemplateDesignerBloc>().add(
                      TemplateDesignerQuestionDetailLoaded(question: question)),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      dragHandle,
                      spacerx10,
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 40,
                          width: double.infinity,
                          child: Text(
                            question.title,
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                      spacerx10,
                      Text(
                        '${question.questionScore} + ${question.maxScore - question.questionScore}',
                        style: const TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      CustomAlert(
                        context: context,
                        width: MediaQuery.of(context).size.width / 4,
                        title: 'Confirm',
                        description:
                            'Do you really want to deleted this section?',
                        btnOkText: 'OK',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {},
                        dialogType: DialogType.question,
                      ).show();
                    },
                    icon: PhosphorIcon(
                      PhosphorIcons.regular.trashSimple,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                ),
              ),
              const CustomDivider(height: 1),
            ],
          ),
        ),
      ),
    );

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableItem(
      key: ValueKey(question.id), //
      childBuilder: _buildChild,
    );
  }
}
