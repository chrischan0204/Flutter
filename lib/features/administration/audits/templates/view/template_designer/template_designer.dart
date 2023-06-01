import '/common_libraries.dart';
import 'widgets/template_section/template_section.dart';
import 'widgets/template_section_details/template_section_details.dart';

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
  String token = '';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) =>
          setState(() => token = state.authUser?.token ?? ''),
      listenWhen: (previous, current) =>
          previous.authUser?.token != current.authUser?.token,
      builder: (context, addEditTemplateState) {
        token = addEditTemplateState.authUser?.token ?? '';
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => TemplateDesignerBloc(
                templatesRepository: RepositoryProvider.of(context),
                sectionsRepository: RepositoryProvider.of(context),
                responseScalesRepository: RepositoryProvider.of(context),
              ),
            ),
          ],
          child: TemplateDesignerWidget(
            templateId: widget.templateId,
          ),
        );
      },
    );
  }
}

class TemplateDesignerWidget extends StatefulWidget {
  final String templateId;
  const TemplateDesignerWidget({
    super.key,
    required this.templateId,
  });

  @override
  State<TemplateDesignerWidget> createState() => _TemplateDesignerWidgetState();
}

class _TemplateDesignerWidgetState extends State<TemplateDesignerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: TemplateSectionView(templateId: widget.templateId),
          ),
          const SizedBox(width: 30),
          const Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: TemplateSectionDetails(),
          )
        ],
      ),
    );
  }
}