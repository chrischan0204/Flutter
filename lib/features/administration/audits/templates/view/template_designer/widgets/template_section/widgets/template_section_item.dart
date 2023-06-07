import '/common_libraries.dart';

import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

import '/common_libraries.dart';

class TemplateSectionItemView extends StatefulWidget {
  const TemplateSectionItemView({
    Key? key,
    required this.isFirst,
    required this.isLast,
    required this.templateSection,
    required this.templateSectionItemCount,
  }) : super(key: key);

  final bool isFirst;
  final bool isLast;
  final TemplateSection templateSection;
  final int templateSectionItemCount;

  @override
  State<TemplateSectionItemView> createState() => _ItemState();
}

class _ItemState extends State<TemplateSectionItemView> {
  bool isHover = false;
  String? selectedValue;

  late TemplateDesignerBloc templateDesignerBloc;

  @override
  void initState() {
    templateDesignerBloc = context.read();
    super.initState();
  }

  Widget _buildChild(BuildContext context, ReorderableItemState state) {
    BoxDecoration decoration;

    if (state == ReorderableItemState.dragProxy ||
        state == ReorderableItemState.dragProxyFinished) {
      decoration = const BoxDecoration(color: Color(0xD0FFFFFF));
    } else {
      bool placeholder = state == ReorderableItemState.placeholder;
      decoration = BoxDecoration(
          border: Border(
              top: widget.isFirst && !placeholder
                  ? Divider.createBorderSide(context) //
                  : BorderSide.none,
              bottom: widget.isLast && placeholder
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
            child: ReorderableListener(
              child: MouseRegion(
                onHover: (event) => setState(() => isHover = true),
                onExit: (event) => setState(() => isHover = false),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(widget.templateSection.name,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.blue)),
                          Text(
                              ' - (${widget.templateSectionItemCount} question)',
                              style: const TextStyle(fontSize: 11))
                        ],
                      ),
                      IconButton(
                        onPressed: () => templateDesignerBloc.add(
                            TemplateDesignerTemplateSectionSelected(
                                templateSection: widget.templateSection)),
                        icon: Icon(
                          PhosphorIcons.regular.caretCircleDoubleRight,
                          size: 18,
                          color: warnColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableItem(
      key: widget.key!, //
      childBuilder: _buildChild,
    );
  }
}

// class TemplateSectionItemView extends StatefulWidget {
//   final TemplateSection templateSection;
//   final int templateSectionItemCount;
//   const TemplateSectionItemView({
//     super.key,
//     required this.templateSection,
//     required this.templateSectionItemCount,
//   });

//   @override
//   State<TemplateSectionItemView> createState() =>
//       _TemplateSectionItemViewState();
// }

// class _TemplateSectionItemViewState extends State<TemplateSectionItemView> {
//   late TemplateDesignerBloc templateDesignerBloc;

//   @override
//   void initState() {
//     templateDesignerBloc = context.read();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         ListTile(
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Text(widget.templateSection.name,
//                       style: const TextStyle(fontSize: 14, color: Colors.blue)),
//                   Text(' - (${widget.templateSectionItemCount} question)',
//                       style: const TextStyle(fontSize: 11))
//                 ],
//               ),
//               IconButton(
//                 onPressed: () => templateDesignerBloc.add(
//                     TemplateDesignerTemplateSectionSelected(
//                         templateSection: widget.templateSection)),
//                 icon: Icon(
//                   PhosphorIcons.regular.caretCircleDoubleRight,
//                   size: 18,
//                   color: warnColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const CustomDivider(height: 3)
//       ],
//     );
//   }
// }
