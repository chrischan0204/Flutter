import '/common_libraries.dart';
import 'widgets/template_section.dart';

class TemplateDesignerView extends StatefulWidget {
  final String templateId;
  const TemplateDesignerView({
    super.key,
    required this.templateId,
  });

  @override
  State<TemplateDesignerView> createState() => _TemplateDesignerViewState();
}

class _TemplateDesignerViewState extends State<TemplateDesignerView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          child: Row(
            children: [
              const Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: TemplateSectionView(),
              ),
              const SizedBox(width: 30),
              Flexible(
                flex: 2,
                child: Container(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
