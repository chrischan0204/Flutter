import '/common_libraries.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

class SectionItemView extends StatefulWidget {
  final TemplateSectionListItem section;
  final bool first;
  final bool last;
  final bool active;
  const SectionItemView({
    super.key,
    required this.section,
    this.first = false,
    this.last = false,
    this.active = false,
  });

  @override
  State<SectionItemView> createState() => _SectionItemViewState();
}

class _SectionItemViewState extends State<SectionItemView> {
  bool _hover = false;
  bool _isEditing = false;
  late TextEditingController _textEditingController;

  Widget dragHandle = ReorderableListener(
    child: Container(
      width: 30,
      height: 30,
      color: Colors.white,
      child: Center(
        child: Icon(
          PhosphorIcons.regular.dotsThreeVertical,
          size: 22,
          color: primaryColor,
        ),
      ),
    ),
  );

  @override
  void initState() {
    _textEditingController = TextEditingController(text: widget.section.name);
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Color _getColor() {
    if (_hover) {
      return const Color(0xfff7fdf1);
    } else if (widget.active) {
      return const Color(0xffecfadc);
    }
    return Colors.transparent;
  }

  void _getQuestionListForSection() {
    context
        .read<TemplateDesignerBloc>()
        .add(TemplateDesignerTemplateSectionSelected(
          templateSection: widget.section,
        ));
  }

  Widget _buildChild(BuildContext context, ReorderableItemState state) {
    BoxDecoration decoration;

    if (state == ReorderableItemState.dragProxy ||
        state == ReorderableItemState.dragProxyFinished) {
      // slightly transparent background white dragging (just like on iOS)
      decoration = const BoxDecoration(color: Color(0xD0FFFFFF));
    } else {
      bool placeholder = state == ReorderableItemState.placeholder;
      decoration = BoxDecoration(
          border: Border(
              top: widget.first && !placeholder
                  ? Divider.createBorderSide(context) //
                  : BorderSide.none,
              bottom: widget.last && placeholder
                  ? BorderSide.none //
                  : Divider.createBorderSide(context)),
          color: placeholder ? null : Colors.white);
    }

    Widget content = Container(
      decoration: decoration,
      child: SafeArea(
          top: false,
          bottom: false,
          child: Opacity(
            // hide content for placeholder
            opacity: state == ReorderableItemState.placeholder ? 0.0 : 1.0,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        CustomAlert.checkFormDirty(
                            () => _getQuestionListForSection(), context);
                      },
                      onHover: (value) => setState(() => _hover = value),
                      child: Container(
                        decoration: widget.active
                            ? BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: primaryColor,
                                    width: 0.5,
                                  ),
                                  left: BorderSide(
                                    color: primaryColor,
                                    width: 0.5,
                                  ),
                                  right: BorderSide(
                                    color: primaryColor,
                                    width: 0.5,
                                  ),
                                ),
                                color: _getColor(),
                              )
                            : BoxDecoration(color: _getColor()),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!widget.first) const CustomDivider(height: 1),
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      dragHandle,
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: _isEditing
                                            ? Row(
                                                children: [
                                                  Expanded(
                                                    child: TextField(
                                                      controller:
                                                          _textEditingController,
                                                      decoration:
                                                          const InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            context
                                                                .read<
                                                                    TemplateDesignerBloc>()
                                                                .add(
                                                                    TemplateDesignerSectionUpdated(
                                                                  section:
                                                                      _textEditingController
                                                                          .text,
                                                                  sectionId:
                                                                      widget
                                                                          .section
                                                                          .id,
                                                                ));
                                                            _isEditing = false;
                                                          });
                                                        },
                                                        icon: PhosphorIcon(
                                                          PhosphorIcons
                                                              .regular.check,
                                                          color:
                                                              successHoverColor,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            _isEditing = false;
                                                          });
                                                        },
                                                        icon: PhosphorIcon(
                                                          PhosphorIcons
                                                              .regular.x,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : Text(
                                                widget.section.name,
                                                style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 14,
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (widget.active)
                                  if (!_isEditing)
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                          _getColor().withOpacity(0.5),
                                          _getColor(),
                                        ])),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 10,
                                        ),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _textEditingController.text =
                                                      widget.section.name;
                                                  _isEditing = true;
                                                });
                                              },
                                              icon: PhosphorIcon(
                                                PhosphorIcons.regular.pencil,
                                                color: successHoverColor,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                CustomAlert(
                                                  context: context,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4,
                                                  title: 'Confirm',
                                                  description:
                                                      'Do you really want to delete this section?',
                                                  btnOkText: 'OK',
                                                  btnCancelOnPress: () {},
                                                  btnOkOnPress: () => context
                                                      .read<
                                                          TemplateDesignerBloc>()
                                                      .add(
                                                          TemplateDesignerSectionDeleted(
                                                              sectionId: widget
                                                                  .section.id)),
                                                  dialogType:
                                                      DialogType.question,
                                                ).show();
                                              },
                                              icon: PhosphorIcon(
                                                PhosphorIcons
                                                    .regular.trashSimple,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableItem(
      key: ValueKey(widget.section.id), //
      childBuilder: _buildChild,
    );
  }
}
