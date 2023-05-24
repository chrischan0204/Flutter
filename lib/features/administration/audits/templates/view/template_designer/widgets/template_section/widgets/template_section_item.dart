import '/common_libraries.dart';

class TemplateSectionItemView extends StatefulWidget {
  final TemplateSection templateSection;
  final int templateSectionItemCount;
  const TemplateSectionItemView({
    super.key,
    required this.templateSection,
    required this.templateSectionItemCount,
  });

  @override
  State<TemplateSectionItemView> createState() =>
      _TemplateSectionItemViewState();
}

class _TemplateSectionItemViewState extends State<TemplateSectionItemView> {
  late TemplateDesignerBloc templateDesignerBloc;

  @override
  void initState() {
    templateDesignerBloc = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(widget.templateSection.name,
                      style: const TextStyle(fontSize: 14, color: Colors.blue)),
                  Text(' - (${widget.templateSectionItemCount} question)',
                      style: const TextStyle(fontSize: 11))
                ],
              ),
              IconButton(
                onPressed: () => templateDesignerBloc.add(
                    TemplateDesignerTemplateSectionSelected(
                        templateSection: widget.templateSection)),
                icon: Icon(
                  PhosphorIcons.caretCircleDoubleRight,
                  size: 18,
                  color: warnColor,
                ),
              ),
            ],
          ),
        ),
        const CustomDivider(height: 3)
      ],
    );
  }
}
