import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

import '../../blocs/bloc/response_scale_bloc.dart';
import '/common_libraries.dart';

class ResponseScaleItemListItemView extends StatelessWidget {
  final TemplateResponseScaleItem responseScaleItem;
  final bool isFirst;
  final bool isLast;
  final int index;
  const ResponseScaleItemListItemView({
    super.key,
    required this.responseScaleItem,
    required this.isFirst,
    required this.isLast,
    required this.index,
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
      child: SafeArea(
        top: false,
        bottom: false,
        child: Opacity(
          opacity: state == ReorderableItemState.placeholder ? 0.0 : 1.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Row(
                  children: [
                    dragHandle,
                    spacerx10,
                    Expanded(
                      child: ResponseScaleItemListItemBodyView(
                        responseScaleItem: responseScaleItem,
                        index: index,
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () {
                    CustomAlert(
                      context: context,
                      width: MediaQuery.of(context).size.width / 4,
                      title: 'Confirm',
                      description:
                          'Do you really want to delete this response scale item?',
                      btnOkText: 'OK',
                      btnOkOnPress: () => context
                          .read<ResponseScaleBloc>()
                          .add(ResponseScaleItemDeleted(index: index)),
                      btnCancelOnPress: () {},
                      dialogType: DialogType.question,
                    ).show();
                  },
                  icon: PhosphorIcon(
                    PhosphorIcons.regular.trashSimple,
                    size: 20,
                    color: Colors.red,
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
      key: ValueKey(responseScaleItem.id), //
      childBuilder: _buildChild,
    );
  }
}

class ResponseScaleItemListItemBodyView extends StatelessWidget {
  final TemplateResponseScaleItem responseScaleItem;
  final int index;
  const ResponseScaleItemListItemBodyView({
    super.key,
    required this.responseScaleItem,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        spacerx20,
        Expanded(
          child: CustomTextField(
            key: ValueKey(responseScaleItem.id),
            initialValue: responseScaleItem.name,
            onChanged: (value) => context.read<ResponseScaleBloc>().add(
                  ResponseScaleItemNameChanged(
                    index: index,
                    responseScaleItemName: value,
                  ),
                ),
          ),
        ),
        SizedBox(
          width: 100,
          child: Checkbox(
              key: ValueKey(responseScaleItem.id),
              value: responseScaleItem.isRequired,
              onChanged: (value) => context.read<ResponseScaleBloc>().add(
                    ResponseScaleItemIsRequiredChanged(
                      index: index,
                      isRequired: value!,
                    ),
                  )),
        ),
        SizedBox(
          width: 100,
          child: CustomTextField(
            key: ValueKey(responseScaleItem.id),
            initialValue: responseScaleItem.score.toString(),
            onChanged: (value) => context.read<ResponseScaleBloc>().add(
                  ResponseScaleItemScoreChanged(
                    index: index,
                    score: value,
                  ),
                ),
          ),
        )
      ],
    );
  }
}
