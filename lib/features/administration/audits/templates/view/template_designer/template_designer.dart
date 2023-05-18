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
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
                create: (context) => TemplatesRepository(
                      token: token,
                      authBloc: BlocProvider.of(context),
                    )),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => TemplateDesignerBloc(
                        templatesRepository: RepositoryProvider.of(context),
                      )),
            ],
            child: TemplateDesignerWidget(
              templateId: widget.templateId,
            ),
          ),
        );
      },
    );
  }
}

class TemplateDesignerWidget extends StatelessWidget {
  final String templateId;
  const TemplateDesignerWidget({
    super.key,
    required this.templateId,
  });

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
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: TemplateSectionView(templateId: templateId),
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
