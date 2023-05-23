import '/common_libraries.dart';
import 'widgets/widgets.dart';

class TemplateSectionView extends StatefulWidget {
  final String templateId;
  const TemplateSectionView({
    super.key,
    required this.templateId,
  });

  @override
  State<TemplateSectionView> createState() => _TemplateSectionViewState();
}

class _TemplateSectionViewState extends State<TemplateSectionView> {
  late TemplateDesignerBloc templateDesignerBloc;

  @override
  void initState() {
    templateDesignerBloc = context.read()
      ..add(TemplateDesignerTemplateSectionListLoaded(
          templateId: widget.templateId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateDesignerBloc, TemplateDesignerState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TemplateSectionHeader(),
            const CustomDivider(height: 30),
            Expanded(
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AddNewSectionHeader(),
                      const CustomDivider(),
                      NewSectionField(templateId: widget.templateId),
                      const CustomDivider(),
                      const ExistingTemplateSectionHeader(),
                      const CustomDivider(),
                      const ExistingTemplateSections(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
