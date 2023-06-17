import '/common_libraries.dart';

class SectionItemView extends StatefulWidget {
  final TemplateSectionListItem section;
  final bool first;
  final bool active;
  const SectionItemView({
    super.key,
    required this.section,
    this.first = false,
    this.active = false,
  });

  @override
  State<SectionItemView> createState() => _SectionItemViewState();
}

class _SectionItemViewState extends State<SectionItemView> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    Color _getColor() {
      if (_hover) {
        return const Color(0xfff7fdf1);
      } else if (widget.active) {
        return const Color(0xffecfadc);
      }
      return Colors.transparent;
    }

    return InkWell(
      onTap: () => context.read<TemplateDesignerBloc>().add(
          TemplateDesignerTemplateSectionSelected(
              templateSection: widget.section)),
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
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Container(
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
                  const SizedBox(width: 10),
                  Text(
                    widget.section.name,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
