import '/common_libraries.dart';
import 'widgets/widgets.dart';

class TemplateSectionDetails extends StatefulWidget {
  const TemplateSectionDetails({super.key});

  @override
  State<TemplateSectionDetails> createState() => _TemplateSectionDetailsState();
}

class _TemplateSectionDetailsState extends State<TemplateSectionDetails> {
  late TemplateDesignerBloc templateDesignerBloc;

  @override
  void initState() {
    templateDesignerBloc = context.read()
      ..add(TemplateDesignerResponseScaleListLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateDesignerBloc, TemplateDesignerState>(
      builder: (context, state) {
        if (state.selectedTemplateSection == null) {
          return Container();
        }
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TemplateSectionDetailsHeader(),
              const SizedBox(height: 50),
              BlocBuilder<TemplateDesignerBloc, TemplateDesignerState>(
                builder: (context, state) {
                  if (state.templateSectionItem == null) {
                    return Container();
                  }
                  return AddEditQuestionView(
                    templateSectionItem: state.templateSectionItem!,
                  );
                },
              ),
              const QuestionsView(),
            ],
          ),
        );
      },
    );
  }
}
