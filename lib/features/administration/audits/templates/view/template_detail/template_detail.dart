import '/common_libraries.dart';
import 'widgets/widgets.dart';

class TemplateDetailView extends StatefulWidget {
  final String templateId;
  const TemplateDetailView({
    super.key,
    required this.templateId,
  });

  @override
  State<TemplateDetailView> createState() => _TemplateDetailViewState();
}

class _TemplateDetailViewState extends State<TemplateDetailView> {
  String token = '';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) =>
          setState(() => token = state.authUser?.token ?? ''),
      listenWhen: (previous, current) =>
          previous.authUser?.token != current.authUser?.token,
      builder: (context, state) {
        token = state.authUser?.token ?? '';
        return MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => TemplateDetailBloc(
                    templatesRepository: RepositoryProvider.of(context))),
          ],
          child: TemplateDetailWidget(templateId: widget.templateId),
        );
      },
    );
  }
}

class TemplateDetailWidget extends StatefulWidget {
  final String templateId;
  const TemplateDetailWidget({
    super.key,
    required this.templateId,
  });

  @override
  State<TemplateDetailWidget> createState() => _TemplateDetailWidgetState();
}

class _TemplateDetailWidgetState extends State<TemplateDetailWidget> {
  late TemplateDetailBloc templatesBloc;

  static String pageTitle = 'Template';
  static String pageLabel = 'template';
  static String descriptionForDelete =
      'This item can not be deleted as it has sites assigned to it.';

  @override
  void initState() {
    templatesBloc = context.read<TemplateDetailBloc>()
      ..add(TemplateDetailTemplateLoadedById(templateId: widget.templateId))
      ..add(TemplateDetailSnapshotLoaded(templateId: widget.templateId));

    super.initState();
  }

  void _deleteTemplate(TemplateDetailState state) {
    templatesBloc
        .add(TemplateDetailTemplateDeleted(templateId: widget.templateId));
  }

  void _checkDeleteTemplateStatus(
      TemplateDetailState state, BuildContext context) {
    if (state.templateDeleteStatus.isSuccess) {
      CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: state.message,
      ).showNotification();

      GoRouter.of(context).go('/templates');
    }
    if (state.templateDeleteStatus.isFailure) {
      CustomNotification(
        context: context,
        notifyType: NotifyType.error,
        content: state.message,
      ).showNotification();
    }
  }

  final Widget _customDetailWidget = Column(
    mainAxisSize: MainAxisSize.min,
    children: const [
      TemplateView(),
      QuestionsView(),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TemplateDetailBloc, TemplateDetailState>(
      listener: (context, state) => _checkDeleteTemplateStatus(state, context),
      builder: (context, state) {
        return EntityShowTemplate(
          title: pageTitle,
          label: pageLabel,
          deleteEntity: () => _deleteTemplate(state),
          customDetailWidget: _customDetailWidget,
          entity: state.template,
          crudStatus: state.templateDeleteStatus,
          descriptionForDelete: descriptionForDelete,
        );
      },
    );
  }
}
