import '/common_libraries.dart';
import 'widgets/widgets.dart';

class TemplateSectionsView extends StatefulWidget {
  const TemplateSectionsView({
    super.key,
  });

  @override
  State<TemplateSectionsView> createState() => _TemplateSectionsViewState();
}

class _TemplateSectionsViewState extends State<TemplateSectionsView> {
  @override
  void initState() {
    context
        .read<TemplateDesignerBloc>()
        .add(TemplateDesignerTemplateSectionListLoaded());
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Template Sections',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          CustomDivider(height: 1),
          AddNewSectionField(),
          SectionListView(),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}
