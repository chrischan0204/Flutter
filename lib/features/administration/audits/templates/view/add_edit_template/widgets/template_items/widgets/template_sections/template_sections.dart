import '/common_libraries.dart';
import 'widgets/widgets.dart';

class TemplateSectionsView extends StatefulWidget {
  final String templateId;
  const TemplateSectionsView({
    super.key,
    required this.templateId,
  });

  @override
  State<TemplateSectionsView> createState() => _TemplateSectionsViewState();
}

class _TemplateSectionsViewState extends State<TemplateSectionsView> {
  @override
  void initState() {
    context.read<TemplateDesignerBloc>().add(
        TemplateDesignerTemplateSectionListLoaded(
            templateId: widget.templateId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffF9FCFC),
          border: Border.all(
            color: const Color(0xffC8E5E4),
          ),
          borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Template Sections',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const CustomDivider(height: 1),
          AddNewSectionField(templateId: widget.templateId),
          SectionListView(templateId: widget.templateId),
          const SizedBox(height: 20)
        ],
      ),
    );
    ;
  }
}
